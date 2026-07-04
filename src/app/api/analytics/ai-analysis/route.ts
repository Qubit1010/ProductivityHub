import { NextRequest, NextResponse } from "next/server";
import { getServerSession } from "next-auth";
import { authConfig } from "@/lib/auth/config";
import { buildAnalysisInput, runCoach } from "@/lib/ai/analysis";

export async function POST(req: NextRequest) {
  try {
    const session = await getServerSession(authConfig);
    if (!session?.user) return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
    const userId = (session.user as { id: string }).id;

    if (!process.env.OPENAI_API_KEY) {
      return NextResponse.json(
        { error: "Add OPENAI_API_KEY to enable AI analysis" },
        { status: 400 }
      );
    }

    const body = await req.json().catch(() => ({}));
    const from = body?.from as string | undefined;
    const to = body?.to as string | undefined;
    if (!from || !to) return NextResponse.json({ error: "from and to required" }, { status: 400 });

    const input = await buildAnalysisInput(userId, from, to);
    if (input.lowData) {
      return NextResponse.json(
        { error: "Not enough data yet — log a few more days first." },
        { status: 400 }
      );
    }

    const analysis = await runCoach(input);
    return NextResponse.json(analysis);
  } catch (e) {
    console.error("ai-analysis failed", e);
    return NextResponse.json({ error: "AI analysis failed. Try again." }, { status: 500 });
  }
}
