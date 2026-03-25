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
import { useDailyBreakdown } from "@/hooks/useAnalytics";
import { formatDate } from "@/lib/utils/date";

interface CompletionRateChartProps {
  from: string;
  to: string;
}

export function CompletionRateChart({ from, to }: CompletionRateChartProps) {
  const { data: days, isLoading } = useDailyBreakdown(from, to);

  if (isLoading) {
    return (
      <Card>
        <CardContent className="flex h-64 items-center justify-center">
          <LoadingSpinner />
        </CardContent>
      </Card>
    );
  }

  const chartData = (days ?? []).map((d) => ({
    date: formatDate(d.date, "MMM d"),
    total: d.tasksTotal,
    completed: d.tasksCompleted,
  }));

  return (
    <Card>
      <CardHeader>
        <CardTitle className="text-base">Planned vs Completed</CardTitle>
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
              <Line
                type="monotone"
                dataKey="total"
                stroke="hsl(var(--muted-foreground))"
                strokeWidth={2}
                strokeDasharray="4 4"
                name="Planned"
                dot={{ r: 3 }}
              />
              <Line
                type="monotone"
                dataKey="completed"
                stroke="hsl(142, 76%, 36%)"
                strokeWidth={2}
                name="Completed"
                dot={{ r: 3 }}
              />
            </LineChart>
          </ResponsiveContainer>
        </div>
      </CardContent>
    </Card>
  );
}
