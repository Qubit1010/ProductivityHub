import { NextRequest, NextResponse } from "next/server";
import bcrypt from "bcrypt";
import { db } from "@/lib/db";
import { users, categories } from "@/lib/db/schema";
import { eq } from "drizzle-orm";
import { DEFAULT_CATEGORIES } from "@/lib/constants";

export async function POST(req: NextRequest) {
  try {
    const { email, password, name } = await req.json();

    if (!email || !password || !name) {
      return NextResponse.json({ error: "Email, password, and name are required" }, { status: 400 });
    }

    const [existing] = await db.select().from(users).where(eq(users.email, email)).limit(1);
    if (existing) {
      return NextResponse.json({ error: "Email already registered" }, { status: 400 });
    }

    const saltRounds = parseInt(process.env.BCRYPT_SALT_ROUNDS || "12", 10);
    const passwordHash = await bcrypt.hash(password, saltRounds);

    const [user] = await db.insert(users).values({ email, passwordHash, name }).returning();

    // Seed default categories
    const categoryValues = DEFAULT_CATEGORIES.map((cat, index) => ({
      userId: user.id,
      code: cat.code,
      name: cat.name,
      color: cat.color,
      type: cat.type,
      sortOrder: index,
    }));
    await db.insert(categories).values(categoryValues);

    return NextResponse.json({ user: { id: user.id, email: user.email, name: user.name } }, { status: 201 });
  } catch {
    return NextResponse.json({ error: "Internal server error" }, { status: 500 });
  }
}
