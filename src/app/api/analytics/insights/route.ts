import { NextRequest, NextResponse } from "next/server";
import { getServerSession } from "next-auth";
import { authConfig } from "@/lib/auth/config";
import { getInsights } from "@/lib/db/analytics";

export async function GET(request: NextRequest) {
  try {
    const session = await getServerSession(authConfig);
    if (!session?.user) {
      return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
    }
    const userId = (session.user as { id: string }).id;

    const { searchParams } = new URL(request.url);
    const from = searchParams.get("from");
    const to = searchParams.get("to");

    if (!from || !to) {
      return NextResponse.json(
        { error: "from and to query params are required" },
        { status: 400 }
      );
    }

    const data = await getInsights(userId, from, to);
    return NextResponse.json(data);
  } catch (error) {
    console.error("Insights error:", error);
    return NextResponse.json(
      { error: "Failed to compute insights" },
      { status: 500 }
    );
  }
}
