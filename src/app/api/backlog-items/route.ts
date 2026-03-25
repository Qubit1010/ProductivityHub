import { NextRequest, NextResponse } from "next/server";
import { getServerSession } from "next-auth";
import { authConfig } from "@/lib/auth/config";
import { db } from "@/lib/db";
import { backlogItems } from "@/lib/db/schema";
import { eq, and, asc } from "drizzle-orm";
import { createBacklogItemSchema } from "@/lib/validators/backlog-item";

export async function GET(req: NextRequest) {
  try {
    const session = await getServerSession(authConfig);
    if (!session?.user) return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
    const userId = (session.user as { id: string }).id;

    const { searchParams } = new URL(req.url);
    const categoryId = searchParams.get("categoryId");

    const conditions = [eq(backlogItems.userId, userId), eq(backlogItems.isActive, true)];
    if (categoryId) conditions.push(eq(backlogItems.categoryId, categoryId));

    const result = await db.select().from(backlogItems).where(and(...conditions)).orderBy(asc(backlogItems.createdAt));
    return NextResponse.json({ backlogItems: result });
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
    const parsed = createBacklogItemSchema.safeParse(body);
    if (!parsed.success) return NextResponse.json({ error: "Validation error", details: parsed.error.flatten() }, { status: 400 });

    const [item] = await db.insert(backlogItems).values({ ...parsed.data, userId }).returning();
    return NextResponse.json({ backlogItem: item }, { status: 201 });
  } catch {
    return NextResponse.json({ error: "Internal server error" }, { status: 500 });
  }
}
