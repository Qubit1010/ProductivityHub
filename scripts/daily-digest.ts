/**
 * Morning email digest — run via `npm run digest` (Task Scheduler at 07:30 PKT).
 * Imports db functions directly (same pattern as db:seed — no dev server needed)
 * and sends through the already-OAuth'd `gws` CLI.
 * Logs to scripts/digest.log; exits non-zero on failure so Task Scheduler shows red.
 */
import { execFileSync } from "child_process";
import { appendFileSync } from "fs";
import { join } from "path";
import { db } from "../src/lib/db";
import { users, weeklyGoals, categories } from "../src/lib/db/schema";
import { asc, eq, and } from "drizzle-orm";
import {
  getTodayFocus,
  getInsights,
  getStreaks,
  getAnalyticsSummary,
} from "../src/lib/db/analytics";

const LOG = join(__dirname, "digest.log");
const log = (msg: string) =>
  appendFileSync(LOG, `[${new Date().toISOString()}] ${msg}\n`);

const fmtH = (min: number) => `${Math.round((min / 60) * 10) / 10}h`;

async function main() {
  // ponytail: PKT (UTC+5) offset hardcoded — single-user app, user lives in PKT
  const nowPkt = new Date(Date.now() + 5 * 3600e3);
  const today = nowPkt.toISOString().slice(0, 10);
  const isoDow = nowPkt.getUTCDay() === 0 ? 7 : nowPkt.getUTCDay();
  const weekStart = new Date(nowPkt.getTime() - (isoDow - 1) * 86400000)
    .toISOString()
    .slice(0, 10);

  // single-user app: first account is the owner
  const [user] = await db.select().from(users).orderBy(asc(users.createdAt)).limit(1);
  if (!user) throw new Error("No user found");
  const to = process.env.DIGEST_TO || user.email;

  const [focus, insights, streaks] = await Promise.all([
    getTodayFocus(user.id, today),
    getInsights(user.id, weekStart, today),
    getStreaks(user.id),
  ]);

  const lines: string[] = [];
  lines.push(`Good morning — ${today}`);
  lines.push("");
  lines.push(`Streak: ${streaks.currentStreak} days (best ${streaks.bestStreak})`);
  lines.push("");

  if (focus.yesterdayUndone.length > 0) {
    lines.push("Missed yesterday:");
    for (const t of focus.yesterdayUndone)
      lines.push(`  - [${t.code ?? "?"}] ${t.title} (${"*".repeat(t.starRating)})`);
    lines.push("");
  }

  if (focus.undoneToday.length > 0) {
    lines.push("Already planned today:");
    for (const t of focus.undoneToday)
      lines.push(`  - [${t.code ?? "?"}] ${t.title} (${"*".repeat(t.starRating)})`);
    lines.push("");
  }

  if (focus.goalsBehindPace.length > 0) {
    lines.push("Goals behind pace:");
    for (const g of focus.goalsBehindPace)
      lines.push(`  - ${g.code ?? "?"}: ${fmtH(g.deficit)} behind (${fmtH(g.actualMinutes)} / ${fmtH(g.targetMinutes)})`);
    lines.push("");
  }

  if (focus.agingBacklog.length > 0) {
    lines.push("Top backlog picks:");
    for (const b of focus.agingBacklog.slice(0, 3))
      lines.push(`  - [${b.code ?? "?"}] ${b.title} (${"*".repeat(b.starRating)}, ${b.ageDays}d old)`);
    lines.push("");
  }

  if (!insights.lowData && insights.insights.length > 0) {
    lines.push("This week so far:");
    for (const i of insights.insights.slice(0, 2)) lines.push(`  - ${i.text}`);
    lines.push("");
  }

  // Sunday weekly-review block (E3)
  if (isoDow === 7) {
    const week = await getAnalyticsSummary(user.id, weekStart, today);
    const cats = await db
      .select({ id: categories.id, code: categories.code })
      .from(categories)
      .where(eq(categories.userId, user.id));
    const codeById = new Map(cats.map((c) => [c.id, c.code]));
    const goals = await db
      .select()
      .from(weeklyGoals)
      .where(and(eq(weeklyGoals.userId, user.id), eq(weeklyGoals.weekStart, weekStart)));
    const actualByCat = new Map(week.categoryBreakdown.map((c) => [c.categoryId, c.minutes]));

    lines.push("--- Week in review ---");
    lines.push(`Total: ${fmtH(week.totalMinutes)} | Completion: ${week.completionRate}% (${week.tasksCompleted}/${week.tasksTotal})`);
    const top = [...week.categoryBreakdown].sort((a, b) => b.minutes - a.minutes).slice(0, 5);
    lines.push("Top categories:");
    for (const c of top) lines.push(`  - ${c.code}: ${fmtH(c.minutes)}`);
    if (goals.length > 0) {
      lines.push("Goals:");
      for (const g of goals) {
        const actual = actualByCat.get(g.categoryId) ?? 0;
        const hit = actual >= g.targetMinutes;
        lines.push(`  - ${codeById.get(g.categoryId) ?? "?"}: ${hit ? "HIT" : "MISSED"} (${fmtH(actual)} / ${fmtH(g.targetMinutes)})`);
      }
    }
    lines.push("");
  }

  lines.push(`Done this week: ${fmtH(focus.doneWeek.totalMinutes)} across ${focus.doneWeek.tasksTotal} tasks.`);

  const body = lines.join("\n");
  const subject = `Daily brief — ${today}${isoDow === 7 ? " (week in review)" : ""}`;

  // call the gws node entry directly — the .cmd shim + shell:true mangles
  // multiline --body args on Windows
  const gwsJs = join(
    process.env.APPDATA ?? "",
    "npm",
    "node_modules",
    "@googleworkspace",
    "cli",
    "run.js"
  );
  execFileSync(
    process.execPath,
    [gwsJs, "gmail", "+send", "--to", to, "--subject", subject, "--body", body],
    { stdio: "pipe" }
  );

  log(`OK sent to ${to} (${body.length} chars)`);
  console.log(`Digest sent to ${to}`);
  process.exit(0);
}

main().catch((e) => {
  log(`FAIL ${e?.message ?? e}`);
  console.error("Digest failed:", e);
  process.exit(1);
});
