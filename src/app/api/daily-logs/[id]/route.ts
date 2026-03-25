import { NextRequest, NextResponse } from "next/server";
import { getServerSession } from "next-auth";
import { authConfig } from "@/lib/auth/config";
import { db } from "@/lib/db";
import { dailyLogs } from "@/lib/db/schema";
import { eq, and } from "drizzle-orm";
import { updateDailyLogSchema } from "@/lib/validators/daily-log";

export async function GET(_req: NextRequest, { params }: { params: { id: string } }) {
  try {
    const session = await getServerSession(authConfig);
    if (!session?.user) return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
    const userId = (session.user as { id: string }).id;

    const [dailyLog] = await db.select().from(dailyLogs).where(and(eq(dailyLogs.id, params.id), eq(dailyLogs.userId, userId))).limit(1);
    if (!dailyLog) return NextResponse.json({ error: "Not found" }, { status: 404 });
    return NextResponse.json({ dailyLog });
  } catch {
    return NextResponse.json({ error: "Internal server error" }, { status: 500 });
  }
}

export async function PUT(req: NextRequest, { params }: { params: { id: string } }) {
  try {
    const session = await getServerSession(authConfig);
    if (!session?.user) return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
    const userId = (session.user as { id: string }).id;

    const body = await req.json();
    const parsed = updateDailyLogSchema.safeParse(body);
    if (!parsed.success) return NextResponse.json({ error: "Validation error" }, { status: 400 });

    const [dailyLog] = await db.update(dailyLogs).set({ ...parsed.data, updatedAt: new Date() }).where(and(eq(dailyLogs.id, params.id), eq(dailyLogs.userId, userId))).returning();
    if (!dailyLog) return NextResponse.json({ error: "Not found" }, { status: 404 });
    return NextResponse.json({ dailyLog });
  } catch {
    return NextResponse.json({ error: "Internal server error" }, { status: 500 });
  }
}
