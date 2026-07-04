import { NextRequest, NextResponse } from "next/server";
import { getServerSession } from "next-auth";
import { authConfig } from "@/lib/auth/config";
import { getTodayFocus } from "@/lib/db/analytics";

export async function GET(req: NextRequest) {
  try {
    const session = await getServerSession(authConfig);
    if (!session?.user) return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
    const userId = (session.user as { id: string }).id;

    const { searchParams } = new URL(req.url);
    // ponytail: PKT (UTC+5) offset hardcoded — Vercel runs UTC, user lives in PKT;
    // callers pass ?date= as source of truth, this default only covers direct hits
    const date =
      searchParams.get("date") ??
      new Date(Date.now() + 5 * 3600e3).toISOString().slice(0, 10);

    const focus = await getTodayFocus(userId, date);
    return NextResponse.json(focus);
  } catch {
    return NextResponse.json({ error: "Internal server error" }, { status: 500 });
  }
}
