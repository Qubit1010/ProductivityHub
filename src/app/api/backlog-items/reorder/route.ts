import { NextRequest, NextResponse } from "next/server";
import { getServerSession } from "next-auth";
import { authConfig } from "@/lib/auth/config";
import { db } from "@/lib/db";
import { backlogItems } from "@/lib/db/schema";
import { eq, and } from "drizzle-orm";
import { z } from "zod";

const reorderSchema = z.object({
  entries: z.array(z.object({ id: z.string(), sortOrder: z.number() })),
});

export async function PUT(req: NextRequest) {
  try {
    const session = await getServerSession(authConfig);
    if (!session?.user) return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
    const userId = (session.user as { id: string }).id;

    const body = await req.json();
    const parsed = reorderSchema.safeParse(body);
    if (!parsed.success) return NextResponse.json({ error: "Validation error" }, { status: 400 });

    for (const entry of parsed.data.entries) {
      await db.update(backlogItems).set({ sortOrder: entry.sortOrder }).where(and(eq(backlogItems.id, entry.id), eq(backlogItems.userId, userId)));
    }

    return NextResponse.json({ success: true });
  } catch {
    return NextResponse.json({ error: "Internal server error" }, { status: 500 });
  }
}
