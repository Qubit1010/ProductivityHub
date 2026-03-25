"use client";

import {
  BarChart,
  Bar,
  XAxis,
  YAxis,
  CartesianGrid,
  Tooltip,
  ResponsiveContainer,
  Legend,
} from "recharts";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { LoadingSpinner } from "@/components/shared/LoadingSpinner";
import { useDailyBreakdown } from "@/hooks/useAnalytics";
import { useCategories } from "@/hooks/useCategories";
import { getWeekBounds } from "@/lib/utils/date";
import { formatDate } from "@/lib/utils/date";

export function WeeklyHoursChart() {
  const { start, end } = getWeekBounds();
  const { data: days, isLoading: loadingDays } = useDailyBreakdown(start, end);
  const { isLoading: loadingCats } = useCategories();

  if (loadingDays || loadingCats) {
    return (
      <Card>
        <CardContent className="flex h-64 items-center justify-center">
          <LoadingSpinner />
        </CardContent>
      </Card>
    );
  }

  const uniqueCategories = new Map<string, { code: string; color: string }>();
  days?.forEach((day) => {
    day.categories.forEach((cat) => {
      if (!uniqueCategories.has(cat.categoryId)) {
        uniqueCategories.set(cat.categoryId, {
          code: cat.code,
          color: cat.color,
        });
      }
    });
  });

  const chartData = (days ?? []).map((day) => {
    const entry: Record<string, unknown> = {
      date: formatDate(day.date, "EEE"),
    };
    day.categories.forEach((cat) => {
      entry[cat.code] = Math.round((cat.minutes / 60) * 10) / 10;
    });
    return entry;
  });

  return (
    <Card>
      <CardHeader>
        <CardTitle className="text-base">Weekly Hours by Category</CardTitle>
      </CardHeader>
      <CardContent>
        <div className="h-64">
          <ResponsiveContainer width="100%" height="100%">
            <BarChart data={chartData}>
              <CartesianGrid strokeDasharray="3 3" className="stroke-muted" />
              <XAxis dataKey="date" className="text-xs" />
              <YAxis
                className="text-xs"
                label={{
                  value: "Hours",
                  angle: -90,
                  position: "insideLeft",
                  className: "text-xs fill-muted-foreground",
                }}
              />
              <Tooltip
                contentStyle={{
                  backgroundColor: "hsl(var(--popover))",
                  border: "1px solid hsl(var(--border))",
                  borderRadius: "8px",
                }}
              />
              <Legend />
              {Array.from(uniqueCategories.entries()).map(
                ([id, { code, color }]) => (
                  <Bar
                    key={id}
                    dataKey={code}
                    stackId="hours"
                    fill={color}
                    radius={[2, 2, 0, 0]}
                  />
                )
              )}
            </BarChart>
          </ResponsiveContainer>
        </div>
      </CardContent>
    </Card>
  );
}
