import OpenAI from "openai";
import {
  getInsights,
  getAnalyticsSummary,
  getLeverageTrend,
  getAnalyticsMomentum,
  getWeeklyScorecard,
} from "@/lib/db/analytics";
import type { AiAnalysis } from "@/types";

const hrs = (m: number) => Math.round((m / 60) * 10) / 10;

/**
 * Assemble a compact, aggregates-only snapshot for the coach.
 * No raw task rows — only category codes, hours, and already-computed facts.
 */
export async function buildAnalysisInput(userId: string, from: string, to: string) {
  const [insights, summary, leverage, momentum, scorecard] = await Promise.all([
    getInsights(userId, from, to),
    getAnalyticsSummary(userId, from, to),
    getLeverageTrend(userId, from, to),
    getAnalyticsMomentum(userId, from, to),
    getWeeklyScorecard(userId),
  ]);

  return {
    range: { from, to },
    lowData: insights.lowData,
    totals: {
      hoursLogged: hrs(summary.totalMinutes),
      tasksCompleted: summary.tasksCompleted,
      tasksTotal: summary.tasksTotal,
      completionRate: summary.completionRate,
    },
    facts: insights.insights.map((i) => ({ severity: i.severity, text: i.text })),
    categories: summary.categoryBreakdown
      .slice()
      .sort((a, b) => b.minutes - a.minutes)
      .map((c) => ({ code: c.code, hours: hrs(c.minutes) })),
    leverageByWeek: leverage.weeks.map((w) => ({
      weekStart: w.weekStart,
      threeStarSharePct: w.sharePct,
      hours: hrs(w.totalMinutes),
    })),
    momentum: momentum.items
      .slice(0, 10)
      .map((m) => ({ code: m.code, fromHours: hrs(m.prevMinutes), toHours: hrs(m.curMinutes), deltaHours: hrs(m.deltaMinutes) })),
    weekOverWeek: {
      thisWeek: {
        hours: hrs(scorecard.thisWeek.totalMinutes),
        deepWorkPct: scorecard.thisWeek.deepWorkPct,
        completionRate: scorecard.thisWeek.completionRate,
      },
      lastWeek: {
        hours: hrs(scorecard.lastWeek.totalMinutes),
        deepWorkPct: scorecard.lastWeek.deepWorkPct,
        completionRate: scorecard.lastWeek.completionRate,
      },
    },
  };
}

export type AnalysisInput = Awaited<ReturnType<typeof buildAnalysisInput>>;

const SYSTEM_PROMPT = `You are a sharp time-analysis coach for a founder who also studies. You read his logged-time aggregates and tell him, plainly, where his time actually went and what to change.

His lens:
- High-leverage = deep work: work, business, tech, freelance, priority categories. 3-star tasks are his highest-priority work.
- Low-leverage = marketing, personal, general.

Rules:
- Ground every claim in the numbers provided. Never invent data or cite a number that is not in the input.
- Be direct and concrete. No filler, no praise padding, no hedging.
- "oneThingThisWeek" must be a single, specific, do-able action.
- Keep "whatsWorking" and "whatToChange" to 2-4 short items each.
- Respond ONLY as JSON matching this schema:
{ "headline": string, "whereTimeWent": string (2-4 sentences), "whatsWorking": string[], "whatToChange": string[], "oneThingThisWeek": string }`;

// gpt-5.2 primary; gpt-5.4-mini fallback if the primary id doesn't resolve (per feedback_use_latest_models)
const MODELS = ["gpt-5.2", "gpt-5.4-mini"];

export async function runCoach(input: AnalysisInput): Promise<AiAnalysis> {
  const client = new OpenAI({ apiKey: process.env.OPENAI_API_KEY });

  let lastErr: unknown;
  for (const model of MODELS) {
    try {
      const res = await client.chat.completions.create({
        model,
        reasoning_effort: "medium",
        max_completion_tokens: 1400,
        response_format: { type: "json_object" },
        messages: [
          { role: "system", content: SYSTEM_PROMPT },
          { role: "user", content: JSON.stringify(input) },
        ],
      });
      const text = res.choices[0]?.message?.content ?? "{}";
      const parsed = JSON.parse(text) as Partial<AiAnalysis>;
      return {
        headline: parsed.headline ?? "Your time this period",
        whereTimeWent: parsed.whereTimeWent ?? "",
        whatsWorking: Array.isArray(parsed.whatsWorking) ? parsed.whatsWorking : [],
        whatToChange: Array.isArray(parsed.whatToChange) ? parsed.whatToChange : [],
        oneThingThisWeek: parsed.oneThingThisWeek ?? "",
      };
    } catch (e) {
      lastErr = e;
      const status = (e as { status?: number })?.status;
      // only try the fallback model on a model-resolution error; rethrow real failures
      if (status !== 404 && status !== 400) throw e;
    }
  }
  throw lastErr;
}
