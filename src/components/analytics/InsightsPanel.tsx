"use client";

import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { LoadingSpinner } from "@/components/shared/LoadingSpinner";
import { useInsights } from "@/hooks/useAnalytics";
import { formatDuration } from "@/lib/utils/time";
import type { Insight, PeriodStats } from "@/types";

interface InsightsPanelProps {
  from: string;
  to: string;
}

const SEVERITY_DOT: Record<Insight["severity"], string> = {
  warn: "bg-amber-500",
  info: "bg-blue-500",
  good: "bg-emerald-500",
};

function StatTile({
  label,
  current,
  previous,
}: {
  label: string;
  current: string;
  previous: string;
}) {
  return (
    <div className="rounded-lg border p-3">
      <p className="text-xs text-muted-foreground">{label}</p>
      <p className="text-xl font-semibold">{current}</p>
      <p className="text-xs text-muted-foreground">prev: {previous}</p>
    </div>
  );
}

export function InsightsPanel({ from, to }: InsightsPanelProps) {
  const { data, isLoading, isError } = useInsights(from, to);

  if (isLoading) {
    return (
      <Card>
        <CardContent className="flex h-32 items-center justify-center">
          <LoadingSpinner />
        </CardContent>
      </Card>
    );
  }

  if (isError || !data) {
    return (
      <Card>
        <CardHeader>
          <CardTitle className="text-base">Insights</CardTitle>
        </CardHeader>
        <CardContent>
          <p className="text-sm text-muted-foreground">Couldn&apos;t load insights.</p>
        </CardContent>
      </Card>
    );
  }

  const { current, previous } = data.comparison;
  const topCat = (p: PeriodStats) =>
    p.topCategory ? `${p.topCategory.code} (${formatDuration(p.topCategory.minutes)})` : "—";

  return (
    <Card>
      <CardHeader>
        <CardTitle className="text-base">Insights</CardTitle>
      </CardHeader>
      <CardContent className="space-y-4">
        <div className="grid grid-cols-1 sm:grid-cols-3 gap-3">
          <StatTile
            label="Total time"
            current={formatDuration(current.totalMinutes)}
            previous={formatDuration(previous.totalMinutes)}
          />
          <StatTile
            label="Completion rate"
            current={`${current.completionRate}%`}
            previous={`${previous.completionRate}%`}
          />
          <StatTile
            label="Top category"
            current={topCat(current)}
            previous={topCat(previous)}
          />
        </div>
        {data.lowData ? (
          <p className="text-sm text-muted-foreground">
            Not enough data yet for insights — log at least 3 days (5+ hours) in this range.
          </p>
        ) : data.insights.length === 0 ? (
          <p className="text-sm text-muted-foreground">Nothing notable this period.</p>
        ) : (
          <ul className="space-y-2">
            {data.insights.map((insight) => (
              <li key={insight.id} className="flex items-start gap-2 text-sm">
                <span
                  className={`mt-1.5 h-2 w-2 shrink-0 rounded-full ${SEVERITY_DOT[insight.severity]}`}
                />
                {insight.text}
              </li>
            ))}
          </ul>
        )}
      </CardContent>
    </Card>
  );
}
