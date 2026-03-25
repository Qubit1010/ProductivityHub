"use client";

import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Progress } from "@/components/ui/progress";
import { LoadingSpinner } from "@/components/shared/LoadingSpinner";
import { useWeeklyGoals } from "@/hooks/useWeeklyGoals";
import { useAnalyticsSummary } from "@/hooks/useAnalytics";
import { useCategories } from "@/hooks/useCategories";
import { getWeekBounds } from "@/lib/utils/date";
import { formatDuration } from "@/lib/utils/time";

interface WeeklyGoalProgressProps {
  weekStart?: string;
}

export function WeeklyGoalProgress({ weekStart }: WeeklyGoalProgressProps) {
  const bounds = getWeekBounds();
  const start = weekStart ?? bounds.start;
  const { data: goals, isLoading: loadingGoals } = useWeeklyGoals(start);
  const { data: summary, isLoading: loadingSummary } = useAnalyticsSummary(
    start,
    bounds.end
  );
  const { data: categories } = useCategories();

  if (loadingGoals || loadingSummary) {
    return (
      <Card>
        <CardContent className="flex h-48 items-center justify-center">
          <LoadingSpinner />
        </CardContent>
      </Card>
    );
  }

  const categoryMap = new Map(
    (categories ?? []).map((c) => [c.id, c])
  );
  const breakdownMap = new Map(
    (summary?.categoryBreakdown ?? []).map((b) => [b.categoryId, b.minutes])
  );

  if (!goals || goals.length === 0) {
    return (
      <Card>
        <CardHeader>
          <CardTitle className="text-base">Weekly Goals</CardTitle>
        </CardHeader>
        <CardContent>
          <p className="text-sm text-muted-foreground">
            No weekly goals set. Set goals from the Week page.
          </p>
        </CardContent>
      </Card>
    );
  }

  return (
    <Card>
      <CardHeader>
        <CardTitle className="text-base">Weekly Goals</CardTitle>
      </CardHeader>
      <CardContent>
        <div className="space-y-4">
          {goals.map((goal) => {
            const cat = categoryMap.get(goal.categoryId);
            const actualMinutes = breakdownMap.get(goal.categoryId) ?? 0;
            const pct =
              goal.targetMinutes > 0
                ? (actualMinutes / goal.targetMinutes) * 100
                : 0;

            return (
              <div key={goal.id} className="space-y-1.5">
                <div className="flex items-center justify-between text-sm">
                  <div className="flex items-center gap-2">
                    <div
                      className="h-2.5 w-2.5 rounded-full"
                      style={{ backgroundColor: cat?.color ?? "#888" }}
                    />
                    <span className="font-medium">
                      {cat?.code ?? "?"} - {cat?.name ?? "Unknown"}
                    </span>
                  </div>
                  <span className="text-muted-foreground">
                    {formatDuration(actualMinutes)} /{" "}
                    {formatDuration(goal.targetMinutes)}
                  </span>
                </div>
                <Progress value={Math.min(pct, 100)} className="h-2" />
              </div>
            );
          })}
        </div>
      </CardContent>
    </Card>
  );
}
