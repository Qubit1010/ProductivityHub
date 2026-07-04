import { db } from "@/lib/db";
import { taskEntries, dailyLogs, categories, weeklyGoals, backlogItems } from "@/lib/db/schema";
import { eq, and, gte, lte, sql, desc, asc, inArray } from "drizzle-orm";
import { computeDurationMinutes } from "@/lib/utils/time";

export async function getAnalyticsSummary(userId: string, from: string, to: string) {
  const logs = await db
    .select({ id: dailyLogs.id, sprintStart: dailyLogs.sprintStart, sprintEnd: dailyLogs.sprintEnd })
    .from(dailyLogs)
    .where(and(eq(dailyLogs.userId, userId), gte(dailyLogs.logDate, from), lte(dailyLogs.logDate, to)));

  if (logs.length === 0) {
    return { totalMinutes: 0, tasksCompleted: 0, tasksTotal: 0, completionRate: 0, sprintUtilization: 0, categoryBreakdown: [] };
  }

  const logIds = logs.map((l) => l.id);

  const tasks = await db
    .select({
      categoryId: taskEntries.categoryId,
      code: categories.code,
      color: categories.color,
      durationMinutes: taskEntries.durationMinutes,
      isCompleted: taskEntries.isCompleted,
    })
    .from(taskEntries)
    .innerJoin(categories, eq(taskEntries.categoryId, categories.id))
    .where(and(eq(taskEntries.userId, userId), inArray(taskEntries.dailyLogId, logIds)));

  const totalMinutes = tasks.reduce((s, t) => s + (t.durationMinutes || 0), 0);
  const tasksCompleted = tasks.filter((t) => t.isCompleted).length;
  const tasksTotal = tasks.length;
  const completionRate = tasksTotal > 0 ? Math.round((tasksCompleted / tasksTotal) * 100) : 0;

  let totalSprintMinutes = 0;
  for (const log of logs) {
    if (log.sprintStart && log.sprintEnd) {
      // handles overnight sprints (e.g. 21:00 -> 06:00) via midnight wrap
      totalSprintMinutes += computeDurationMinutes(log.sprintStart, log.sprintEnd);
    }
  }
  const sprintUtilization = totalSprintMinutes > 0 ? Math.round((totalMinutes / totalSprintMinutes) * 100) : 0;

  const categoryMap = new Map<string, { categoryId: string; code: string; color: string; minutes: number }>();
  for (const t of tasks) {
    const existing = categoryMap.get(t.categoryId);
    if (existing) {
      existing.minutes += t.durationMinutes || 0;
    } else {
      categoryMap.set(t.categoryId, { categoryId: t.categoryId, code: t.code, color: t.color, minutes: t.durationMinutes || 0 });
    }
  }

  return {
    totalMinutes,
    tasksCompleted,
    tasksTotal,
    completionRate,
    sprintUtilization,
    categoryBreakdown: Array.from(categoryMap.values()),
  };
}

export async function getDailyBreakdown(userId: string, from: string, to: string) {
  const logs = await db
    .select()
    .from(dailyLogs)
    .where(and(eq(dailyLogs.userId, userId), gte(dailyLogs.logDate, from), lte(dailyLogs.logDate, to)))
    .orderBy(dailyLogs.logDate);

  const days = [];
  for (const log of logs) {
    const tasks = await db
      .select({
        categoryId: taskEntries.categoryId,
        code: categories.code,
        color: categories.color,
        durationMinutes: taskEntries.durationMinutes,
        isCompleted: taskEntries.isCompleted,
      })
      .from(taskEntries)
      .innerJoin(categories, eq(taskEntries.categoryId, categories.id))
      .where(eq(taskEntries.dailyLogId, log.id));

    const catMap = new Map<string, { categoryId: string; code: string; color: string; minutes: number }>();
    for (const t of tasks) {
      const existing = catMap.get(t.categoryId);
      if (existing) {
        existing.minutes += t.durationMinutes || 0;
      } else {
        catMap.set(t.categoryId, { categoryId: t.categoryId, code: t.code, color: t.color, minutes: t.durationMinutes || 0 });
      }
    }

    days.push({
      date: log.logDate,
      totalMinutes: tasks.reduce((s, t) => s + (t.durationMinutes || 0), 0),
      tasksCompleted: tasks.filter((t) => t.isCompleted).length,
      tasksTotal: tasks.length,
      categories: Array.from(catMap.values()),
    });
  }

  return { days };
}

