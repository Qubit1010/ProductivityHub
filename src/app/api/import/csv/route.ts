import { NextRequest, NextResponse } from "next/server";
import { getServerSession } from "next-auth";
import { authConfig } from "@/lib/auth/config";
import { db } from "@/lib/db";
import { imports, dailyLogs, taskEntries, categories } from "@/lib/db/schema";
import { eq, and } from "drizzle-orm";
import { parseCustomCsv } from "@/lib/utils/csv-import-parser";

export async function POST(req: NextRequest) {
  try {
    const session = await getServerSession(authConfig);
    if (!session?.user) return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
    const userId = (session.user as { id: string }).id;

    const formData = await req.formData();
    const file = formData.get("file") as File;
    if (!file) return NextResponse.json({ error: "No file provided" }, { status: 400 });

    const text = await file.text();

    // Create import record
    const [importRecord] = await db.insert(imports).values({
      userId,
      filename: file.name,
      rowCount: 0,
      status: "processing",
    }).returning();

    // Parse the CSV
    const parseResult = parseCustomCsv(text);

    // Load user's existing categories
    const userCategories = await db.select().from(categories).where(eq(categories.userId, userId));
    const categoryMap = new Map<string, string>(); // lowercase code -> id
    for (const cat of userCategories) {
      categoryMap.set(cat.code.toLowerCase(), cat.id);
      categoryMap.set(cat.name.toLowerCase(), cat.id);
    }

    // Track daily logs: date -> id
    const dailyLogMap = new Map<string, string>();

    // Pre-fetch existing daily logs
    const dateSet = new Set(parseResult.tasks.map((t) => t.date));
    const uniqueDates = Array.from(dateSet);
    for (const d of uniqueDates) {
      const [existing] = await db
        .select()
        .from(dailyLogs)
        .where(and(eq(dailyLogs.userId, userId), eq(dailyLogs.logDate, d)))
        .limit(1);
      if (existing) {
        dailyLogMap.set(d, existing.id);
      }
    }

    let rowsImported = 0;
    let rowsSkipped = 0;
    const importErrors: string[] = [];

    for (const task of parseResult.tasks) {
      try {
        // Get or create daily log
        let dailyLogId = dailyLogMap.get(task.date);
        if (!dailyLogId) {
          const sprint = parseResult.sprintTimes[task.date];
          const [newLog] = await db
            .insert(dailyLogs)
            .values({
              userId,
              logDate: task.date,
              sprintStart: sprint?.start || null,
              sprintEnd: sprint?.end || null,
            })
            .onConflictDoNothing()
            .returning();
          if (newLog) {
            dailyLogId = newLog.id;
          } else {
            const [existingLog] = await db
              .select()
              .from(dailyLogs)
              .where(and(eq(dailyLogs.userId, userId), eq(dailyLogs.logDate, task.date)))
              .limit(1);
            dailyLogId = existingLog?.id;
          }
          if (dailyLogId) {
            dailyLogMap.set(task.date, dailyLogId);
          }
        }

        if (!dailyLogId) {
          rowsSkipped++;
          importErrors.push(`Could not create daily log for ${task.date}`);
          continue;
        }

        // Get or create category by code
        let categoryId = categoryMap.get(task.categoryCode.toLowerCase());
        if (!categoryId) {
          // Also try by name
          categoryId = categoryMap.get(task.categoryName.toLowerCase());
        }
        if (!categoryId) {
          const [newCat] = await db
            .insert(categories)
            .values({
              userId,
              code: task.categoryCode,
              name: task.categoryName,
              color: task.categoryColor,
              type: "general",
            })
            .onConflictDoNothing()
            .returning();
          if (newCat) {
            categoryId = newCat.id;
          } else {
            const [existingCat] = await db
              .select()
              .from(categories)
              .where(and(eq(categories.userId, userId), eq(categories.code, task.categoryCode)))
              .limit(1);
            categoryId = existingCat?.id;
          }
          if (categoryId) {
            categoryMap.set(task.categoryCode.toLowerCase(), categoryId);
            categoryMap.set(task.categoryName.toLowerCase(), categoryId);
          }
        }

        if (!categoryId) {
          rowsSkipped++;
          importErrors.push(`Could not resolve category "${task.categoryCode}" for "${task.title}"`);
          continue;
        }

        await db.insert(taskEntries).values({
          dailyLogId,
          userId,
          categoryId,
          title: task.title,
          starRating: task.starRating,
          tag: task.tag || null,
          timeStart: task.timeStart || null,
          timeEnd: task.timeEnd || null,
          durationMinutes: task.totalDurationMinutes || null,
          isCompleted: task.tag !== "missed",
          completedAt: task.tag !== "missed" ? new Date() : null,
          sortOrder: rowsImported,
        });

        rowsImported++;
      } catch (err) {
        rowsSkipped++;
        const msg = err instanceof Error ? err.message : String(err);
        importErrors.push(`Error importing "${task.title}" on ${task.date}: ${msg}`);
      }
    }

    rowsSkipped += parseResult.skippedRows;

    const [updated] = await db.update(imports).set({
      status: "complete",
      rowCount: parseResult.tasks.length + parseResult.skippedRows,
      rowsImported,
      rowsSkipped,
      errorLog: importErrors.length > 0 ? importErrors.join("\n") : null,
    }).where(eq(imports.id, importRecord.id)).returning();

    return NextResponse.json({ import: updated });
  } catch (err) {
    const msg = err instanceof Error ? err.message : "Internal server error";
    return NextResponse.json({ error: msg }, { status: 500 });
  }
}
