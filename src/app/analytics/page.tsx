"use client";

import { useState } from "react";
import { format, subDays } from "date-fns";
import { AppShell } from "@/components/layout/AppShell";
import { DateRangeSelector } from "@/components/analytics/DateRangeSelector";
import { AICoachPanel } from "@/components/analytics/AICoachPanel";
import { WeeklyScorecard } from "@/components/analytics/WeeklyScorecard";
import { LeverageTrendChart } from "@/components/analytics/LeverageTrendChart";
import { TimeAllocationMap } from "@/components/analytics/TimeAllocationMap";
import { CategoryMomentum } from "@/components/analytics/CategoryMomentum";
import { InsightsPanel } from "@/components/analytics/InsightsPanel";
import { TimeHeatmap } from "@/components/analytics/TimeHeatmap";

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

        <AICoachPanel from={from} to={to} />

        <div className="grid gap-6 lg:grid-cols-2">
          <WeeklyScorecard />
          <LeverageTrendChart from={from} to={to} />
        </div>

        <TimeAllocationMap from={from} to={to} />

        <div className="grid gap-6 lg:grid-cols-2">
          <CategoryMomentum from={from} to={to} />
          <InsightsPanel from={from} to={to} />
        </div>

        <TimeHeatmap from={from} to={to} />
      </div>
    </AppShell>
  );
}