export async function getCategoryTrends(userId: string, from: string, to: string) {
  const userCategories = await db
    .select({ id: categories.id, code: categories.code, color: categories.color })
    .from(categories)
    .where(eq(categories.userId, userId));

  const trends = [];
  for (const cat of userCategories) {
    const dataPoints = await db
      .select({
        date: dailyLogs.logDate,
        minutes: sql<number>`COALESCE(SUM(${taskEntries.durationMinutes}), 0)`,
      })
      .from(taskEntries)
      .innerJoin(dailyLogs, eq(taskEntries.dailyLogId, dailyLogs.id))
      .where(
        and(
          eq(taskEntries.userId, userId),
          eq(taskEntries.categoryId, cat.id),
          gte(dailyLogs.logDate, from),
          lte(dailyLogs.logDate, to)
        )
      )
      .groupBy(dailyLogs.logDate)
      .orderBy(dailyLogs.logDate);

    if (dataPoints.length > 0) {
      trends.push({
        categoryId: cat.id,
        code: cat.code,
        color: cat.color,
        dataPoints: dataPoints.map((dp) => ({ date: dp.date, minutes: Number(dp.minutes) })),
      });
    }
  }

  return { trends };
}

export async function getHourlyDistribution(userId: string, from: string, to: string) {
  const result = await db
    .select({
      hour: sql<number>`EXTRACT(HOUR FROM ${taskEntries.timeStart}::time)`,
      totalMinutes: sql<number>`COALESCE(SUM(${taskEntries.durationMinutes}), 0)`,
      taskCount: sql<number>`COUNT(*)`,
    })
    .from(taskEntries)
    .innerJoin(dailyLogs, eq(taskEntries.dailyLogId, dailyLogs.id))
    .where(
      and(
        eq(taskEntries.userId, userId),
        gte(dailyLogs.logDate, from),
        lte(dailyLogs.logDate, to),
        sql`${taskEntries.timeStart} IS NOT NULL`
      )
    )
    .groupBy(sql`EXTRACT(HOUR FROM ${taskEntries.timeStart}::time)`)
    .orderBy(sql`EXTRACT(HOUR FROM ${taskEntries.timeStart}::time)`);

  return {
    hours: result.map((r) => ({
      hour: Number(r.hour),
      totalMinutes: Number(r.totalMinutes),
      taskCount: Number(r.taskCount),
    })),
  };
}

export async function getStreaks(userId: string) {
  const activeDays = await db
    .select({ logDate: dailyLogs.logDate })
    .from(dailyLogs)
    .innerJoin(taskEntries, eq(taskEntries.dailyLogId, dailyLogs.id))
    .where(and(eq(dailyLogs.userId, userId), eq(taskEntries.isCompleted, true)))
    .groupBy(dailyLogs.logDate)
    .orderBy(desc(dailyLogs.logDate));

  if (activeDays.length === 0) {
    return { currentStreak: 0, bestStreak: 0, lastActiveDate: null };
  }

  const dates = activeDays.map((d) => new Date(d.logDate));
  let bestStreak = 1;
  let streak = 1;

  const today = new Date();
  today.setHours(0, 0, 0, 0);
  const lastActive = new Date(dates[0]);
  lastActive.setHours(0, 0, 0, 0);

  const diffDays = Math.floor((today.getTime() - lastActive.getTime()) / (1000 * 60 * 60 * 24));
  const isCurrentActive = diffDays <= 1;

  for (let i = 1; i < dates.length; i++) {
    const prev = new Date(dates[i - 1]);
    const curr = new Date(dates[i]);
    prev.setHours(0, 0, 0, 0);
    curr.setHours(0, 0, 0, 0);
    const diff = Math.floor((prev.getTime() - curr.getTime()) / (1000 * 60 * 60 * 24));
    if (diff === 1) {
      streak++;
      bestStreak = Math.max(bestStreak, streak);
    } else {
      streak = 1;
    }
  }
  bestStreak = Math.max(bestStreak, streak);

  let currentStreak = 0;
  if (isCurrentActive) {
    currentStreak = 1;
    for (let i = 1; i < dates.length; i++) {
      const prev = new Date(dates[i - 1]);
      const curr = new Date(dates[i]);
      prev.setHours(0, 0, 0, 0);
      curr.setHours(0, 0, 0, 0);
      const diff = Math.floor((prev.getTime() - curr.getTime()) / (1000 * 60 * 60 * 24));
      if (diff === 1) currentStreak++;
      else break;
    }
  }

  return {
    currentStreak,
    bestStreak,
    lastActiveDate: activeDays[0].logDate,
  };
}

