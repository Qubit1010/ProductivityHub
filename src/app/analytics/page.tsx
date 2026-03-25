"use client";

import { useState } from "react";
import { format, subDays } from "date-fns";
import { AppShell } from "@/components/layout/AppShell";
import { DateRangeSelector } from "@/components/analytics/DateRangeSelector";
import { TimeHeatmap } from "@/components/analytics/TimeHeatmap";
import { CategoryTrendChart } from "@/components/analytics/CategoryTrendChart";
import { HourlyHistogram } from "@/components/analytics/HourlyHistogram";
import { CompletionRateChart } from "@/components/analytics/CompletionRateChart";
import { SprintAdherenceGauge } from "@/components/analytics/SprintAdherenceGauge";
import { WeeklyGoalProgress } from "@/components/analytics/WeeklyGoalProgress";

export default function AnalyticsPage() {
  const [from, setFrom] = useState(format(subDays(new Date(), 30), "yyyy-MM-dd"));
  const [to, setTo] = useState(format(new Date(), "yyyy-MM-dd"));

  return (
    <AppShell>
      <div className="space-y-6">
        <div className="flex items-center justify-between">
          <h1 className="text-3xl font-bold">Analytics</h1>
          <DateRangeSelector from={from} to={to} onFromChange={setFrom} onToChange={setTo} />
        </div>
        <TimeHeatmap from={from} to={to} />
        <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
          <CategoryTrendChart from={from} to={to} />
          <HourlyHistogram from={from} to={to} />
        </div>
        <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
          <CompletionRateChart from={from} to={to} />
          <SprintAdherenceGauge from={from} to={to} />
        </div>
        <WeeklyGoalProgress weekStart={from} />
      </div>
    </AppShell>
  );
}
