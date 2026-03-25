"use client";

import {
  BarChart,
  Bar,
  XAxis,
  YAxis,
  CartesianGrid,
  Tooltip,
  ResponsiveContainer,
} from "recharts";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { LoadingSpinner } from "@/components/shared/LoadingSpinner";
import { useHourlyDistribution } from "@/hooks/useAnalytics";

interface HourlyHistogramProps {
  from: string;
  to: string;
}

export function HourlyHistogram({ from, to }: HourlyHistogramProps) {
  const { data: hours, isLoading } = useHourlyDistribution(from, to);

  if (isLoading) {
    return (
      <Card>
        <CardContent className="flex h-64 items-center justify-center">
          <LoadingSpinner />
        </CardContent>
      </Card>
    );
  }

  const chartData = (hours ?? []).map((h) => ({
    hour: `${h.hour.toString().padStart(2, "0")}:00`,
    tasks: h.taskCount,
    minutes: h.totalMinutes,
  }));

  return (
    <Card>
      <CardHeader>
        <CardTitle className="text-base">Hourly Distribution</CardTitle>
      </CardHeader>
      <CardContent>
        <div className="h-64">
          <ResponsiveContainer width="100%" height="100%">
            <BarChart data={chartData}>
              <CartesianGrid strokeDasharray="3 3" className="stroke-muted" />
              <XAxis dataKey="hour" className="text-xs" interval={2} />
              <YAxis className="text-xs" />
              <Tooltip
                contentStyle={{
                  backgroundColor: "hsl(var(--popover))",
                  border: "1px solid hsl(var(--border))",
                  borderRadius: "8px",
                }}
              />
              <Bar
                dataKey="tasks"
                fill="hsl(var(--primary))"
                radius={[4, 4, 0, 0]}
                name="Tasks"
              />
            </BarChart>
          </ResponsiveContainer>
        </div>
      </CardContent>
    </Card>
  );
}