// ---------------------------------------------------------------------------
// Insights (rule-based, computed on read — no table)
// ---------------------------------------------------------------------------

// category-type rollups used by the insight rules
const DEEP_TYPES = new Set(["work", "business", "tech", "freelance", "priority"]);
const LEARNING_TYPES = new Set(["education", "learning"]);
const LOW_LEVERAGE_TYPES = new Set(["marketing", "personal", "general"]);
void LEARNING_TYPES; // reserved for future rules

type Insight = { id: string; severity: "good" | "info" | "warn"; text: string };

const h = (min: number) => Math.round((min / 60) * 10) / 10; // minutes -> hours, 1dp
const pp = (n: number) => Math.round(n); // percentage points

/** minutes logged per date in range — one grouped query (rules 5 + 6) */
async function getMinutesPerDate(userId: string, from: string, to: string) {
  const rows = await db
    .select({
      logDate: dailyLogs.logDate,
      minutes: sql<number>`COALESCE(SUM(${taskEntries.durationMinutes}), 0)`,
    })
    .from(dailyLogs)
    .leftJoin(taskEntries, eq(taskEntries.dailyLogId, dailyLogs.id))
    .where(and(eq(dailyLogs.userId, userId), gte(dailyLogs.logDate, from), lte(dailyLogs.logDate, to)))
    .groupBy(dailyLogs.logDate);
  return rows.map((r) => ({ date: r.logDate, minutes: Number(r.minutes) }));
}

/** task counts + minutes grouped by starRating x isCompleted, excluding rolled-over copies (rules 8, 10, 11) */
async function getStarStats(userId: string, from: string, to: string) {
  const rows = await db
    .select({
      starRating: taskEntries.starRating,
      isCompleted: taskEntries.isCompleted,
      count: sql<number>`COUNT(*)`,
      minutes: sql<number>`COALESCE(SUM(${taskEntries.durationMinutes}), 0)`,
    })
    .from(taskEntries)
    .innerJoin(dailyLogs, eq(taskEntries.dailyLogId, dailyLogs.id))
    .where(
      and(
        eq(taskEntries.userId, userId),
        gte(dailyLogs.logDate, from),
        lte(dailyLogs.logDate, to),
        eq(taskEntries.isRolledOver, false)
      )
    )
    .groupBy(taskEntries.starRating, taskEntries.isCompleted);
  const stats = { totalCount: 0, completedCount: 0, totalMinutes: 0, threeStarMinutes: 0, threeStarUndone: 0 };
  for (const r of rows) {
    const count = Number(r.count);
    const minutes = Number(r.minutes);
    stats.totalCount += count;
    stats.totalMinutes += minutes;
    if (r.isCompleted) stats.completedCount += count;
    if (r.starRating === 3) {
      stats.threeStarMinutes += minutes;
      if (!r.isCompleted) stats.threeStarUndone += count;
    }
  }
  return stats;
}

