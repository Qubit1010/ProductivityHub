"use client";

import { ArrowDown, ArrowUp, Minus } from "lucide-react";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { LoadingSpinner } from "@/components/shared/LoadingSpinner";
import { useWeeklyScorecard } from "@/hooks/useAnalytics";
import { formatDate } from "@/lib/utils/date";
import type { ScorecardWeek } from "@/types";

const hrs = (min: number) => Math.round((min / 60) * 10) / 10;

// value is already in display units (hours or percentage points)
function Delta({ value, unit }: { value: number; unit: string }) {
  if (value === 0) {
    return (
      <span className="flex items-center gap-0.5 text-xs text-muted-foreground">
        <Minus className="h-3 w-3" />
        {unit === "h" ? "0h" : "0pt"}
      </span>
    );
  }
  const up = value > 0;
  const Icon = up ? ArrowUp : ArrowDown;
  return (
    <span
      className={`flex items-center gap-0.5 text-xs ${
        up ? "text-emerald-600 dark:text-emerald-500" : "text-red-600 dark:text-red-500"
      }`}
    >
      <Icon className="h-3 w-3" />
      {up ? "+" : "-"}
      {Math.abs(value)}
      {unit}
    </span>
  );
}

function Row({
  label,
  value,
  delta,
  unit,
}: {
  label: string;
  value: string;
  delta?: number;
  unit?: string;
}) {
  return (
    <div className="flex items-center justify-between border-b py-2 last:border-b-0">
      <span className="text-sm text-muted-foreground">{label}</span>
      <div className="flex items-center gap-3">
        <span className="text-sm font-semibold tabular-nums">{value}</span>
        {delta !== undefined && unit ? (
          <span className="w-16 text-right">
            <Delta value={delta} unit={unit} />
          </span>
        ) : (
          <span className="w-16" />
        )}
      </div>
    </div>
  );
}

export function WeeklyScorecard() {
  const { data, isLoading } = useWeeklyScorecard();

  if (isLoading) {
    return (
      <Card>
        <CardContent className="flex h-40 items-center justify-center">
          <LoadingSpinner />
        </CardContent>
      </Card>
    );
  }

  const t: ScorecardWeek = data?.thisWeek ?? {
    totalMinutes: 0,
    tasksCompleted: 0,
    tasksTotal: 0,
    completionRate: 0,
    deepWorkPct: 0,
    bestDay: null,
  };
  const l: ScorecardWeek = data?.lastWeek ?? {
    totalMinutes: 0,
    tasksCompleted: 0,
    tasksTotal: 0,
    completionRate: 0,
    deepWorkPct: 0,
    bestDay: null,
  };

  const hoursDelta = Math.round((hrs(t.totalMinutes) - hrs(l.totalMinutes)) * 10) / 10;

  return (
    <Card>
      <CardHeader>
        <CardTitle className="text-base">This week vs last</CardTitle>
        <p className="text-xs text-muted-foreground">Week so far, compared to last full week</p>
      </CardHeader>
      <CardContent>
        <Row label="Hours logged" value={`${hrs(t.totalMinutes)}h`} delta={hoursDelta} unit="h" />
        <Row
          label="Deep-work share"
          value={`${t.deepWorkPct}%`}
          delta={t.deepWorkPct - l.deepWorkPct}
          unit="pt"
        />
        <Row
          label="Tasks done"
          value={`${t.tasksCompleted}/${t.tasksTotal} (${t.completionRate}%)`}
          delta={t.completionRate - l.completionRate}
          unit="pt"
        />
        <Row
          label="Best day"
          value={t.bestDay ? `${formatDate(t.bestDay.date, "EEE")} · ${hrs(t.bestDay.totalMinutes)}h` : "—"}
        />
      </CardContent>
    </Card>
  );
}
