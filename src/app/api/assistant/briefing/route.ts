import { NextRequest, NextResponse } from "next/server";
import { timingSafeEqual } from "crypto";
import { db } from "@/lib/db";
import { users } from "@/lib/db/schema";
import { asc } from "drizzle-orm";
import {
  getTodayFocus,
  getStreaks,
  getAnalyticsSummary,
  getInsights,
} from "@/lib/db/analytics";

// Bearer-token endpoint for the Nexis assistant. NOT in middleware's protected
// matcher — this check is the only auth gate, do not remove it.
function isAuthorized(req: NextRequest): boolean {
  const token = process.env.ASSISTANT_TOKEN;
  if (!token) return false; // unset env must never mean open access
  const header = req.headers.get("authorization") ?? "";
  const provided = header.replace(/^Bearer\s+/i, "");
  const a = Buffer.from(provided);
  const b = Buffer.from(token);
  return a.length === b.length && timingSafeEqual(a, b);
}

export async function GET(req: NextRequest) {
  if (!isAuthorized(req)) {
    return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
  }

  try {
    const { searchParams } = new URL(req.url);
    // ponytail: PKT (UTC+5) offset hardcoded — caller passes ?date= as source of truth
    const date =
      searchParams.get("date") ??
      new Date(Date.now() + 5 * 3600e3).toISOString().slice(0, 10);

    // single-user app: first account is the owner
    const [user] = await db.select().from(users).orderBy(asc(users.createdAt)).limit(1);
    if (!user) return NextResponse.json({ error: "No user" }, { status: 500 });

    const d = new Date(date + "T00:00:00Z");
    const isoDow = d.getUTCDay() === 0 ? 7 : d.getUTCDay();
    const weekStart = new Date(d.getTime() - (isoDow - 1) * 86400000).toISOString().slice(0, 10);
    const weekEnd = new Date(d.getTime() + (7 - isoDow) * 86400000).toISOString().slice(0, 10);

    const [focus, streaks, weekSummary, insights] = await Promise.all([
      getTodayFocus(user.id, date),
      getStreaks(user.id),
      getAnalyticsSummary(user.id, weekStart, weekEnd),
      getInsights(user.id, weekStart, weekEnd),
    ]);

    return NextResponse.json({
      date,
      streak: { currentStreak: streaks.currentStreak, bestStreak: streaks.bestStreak },
      focus: {
        undoneToday: focus.undoneToday,
        agingBacklog: focus.agingBacklog,
        goalsBehindPace: focus.goalsBehindPace,
        yesterdayUndone: focus.yesterdayUndone,
      },
      doneToday: focus.doneToday,
      weekSummary: {
        totalMinutes: weekSummary.totalMinutes,
        completionRate: weekSummary.completionRate,
        topCategories: [...weekSummary.categoryBreakdown]
          .sort((a, b) => b.minutes - a.minutes)
          .slice(0, 5),
      },
      insights: insights.lowData ? [] : insights.insights.map((i) => i.text),
    });
  } catch {
    return NextResponse.json({ error: "Internal server error" }, { status: 500 });
  }
}
