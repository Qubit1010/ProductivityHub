"use client";

import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Progress } from "@/components/ui/progress";
import { LoadingSpinner } from "@/components/shared/LoadingSpinner";
import { useSprintAdherence } from "@/hooks/useAnalytics";
import { cn } from "@/lib/utils";

interface SprintAdherenceGaugeProps {
  from: string;
  to: string;
}

export function SprintAdherenceGauge({ from, to }: SprintAdherenceGaugeProps) {
  const { data: days, isLoading } = useSprintAdherence(from, to);

  if (isLoading) {
    return (
      <Card>
        <CardContent className="flex h-32 items-center justify-center">
          <LoadingSpinner />
        </CardContent>
      </Card>
    );
  }

  const validDays = (days ?? []).filter((d) => d.sprintMinutes > 0);
  const avgAdherence =
    validDays.length > 0
      ? validDays.reduce((sum, d) => sum + d.adherencePercent, 0) /
        validDays.length
      : 0;

  const getColor = (pct: number) => {
    if (pct >= 80) return "text-green-600";
    if (pct >= 60) return "text-yellow-600";
    return "text-red-600";
  };

  return (
    <Card>
      <CardHeader>
        <CardTitle className="text-base">Sprint Adherence</CardTitle>
      </CardHeader>
      <CardContent>
        <div className="flex items-center gap-4">
          <div className="flex-1">
            <Progress value={Math.min(avgAdherence, 100)} className="h-3" />
          </div>
          <span className={cn("text-2xl font-bold", getColor(avgAdherence))}>
            {Math.round(avgAdherence)}%
          </span>
        </div>
        <p className="mt-2 text-xs text-muted-foreground">
          Average across {validDays.length} day{validDays.length !== 1 ? "s" : ""}{" "}
          with sprint windows set
        </p>
      </CardContent>
    </Card>
  );
}
