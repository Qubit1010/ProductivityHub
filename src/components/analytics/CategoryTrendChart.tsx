"use client";

import {
  LineChart,
  Line,
  XAxis,
  YAxis,
  CartesianGrid,
  Tooltip,
  ResponsiveContainer,
  Legend,
} from "recharts";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { LoadingSpinner } from "@/components/shared/LoadingSpinner";
import { useCategoryTrends } from "@/hooks/useAnalytics";
import { formatDate } from "@/lib/utils/date";

interface CategoryTrendChartProps {
  from: string;
  to: string;
}

export function CategoryTrendChart({ from, to }: CategoryTrendChartProps) {
  const { data: trends, isLoading } = useCategoryTrends(from, to);

  if (isLoading) {
    return (
      <Card>
        <CardContent className="flex h-64 items-center justify-center">
          <LoadingSpinner />
        </CardContent>
      </Card>
    );
  }

  if (!trends || trends.length === 0) {
    return (
      <Card>
        <CardHeader>
          <CardTitle className="text-base">Category Trends</CardTitle>
        </CardHeader>
        <CardContent className="flex h-48 items-center justify-center">
          <p className="text-sm text-muted-foreground">No trend data available</p>
        </CardContent>
      </Card>
    );
  }

  const allDates = new Set<string>();
  trends.forEach((t) => t.dataPoints.forEach((dp) => allDates.add(dp.date)));
  const sortedDates = Array.from(allDates).sort();

  const chartData = sortedDates.map((date) => {
    const entry: Record<string, unknown> = { date: formatDate(date, "MMM d") };
    trends.forEach((t) => {
      const dp = t.dataPoints.find((p) => p.date === date);
      entry[t.code] = dp ? Math.round((dp.minutes / 60) * 10) / 10 : 0;
    });
    return entry;
  });

  return (
    <Card>
      <CardHeader>
        <CardTitle className="text-base">Category Trends</CardTitle>
      </CardHeader>
      <CardContent>
        <div className="h-64">
          <ResponsiveContainer width="100%" height="100%">
            <LineChart data={chartData}>
              <CartesianGrid strokeDasharray="3 3" className="stroke-muted" />
              <XAxis dataKey="date" className="text-xs" />
              <YAxis className="text-xs" />
              <Tooltip
                contentStyle={{
                  backgroundColor: "hsl(var(--popover))",
                  border: "1px solid hsl(var(--border))",
                  borderRadius: "8px",
                }}
              />
              <Legend />
              {trends.map((t) => (
                <Line
                  key={t.categoryId}
                  type="monotone"
                  dataKey={t.code}
                  stroke={t.color}
                  strokeWidth={2}
                  dot={{ r: 3 }}
                />
              ))}
            </LineChart>
          </ResponsiveContainer>
        </div>
      </CardContent>
    </Card>
  );
}
