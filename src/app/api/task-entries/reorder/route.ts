import { NextRequest, NextResponse } from "next/server";
import { getServerSession } from "next-auth";
import { authConfig } from "@/lib/auth/config";
import { db } from "@/lib/db";
import { taskEntries } from "@/lib/db/schema";
import { eq, and } from "drizzle-orm";
import { reorderTaskEntriesSchema } from "@/lib/validators/task-entry";

export async function PUT(req: NextRequest) {
  try {
    const session = await getServerSession(authConfig);
    if (!session?.user) return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
    const userId = (session.user as { id: string }).id;

    const body = await req.json();
    const parsed = reorderTaskEntriesSchema.safeParse(body);
    if (!parsed.success) return NextResponse.json({ error: "Validation error" }, { status: 400 });

    for (const entry of parsed.data.entries) {
      await db.update(taskEntries).set({ sortOrder: entry.sortOrder }).where(and(eq(taskEntries.id, entry.id), eq(taskEntries.userId, userId)));
    }

    return NextResponse.json({ success: true });
  } catch {
    return NextResponse.json({ error: "Internal server error" }, { status: 500 });
  }
}
