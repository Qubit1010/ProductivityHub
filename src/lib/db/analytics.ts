import { db } from "@/lib/db";
import { taskEntries, dailyLogs, categories } from "@/lib/db/schema";
import { eq, and, gte, lte, sql, desc, inArray } from "drizzle-orm";

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
      const [sh, sm] = log.sprintStart.split(":").map(Number);
      const [eh, em] = log.sprintEnd.split(":").map(Number);
      totalSprintMinutes += (eh * 60 + em) - (sh * 60 + sm);
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
      const [sh, sm] = log.sprintStart.split(":").map(Number);
      const [eh, em] = log.sprintEnd.split(":").map(Number);
      sprintMinutes = (eh * 60 + em) - (sh * 60 + sm);
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