export async function getInsights(userId: string, from: string, to: string) {
  // previous period = equal-length window ending the day before `from`
  const fromD = new Date(from + "T00:00:00Z");
  const toD = new Date(to + "T00:00:00Z");
  const daySpan = Math.round((toD.getTime() - fromD.getTime()) / 86400000) + 1;
  const prevToD = new Date(fromD.getTime() - 86400000);
  const prevFromD = new Date(prevToD.getTime() - (daySpan - 1) * 86400000);
  const prevFrom = prevFromD.toISOString().slice(0, 10);
  const prevTo = prevToD.toISOString().slice(0, 10);

  const [cur, prev, curCats, perDate, starCur, starPrev] = await Promise.all([
    getAnalyticsSummary(userId, from, to),
    getAnalyticsSummary(userId, prevFrom, prevTo),
    db.select({ id: categories.id, name: categories.name, code: categories.code, type: categories.type }).from(categories).where(eq(categories.userId, userId)),
    getMinutesPerDate(userId, from, to),
    getStarStats(userId, from, to),
    getStarStats(userId, prevFrom, prevTo),
  ]);

  const catById = new Map(curCats.map((c) => [c.id, c]));
  const topCat = (s: typeof cur) =>
    s.categoryBreakdown.length
      ? s.categoryBreakdown.reduce((a, b) => (b.minutes > a.minutes ? b : a))
      : null;

  const comparison = {
    current: { from, to, totalMinutes: cur.totalMinutes, completionRate: cur.completionRate, topCategory: topCat(cur) },
    previous: { from: prevFrom, to: prevTo, totalMinutes: prev.totalMinutes, completionRate: prev.completionRate, topCategory: topCat(prev) },
  };

  // global low-data gate (F6)
  const loggedDays = perDate.filter((d) => d.minutes > 0).length;
  if (loggedDays < 3 || cur.totalMinutes < 300) {
    return { lowData: true, insights: [] as Insight[], comparison };
  }

  const hasPrev = prev.totalMinutes >= 60; // delta-rule suppression
  const insights: Insight[] = [];
  const pctOf = (minutes: number, total: number) => (total > 0 ? (minutes / total) * 100 : 0);
  const prevPctByCat = new Map(prev.categoryBreakdown.map((c) => [c.categoryId, pctOf(c.minutes, prev.totalMinutes)]));

  // 1. top time sink + delta
  const top = comparison.current.topCategory;
  if (top) {
    const curPct = pctOf(top.minutes, cur.totalMinutes);
    const name = catById.get(top.categoryId)?.name ?? top.code;
    let text = `${name}: ${pp(curPct)}% of logged time (${h(top.minutes)}h)`;
    if (hasPrev) {
      const d = curPct - (prevPctByCat.get(top.categoryId) ?? 0);
      if (Math.abs(d) >= 1) text += `, ${d > 0 ? "up" : "down"} ${pp(Math.abs(d))}pp vs last period`;
    }
    insights.push({ id: "top-sink", severity: "info", text });
  }

  // 2. biggest riser / faller (>= 5pp)
  if (hasPrev) {
    let riser: { name: string; d: number } | null = null;
    let faller: { name: string; d: number } | null = null;
    for (const c of cur.categoryBreakdown) {
      const d = pctOf(c.minutes, cur.totalMinutes) - (prevPctByCat.get(c.categoryId) ?? 0);
      const name = catById.get(c.categoryId)?.name ?? c.code;
      if (d >= 5 && (!riser || d > riser.d)) riser = { name, d };
      if (d <= -5 && (!faller || d < faller.d)) faller = { name, d };
    }
    const parts = [
      ...(riser ? [`${riser.name} up ${pp(riser.d)}pp`] : []),
      ...(faller ? [`${faller.name} down ${pp(Math.abs(faller.d))}pp`] : []),
    ];
    if (parts.length) insights.push({ id: "riser-faller", severity: "info", text: parts.join("; ") + " vs last period" });
  }

  // 3. deep-work ratio
  if (hasPrev) {
    const deepMin = (s: typeof cur) => s.categoryBreakdown.reduce((sum, c) => sum + (DEEP_TYPES.has(catById.get(c.categoryId)?.type ?? "") ? c.minutes : 0), 0);
    const curRatio = pctOf(deepMin(cur), cur.totalMinutes);
    const prevRatio = pctOf(deepMin(prev), prev.totalMinutes);
    const d = curRatio - prevRatio;
    if (d <= -5) insights.push({ id: "deep-work", severity: "warn", text: `Deep work fell ${pp(prevRatio)}% -> ${pp(curRatio)}% of logged time` });
    else if (d >= 5) insights.push({ id: "deep-work", severity: "good", text: `Deep work rose ${pp(prevRatio)}% -> ${pp(curRatio)}% of logged time` });
  }

  // 4. waste watch (LOW_LEVERAGE types or name ~ waste|distract)
  {
    const isWaste = (catId: string) => {
      const c = catById.get(catId);
      return c ? LOW_LEVERAGE_TYPES.has(c.type) || /waste|distract/i.test(c.name) : false;
    };
    const wasteCur = cur.categoryBreakdown.reduce((s, c) => s + (isWaste(c.categoryId) ? c.minutes : 0), 0);
    if (wasteCur >= 60) {
      const wastePrev = prev.categoryBreakdown.reduce((s, c) => s + (isWaste(c.categoryId) ? c.minutes : 0), 0);
      const delta = hasPrev ? wasteCur - wastePrev : 0;
      const deltaTxt = hasPrev && Math.abs(delta) >= 30 ? ` (${delta > 0 ? "+" : "-"}${h(Math.abs(delta))}h vs last period)` : "";
      insights.push({ id: "waste-watch", severity: delta > 0 ? "warn" : "info", text: `Low-leverage time: ${h(wasteCur)}h${deltaTxt}` });
    }
  }

  // 5. best weekday (skip if range < 14 days)
  if (daySpan >= 14) {
    const byDow = new Map<number, { total: number; n: number }>();
    for (const d of perDate) {
      const dow = new Date(d.date + "T00:00:00Z").getUTCDay();
      const e = byDow.get(dow) ?? { total: 0, n: 0 };
      e.total += d.minutes; e.n += 1;
      byDow.set(dow, e);
    }
    let best: { dow: number; avg: number } | null = null;
    byDow.forEach((v, k) => { const avg = v.total / v.n; if (!best || avg > best.avg) best = { dow: k, avg }; });
    if (best !== null) {
      const bestDay = best as { dow: number; avg: number };
      const names = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"];
      insights.push({ id: "best-weekday", severity: "good", text: `${names[bestDay.dow]} is your most productive day (${h(bestDay.avg)}h logged on average)` });
    }
  }

  // 6. zero days — logged dates vs day-span (grouped query, no N+1)
  {
    const zeroDays = daySpan - loggedDays;
    if (zeroDays > 0) insights.push({ id: "zero-days", severity: zeroDays >= 3 ? "warn" : "info", text: `${zeroDays} day${zeroDays > 1 ? "s" : ""} with nothing logged in this period` });
  }

  // 7. sprint adherence trend — 3 consecutive weekly declines (trailing 21 days)
  {
    const today = new Date();
    const t21 = new Date(today.getTime() - 20 * 86400000);
    const adh = await getSprintAdherence(userId, t21.toISOString().slice(0, 10), today.toISOString().slice(0, 10));
    const weeks: number[][] = [[], [], []];
    for (const d of adh.days) {
      if (d.sprintMinutes <= 0) continue;
      const age = Math.floor((today.getTime() - new Date(d.date + "T00:00:00Z").getTime()) / 86400000);
      const w = Math.min(2, Math.floor(age / 7)); // 0 = this week, 2 = oldest
      weeks[w].push(d.adherencePercent);
    }
    const avg = (a: number[]) => (a.length ? a.reduce((x, y) => x + y, 0) / a.length : null);
    const [w0, w1, w2] = [avg(weeks[0]), avg(weeks[1]), avg(weeks[2])];
    if (w0 !== null && w1 !== null && w2 !== null && w0 < w1 && w1 < w2) {
      insights.push({ id: "sprint-trend", severity: "warn", text: `Sprint adherence declining 3 weeks straight: ${pp(w2)}% -> ${pp(w1)}% -> ${pp(w0)}%` });
    }
  }

  // 8. completion rate delta (rolled-over copies excluded)
  if (hasPrev && starPrev.totalCount > 0 && starCur.totalCount > 0) {
    const curRate = (starCur.completedCount / starCur.totalCount) * 100;
    const prevRate = (starPrev.completedCount / starPrev.totalCount) * 100;
    const d = curRate - prevRate;
    if (d >= 5) insights.push({ id: "completion-delta", severity: "good", text: `Completion rate up ${pp(prevRate)}% -> ${pp(curRate)}%` });
    else if (d <= -5) insights.push({ id: "completion-delta", severity: "warn", text: `Completion rate down ${pp(prevRate)}% -> ${pp(curRate)}%` });
  }

  // 9. volume delta
  {
    let text = `${h(cur.totalMinutes)}h logged this period`;
    if (hasPrev) {
      const d = cur.totalMinutes - prev.totalMinutes;
      if (Math.abs(d) >= 60) text += `, ${d > 0 ? "up" : "down"} ${h(Math.abs(d))}h vs last period`;
    }
    insights.push({ id: "volume", severity: "info", text });
  }

  // 10. 3-star focus share
  if (starCur.totalMinutes > 0) {
    const curShare = (starCur.threeStarMinutes / starCur.totalMinutes) * 100;
    if (hasPrev && starPrev.totalMinutes > 0) {
      const prevShare = (starPrev.threeStarMinutes / starPrev.totalMinutes) * 100;
      const d = curShare - prevShare;
      if (d <= -5) insights.push({ id: "three-star-share", severity: "warn", text: `Only ${pp(curShare)}% of time on 3-star tasks, down from ${pp(prevShare)}%` });
      else if (d >= 5) insights.push({ id: "three-star-share", severity: "good", text: `${pp(curShare)}% of time on 3-star tasks, up from ${pp(prevShare)}%` });
    } else if (curShare < 20) {
      insights.push({ id: "three-star-share", severity: "warn", text: `Only ${pp(curShare)}% of logged time went to 3-star tasks` });
    }
  }

  // 11. 3-star undone count
  if (starCur.threeStarUndone > 0) {
    insights.push({ id: "three-star-undone", severity: "warn", text: `${starCur.threeStarUndone} three-star task${starCur.threeStarUndone > 1 ? "s" : ""} left undone this period` });
  }

  // 12. doubling category (cur >= 2x prev, prev >= 60min)
  if (hasPrev) {
    const prevMinByCat = new Map(prev.categoryBreakdown.map((c) => [c.categoryId, c.minutes]));
    for (const c of cur.categoryBreakdown) {
      const p = prevMinByCat.get(c.categoryId) ?? 0;
      if (p >= 60 && c.minutes >= 2 * p) {
        const name = catById.get(c.categoryId)?.name ?? c.code;
        insights.push({ id: `doubling-${c.code}`, severity: "info", text: `${name} more than doubled: ${h(p)}h -> ${h(c.minutes)}h` });
        break; // one is enough signal
      }
    }
  }

  // 13. goal pacing (only when the range is exactly the current week)
  {
    // ponytail: PKT (UTC+5) offset hardcoded — single-user app, user lives in PKT
    const nowPkt = new Date(Date.now() + 5 * 3600e3);
    const todayPkt = nowPkt.toISOString().slice(0, 10);
    const isoDow = nowPkt.getUTCDay() === 0 ? 7 : nowPkt.getUTCDay();
    if (from <= todayPkt && todayPkt <= to && daySpan === 7) {
      const goals = await db
        .select({ categoryId: weeklyGoals.categoryId, targetMinutes: weeklyGoals.targetMinutes })
        .from(weeklyGoals)
        .where(and(eq(weeklyGoals.userId, userId), eq(weeklyGoals.weekStart, from)));
      const actualByCat = new Map(cur.categoryBreakdown.map((c) => [c.categoryId, c.minutes]));
      const behind = goals
        .map((g) => ({ ...g, deficit: Math.round((g.targetMinutes * isoDow) / 7) - (actualByCat.get(g.categoryId) ?? 0) }))
        .filter((g) => g.deficit > 0)
        .sort((a, b) => b.deficit - a.deficit);
      for (const g of behind.slice(0, 2)) {
        const code = catById.get(g.categoryId)?.code ?? "?";
        insights.push({ id: `goal-pace-${code}`, severity: "warn", text: `${code} is ${h(g.deficit)}h behind weekly pace` });
      }
    }
  }

  // warns first, then info, then good
  const order = { warn: 0, info: 1, good: 2 };
  insights.sort((a, b) => order[a.severity] - order[b.severity]);

  return { lowData: false, insights, comparison };
}

