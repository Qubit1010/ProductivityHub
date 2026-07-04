"use client";

import { useState } from "react";
import { AppShell } from "@/components/layout/AppShell";
import { TodaySummaryCard } from "@/components/dashboard/TodaySummaryCard";
import { WeeklyHoursChart } from "@/components/dashboard/WeeklyHoursChart";
import { CategoryDonutChart } from "@/components/dashboard/CategoryDonutChart";
import { StreakBadge } from "@/components/dashboard/StreakBadge";
import { RecentCompletions } from "@/components/dashboard/RecentCompletions";
import { TodayFocusCard } from "@/components/dashboard/TodayFocusCard";
import { DateRangeSelector } from "@/components/analytics/DateRangeSelector";
import { getWeekBounds } from "@/lib/utils/date";
import { useInsights } from "@/hooks/useAnalytics";

const INSIGHT_DOT: Record<string, string> = {
  warn: "bg-amber-500",
  info: "bg-blue-500",
  good: "bg-emerald-500",
};

function InsightsStrip() {
  // always current week, independent of the chart range below
  const week = getWeekBounds();
  const { data } = useInsights(week.start, week.end);
  if (!data || data.lowData || data.insights.length === 0) return null;
  return (
    <div className="rounded-lg border bg-card px-4 py-3 space-y-1.5">
      {data.insights.slice(0, 3).map((i) => (
        <p key={i.id} className="flex items-start gap-2 text-sm">
          <span className={`mt-1.5 h-2 w-2 shrink-0 rounded-full ${INSIGHT_DOT[i.severity]}`} />
          {i.text}
        </p>
      ))}
    </div>
  );
}

export default function DashboardPage() {
  const week = getWeekBounds();
  const [from, setFrom] = useState(week.start);
  const [to, setTo] = useState(week.end);

  return (
    <AppShell>
      <div className="space-y-6">
        <div className="flex flex-wrap items-center justify-between gap-4">
          <h1 className="text-3xl font-bold">Dashboard</h1>
          <DateRangeSelector from={from} to={to} onFromChange={setFrom} onToChange={setTo} />
        </div>
        <TodayFocusCard />
        <InsightsStrip />
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4">
          <TodaySummaryCard />
          <StreakBadge />
        </div>
        <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
          <WeeklyHoursChart from={from} to={to} />
          <CategoryDonutChart from={from} to={to} />
        </div>
        <RecentCompletions />
      </div>
    </AppShell>
  );
}
