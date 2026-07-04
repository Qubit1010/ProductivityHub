"use client";

import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { LoadingSpinner } from "@/components/shared/LoadingSpinner";
import { useAnalyticsSummary } from "@/hooks/useAnalytics";

interface TimeAllocationMapProps {
  from: string;
  to: string;
}

const hrs = (min: number) => Math.round((min / 60) * 10) / 10;

export function TimeAllocationMap({ from, to }: TimeAllocationMapProps) {
  const { data, isLoading } = useAnalyticsSummary(from, to);

  if (isLoading) {
    return (
      <Card>
        <CardContent className="flex h-40 items-center justify-center">
          <LoadingSpinner />
        </CardContent>
      </Card>
    );
  }

  const breakdown = (data?.categoryBreakdown ?? [])
    .filter((c) => c.minutes > 0)
    .sort((a, b) => b.minutes - a.minutes);
  const total = breakdown.reduce((s, c) => s + c.minutes, 0);

  return (
    <Card>
      <CardHeader>
        <CardTitle className="text-base">Time allocation</CardTitle>
        <p className="text-xs text-muted-foreground">Where your hours went this range</p>
      </CardHeader>
      <CardContent className="space-y-3">
        {total === 0 ? (
          <p className="text-sm text-muted-foreground">No time logged in this range.</p>
        ) : (
          <>
            <div className="flex h-9 w-full overflow-hidden rounded-md">
              {breakdown.map((c) => (
                <div
                  key={c.categoryId}
                  title={`${c.code} · ${hrs(c.minutes)}h`}
                  style={{ width: `${(c.minutes / total) * 100}%`, backgroundColor: c.color }}
                />
              ))}
            </div>
            <ul className="grid grid-cols-2 gap-x-4 gap-y-1.5 sm:grid-cols-3">
              {breakdown.map((c) => (
                <li key={c.categoryId} className="flex items-center gap-2 text-xs">
                  <span
                    className="h-2 w-2 shrink-0 rounded-full"
                    style={{ backgroundColor: c.color }}
                  />
                  <span className="font-medium">{c.code}</span>
                  <span className="text-muted-foreground">
                    {hrs(c.minutes)}h · {Math.round((c.minutes / total) * 100)}%
                  </span>
                </li>
              ))}
            </ul>
          </>
        )}
      </CardContent>
    </Card>
  );
}