export async function getSprintAdherence(userId: string, from: string, to: string) {
  const logs = await db
    .select()
    .from(dailyLogs)
    .where(and(eq(dailyLogs.userId, userId), gte(dailyLogs.logDate, from), lte(dailyLogs.logDate, to)))
    .orderBy(dailyLogs.logDate);

  const days = [];
  for (const log of logs) {
    let sprintMinutes = 0;
    if (log.sprintStart && log.sprintEnd) {
      // handles overnight sprints (e.g. 21:00 -> 06:00) via midnight wrap
      sprintMinutes = computeDurationMinutes(log.sprintStart, log.sprintEnd);
    }

    const tasks = await db
      .select({ durationMinutes: taskEntries.durationMinutes })
      .from(taskEntries)
      .where(eq(taskEntries.dailyLogId, log.id));

    const actualMinutes = tasks.reduce((s, t) => s + (t.durationMinutes || 0), 0);
    const adherencePercent = sprintMinutes > 0 ? Math.round((actualMinutes / sprintMinutes) * 100) : 0;

    days.push({
      date: log.logDate,
      sprintMinutes,
      actualMinutes,
      adherencePercent,
    });
  }

  return { days };
}

// ---------------------------------------------------------------------------
// Today's Focus (what matters today + done-awareness)
// ---------------------------------------------------------------------------

