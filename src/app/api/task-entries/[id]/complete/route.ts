import { NextRequest, NextResponse } from "next/server";
import { getServerSession } from "next-auth";
import { authConfig } from "@/lib/auth/config";
import { db } from "@/lib/db";
import { taskEntries } from "@/lib/db/schema";
import { eq, and } from "drizzle-orm";
import { toggleCompleteSchema } from "@/lib/validators/task-entry";

export async function PATCH(req: NextRequest, { params }: { params: { id: string } }) {
  try {
    const session = await getServerSession(authConfig);
    if (!session?.user) return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
    const userId = (session.user as { id: string }).id;

    const body = await req.json();
    const parsed = toggleCompleteSchema.safeParse(body);
    if (!parsed.success) return NextResponse.json({ error: "Validation error" }, { status: 400 });

    const [entry] = await db.update(taskEntries).set({
      isCompleted: parsed.data.isCompleted,
      completedAt: parsed.data.isCompleted ? new Date() : null,
      updatedAt: new Date(),
    }).where(and(eq(taskEntries.id, params.id), eq(taskEntries.userId, userId))).returning();

    if (!entry) return NextResponse.json({ error: "Not found" }, { status: 404 });
    return NextResponse.json({ taskEntry: entry });
  } catch {
    return NextResponse.json({ error: "Internal server error" }, { status: 500 });
  }
}
