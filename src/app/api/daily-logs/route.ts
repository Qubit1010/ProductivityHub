import { NextRequest, NextResponse } from "next/server";
import { getServerSession } from "next-auth";
import { authConfig } from "@/lib/auth/config";
import { db } from "@/lib/db";
import { dailyLogs } from "@/lib/db/schema";
import { eq, and, gte, lte } from "drizzle-orm";
import { createDailyLogSchema } from "@/lib/validators/daily-log";

export async function GET(req: NextRequest) {
  try {
    const session = await getServerSession(authConfig);
    if (!session?.user) return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
    const userId = (session.user as { id: string }).id;

    const { searchParams } = new URL(req.url);
    const date = searchParams.get("date");
    const from = searchParams.get("from");
    const to = searchParams.get("to");

    if (date) {
      const [dailyLog] = await db.select().from(dailyLogs).where(and(eq(dailyLogs.userId, userId), eq(dailyLogs.logDate, date))).limit(1);
      return NextResponse.json({ dailyLog: dailyLog || null });
    }

    if (from && to) {
      const result = await db.select().from(dailyLogs).where(and(eq(dailyLogs.userId, userId), gte(dailyLogs.logDate, from), lte(dailyLogs.logDate, to))).orderBy(dailyLogs.logDate);
      return NextResponse.json({ dailyLogs: result });
    }

    return NextResponse.json({ error: "Provide date or from/to params" }, { status: 400 });
  } catch {
    return NextResponse.json({ error: "Internal server error" }, { status: 500 });
  }
}

export async function POST(req: NextRequest) {
  try {
    const session = await getServerSession(authConfig);
    if (!session?.user) return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
    const userId = (session.user as { id: string }).id;

    const body = await req.json();
    const parsed = createDailyLogSchema.safeParse(body);
    if (!parsed.success) return NextResponse.json({ error: "Validation error", details: parsed.error.flatten() }, { status: 400 });

    // Upsert: return existing or create new
    const [existing] = await db.select().from(dailyLogs).where(and(eq(dailyLogs.userId, userId), eq(dailyLogs.logDate, parsed.data.logDate))).limit(1);
    if (existing) return NextResponse.json({ dailyLog: existing });

    const [dailyLog] = await db.insert(dailyLogs).values({ ...parsed.data, userId }).returning();
    return NextResponse.json({ dailyLog }, { status: 201 });
  } catch {
    return NextResponse.json({ error: "Internal server error" }, { status: 500 });
  }
}