export async function getTodayFocus(userId: string, date: string) {
  const d = new Date(date + "T00:00:00Z");
  const yesterday = new Date(d.getTime() - 86400000).toISOString().slice(0, 10);
  const isoDow = d.getUTCDay() === 0 ? 7 : d.getUTCDay();
  const weekStartD = new Date(d.getTime() - (isoDow - 1) * 86400000);
  const weekStart = weekStartD.toISOString().slice(0, 10);
  const weekEnd = new Date(weekStartD.getTime() + 6 * 86400000).toISOString().slice(0, 10);

  const undoneFor = (day: string) =>
    db
      .select({
        id: taskEntries.id,
        title: taskEntries.title,
        starRating: taskEntries.starRating,
        categoryId: taskEntries.categoryId,
        code: categories.code,
        color: categories.color,
      })
      .from(taskEntries)
      .innerJoin(dailyLogs, eq(taskEntries.dailyLogId, dailyLogs.id))
      .leftJoin(categories, eq(taskEntries.categoryId, categories.id))
      .where(
        and(
          eq(taskEntries.userId, userId),
          eq(dailyLogs.logDate, day),
          eq(taskEntries.isCompleted, false)
        )
      )
      .orderBy(desc(taskEntries.starRating), asc(taskEntries.sortOrder));

  const [undoneToday, yesterdayUndone, backlog, goals, doneToday, weekSummary] =
    await Promise.all([
      undoneFor(date),
      undoneFor(yesterday),
      db
        .select({
          id: backlogItems.id,
          title: backlogItems.title,
          starRating: backlogItems.starRating,
          categoryId: backlogItems.categoryId,
          createdAt: backlogItems.createdAt,
          code: categories.code,
          color: categories.color,
        })
        .from(backlogItems)
        .leftJoin(categories, eq(backlogItems.categoryId, categories.id))
        .where(and(eq(backlogItems.userId, userId), eq(backlogItems.isActive, true))),
      db
        .select({ categoryId: weeklyGoals.categoryId, targetMinutes: weeklyGoals.targetMinutes })
        .from(weeklyGoals)
        .where(and(eq(weeklyGoals.userId, userId), eq(weeklyGoals.weekStart, weekStart))),
      getAnalyticsSummary(userId, date, date),
      getAnalyticsSummary(userId, weekStart, weekEnd),
    ]);

  // age cap of 30 days stops ancient 1-stars outranking fresh 3-stars
  const now = d.getTime();
  const agingBacklog = backlog
    .map((b) => {
      const ageDays = Math.max(1, Math.floor((now - new Date(b.createdAt).getTime()) / 86400000));
      return { ...b, ageDays, score: b.starRating * Math.min(ageDays, 30) };
    })
    .sort((a, b) => b.score - a.score)
    .slice(0, 5);

  const actualByCat = new Map(weekSummary.categoryBreakdown.map((c) => [c.categoryId, c.minutes]));
  const catCodes = new Map(weekSummary.categoryBreakdown.map((c) => [c.categoryId, c.code]));
  const goalsBehindPace = goals
    .map((g) => ({
      categoryId: g.categoryId,
      code: catCodes.get(g.categoryId) ?? null,
      targetMinutes: g.targetMinutes,
      actualMinutes: actualByCat.get(g.categoryId) ?? 0,
      deficit: Math.round((g.targetMinutes * isoDow) / 7) - (actualByCat.get(g.categoryId) ?? 0),
    }))
    .filter((g) => g.deficit > 0)
    .sort((a, b) => b.deficit - a.deficit);

  return {
    date,
    undoneToday,
    yesterdayUndone,
    agingBacklog,
    goalsBehindPace,
    doneToday: {
      tasksCompleted: doneToday.tasksCompleted,
      tasksTotal: doneToday.tasksTotal,
      totalMinutes: doneToday.totalMinutes,
    },
    doneWeek: {
      tasksCompleted: weekSummary.tasksCompleted,
      tasksTotal: weekSummary.tasksTotal,
      totalMinutes: weekSummary.totalMinutes,
    },
  };
}
