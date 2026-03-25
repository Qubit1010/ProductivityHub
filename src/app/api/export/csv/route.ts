import { NextRequest, NextResponse } from "next/server";
import { getServerSession } from "next-auth";
import { authConfig } from "@/lib/auth/config";
import { db } from "@/lib/db";
import { taskEntries, dailyLogs, categories } from "@/lib/db/schema";
import { eq, and, gte, lte } from "drizzle-orm";

export async function GET(req: NextRequest) {
  try {
    const session = await getServerSession(authConfig);
    if (!session?.user) return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
    const userId = (session.user as { id: string }).id;

    const { searchParams } = new URL(req.url);
    const from = searchParams.get("from");
    const to = searchParams.get("to");
    if (!from || !to) return NextResponse.json({ error: "from and to params required" }, { status: 400 });

    const logs = await db.select().from(dailyLogs).where(and(eq(dailyLogs.userId, userId), gte(dailyLogs.logDate, from), lte(dailyLogs.logDate, to))).orderBy(dailyLogs.logDate);

    const rows: string[][] = [["Date", "Category", "Task", "Time Start", "Time End", "Duration (min)", "Rating", "Tag", "Completed"]];

    for (const log of logs) {
      const tasks = await db
        .select({
          title: taskEntries.title,
          timeStart: taskEntries.timeStart,
          timeEnd: taskEntries.timeEnd,
          durationMinutes: taskEntries.durationMinutes,
          starRating: taskEntries.starRating,
          tag: taskEntries.tag,
          isCompleted: taskEntries.isCompleted,
          categoryCode: categories.code,
        })
        .from(taskEntries)
        .innerJoin(categories, eq(taskEntries.categoryId, categories.id))
        .where(eq(taskEntries.dailyLogId, log.id));

      for (const task of tasks) {
        rows.push([
          log.logDate,
          task.categoryCode,
          task.title,
          task.timeStart || "",
          task.timeEnd || "",
          String(task.durationMinutes || ""),
          "\u2605".repeat(task.starRating),
          task.tag || "",
          task.isCompleted ? "Yes" : "No",
        ]);
      }
    }

    const csv = rows.map((row) => row.map((cell) => `"${cell.replace(/"/g, '""')}"`).join(",")).join("\n");

    return new NextResponse(csv, {
      headers: {
        "Content-Type": "text/csv",
        "Content-Disposition": `attachment; filename="export-${from}-to-${to}.csv"`,
      },
    });
  } catch {
    return NextResponse.json({ error: "Internal server error" }, { status: 500 });
  }
}
