import { NextRequest, NextResponse } from "next/server";
import { getServerSession } from "next-auth";
import { authConfig } from "@/lib/auth/config";
import { db } from "@/lib/db";
import { weeklyGoals } from "@/lib/db/schema";
import { eq, and } from "drizzle-orm";
import { createWeeklyGoalSchema } from "@/lib/validators/weekly-goal";

export async function GET(req: NextRequest) {
  try {
    const session = await getServerSession(authConfig);
    if (!session?.user) return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
    const userId = (session.user as { id: string }).id;

    const { searchParams } = new URL(req.url);
    const weekStart = searchParams.get("weekStart");

    if (!weekStart) return NextResponse.json({ error: "weekStart param required" }, { status: 400 });

    const result = await db.select().from(weeklyGoals).where(and(eq(weeklyGoals.userId, userId), eq(weeklyGoals.weekStart, weekStart)));
    return NextResponse.json({ weeklyGoals: result });
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
    const parsed = createWeeklyGoalSchema.safeParse(body);
    if (!parsed.success) return NextResponse.json({ error: "Validation error", details: parsed.error.flatten() }, { status: 400 });

    const [goal] = await db.insert(weeklyGoals).values({ ...parsed.data, userId }).returning();
    return NextResponse.json({ weeklyGoal: goal }, { status: 201 });
  } catch {
    return NextResponse.json({ error: "Internal server error" }, { status: 500 });
  }
}
