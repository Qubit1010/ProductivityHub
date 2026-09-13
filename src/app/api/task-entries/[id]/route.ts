import { NextRequest, NextResponse } from "next/server";
import { getServerSession } from "next-auth";
import { authConfig } from "@/lib/auth/config";
import { db } from "@/lib/db";
import { taskEntries, backlogItems } from "@/lib/db/schema";
import { eq, and, ne } from "drizzle-orm";
import { updateTaskEntrySchema } from "@/lib/validators/task-entry";
import { computeDurationMinutes } from "@/lib/utils/csv-parser";

export async function GET(_req: NextRequest, { params }: { params: { id: string } }) {
  try {
    const session = await getServerSession(authConfig);
    if (!session?.user) return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
    const userId = (session.user as { id: string }).id;

    const [entry] = await db.select().from(taskEntries).where(and(eq(taskEntries.id, params.id), eq(taskEntries.userId, userId))).limit(1);
    if (!entry) return NextResponse.json({ error: "Not found" }, { status: 404 });
    return NextResponse.json({ taskEntry: entry });
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
    const parsed = updateTaskEntrySchema.safeParse(body);
    if (!parsed.success) return NextResponse.json({ error: "Validation error" }, { status: 400 });

    const updateData: Record<string, unknown> = { ...parsed.data, updatedAt: new Date() };

    // Recalculate duration if time changed
    if (parsed.data.timeStart !== undefined || parsed.data.timeEnd !== undefined) {
      const [current] = await db.select().from(taskEntries).where(eq(taskEntries.id, params.id)).limit(1);
      if (current) {
        const start = parsed.data.timeStart ?? current.timeStart;
        const end = parsed.data.timeEnd ?? current.timeEnd;
        if (start && end) {
          updateData.durationMinutes = computeDurationMinutes(start, end);
        }
      }
    }

    const [entry] = await db.update(taskEntries).set(updateData).where(and(eq(taskEntries.id, params.id), eq(taskEntries.userId, userId))).returning();
    if (!entry) return NextResponse.json({ error: "Not found" }, { status: 404 });
    return NextResponse.json({ taskEntry: entry });
  } catch {
    return NextResponse.json({ error: "Internal server error" }, { status: 500 });
  }
}

export async function DELETE(_req: NextRequest, { params }: { params: { id: string } }) {
  try {
    const session = await getServerSession(authConfig);
    if (!session?.user) return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
    const userId = (session.user as { id: string }).id;

    const deleted = await db.transaction(async (tx) => {
      const [deleted] = await tx.delete(taskEntries).where(and(eq(taskEntries.id, params.id), eq(taskEntries.userId, userId))).returning();
      if (!deleted) return deleted;

      // a backlog card with no other day-entries left is deleted too, so
      // deleting either side of the link removes both (see schema.ts:85
      // for the reverse: deleting the backlog card cascades to entries)
      if (deleted.backlogItemId) {
        const [otherEntry] = await tx
          .select({ id: taskEntries.id })
          .from(taskEntries)
          .where(and(eq(taskEntries.backlogItemId, deleted.backlogItemId), ne(taskEntries.id, deleted.id)))
          .limit(1);
        if (!otherEntry) {
          await tx.delete(backlogItems).where(and(eq(backlogItems.id, deleted.backlogItemId), eq(backlogItems.userId, userId)));
        }
      }

      return deleted;
    });
    if (!deleted) return NextResponse.json({ error: "Not found" }, { status: 404 });
    return NextResponse.json({ success: true });
  } catch {
    return NextResponse.json({ error: "Internal server error" }, { status: 500 });
  }
}
