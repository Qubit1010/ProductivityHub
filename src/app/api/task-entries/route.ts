import { NextRequest, NextResponse } from "next/server";
import { getServerSession } from "next-auth";
import { authConfig } from "@/lib/auth/config";
import { db } from "@/lib/db";
import { taskEntries, dailyLogs, categories } from "@/lib/db/schema";
import { eq, and, gte, lte, asc, inArray } from "drizzle-orm";
import { createTaskEntrySchema } from "@/lib/validators/task-entry";
import { computeDurationMinutes } from "@/lib/utils/csv-parser";

export async function GET(req: NextRequest) {
  try {
    const session = await getServerSession(authConfig);
    if (!session?.user) return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
    const userId = (session.user as { id: string }).id;

    const { searchParams } = new URL(req.url);
    const dailyLogId = searchParams.get("dailyLogId");
    const from = searchParams.get("from");
    const to = searchParams.get("to");

    if (dailyLogId) {
      const rows = await db
        .select({
          task: taskEntries,
          category: categories,
        })
        .from(taskEntries)
        .leftJoin(categories, eq(taskEntries.categoryId, categories.id))
        .where(and(eq(taskEntries.userId, userId), eq(taskEntries.dailyLogId, dailyLogId)))
        .orderBy(asc(taskEntries.sortOrder));
      const result = rows.map((r) => ({ ...r.task, category: r.category }));
      return NextResponse.json({ taskEntries: result });
    }

    if (from && to) {
      const logs = await db.select({ id: dailyLogs.id }).from(dailyLogs).where(and(eq(dailyLogs.userId, userId), gte(dailyLogs.logDate, from), lte(dailyLogs.logDate, to)));
      const logIds = logs.map((l) => l.id);
      if (logIds.length === 0) return NextResponse.json({ taskEntries: [] });
      const rows = await db
        .select({
          task: taskEntries,
          category: categories,
        })
        .from(taskEntries)
        .leftJoin(categories, eq(taskEntries.categoryId, categories.id))
        .where(and(eq(taskEntries.userId, userId), inArray(taskEntries.dailyLogId, logIds)))
        .orderBy(asc(taskEntries.sortOrder));
      const result = rows.map((r) => ({ ...r.task, category: r.category }));
      return NextResponse.json({ taskEntries: result });
    }

    return NextResponse.json({ error: "Provide dailyLogId or from/to params" }, { status: 400 });
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
    const parsed = createTaskEntrySchema.safeParse(body);
    if (!parsed.success) return NextResponse.json({ error: "Validation error", details: parsed.error.flatten() }, { status: 400 });

    let durationMinutes: number | null = null;
    if (parsed.data.timeStart && parsed.data.timeEnd) {
      durationMinutes = computeDurationMinutes(parsed.data.timeStart, parsed.data.timeEnd);
    }

    const [taskEntry] = await db.insert(taskEntries).values({
      ...parsed.data,
      userId,
      durationMinutes,
    }).returning();

    return NextResponse.json({ taskEntry }, { status: 201 });
  } catch {
    return NextResponse.json({ error: "Internal server error" }, { status: 500 });
  }
}
