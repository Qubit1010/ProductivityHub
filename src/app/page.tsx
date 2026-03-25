"use client";

import { AppShell } from "@/components/layout/AppShell";
import { TodaySummaryCard } from "@/components/dashboard/TodaySummaryCard";
import { WeeklyHoursChart } from "@/components/dashboard/WeeklyHoursChart";
import { CategoryDonutChart } from "@/components/dashboard/CategoryDonutChart";
import { StreakBadge } from "@/components/dashboard/StreakBadge";
import { RecentCompletions } from "@/components/dashboard/RecentCompletions";

export default function DashboardPage() {
  return (
    <AppShell>
      <div className="space-y-6">
        <h1 className="text-3xl font-bold">Dashboard</h1>
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4">
          <TodaySummaryCard />
          <StreakBadge />
        </div>
        <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
          <WeeklyHoursChart />
          <CategoryDonutChart />
        </div>
        <RecentCompletions />
      </div>
    </AppShell>
  );
}
