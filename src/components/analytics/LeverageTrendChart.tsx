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
import { ArrowDown, ArrowUp } from "lucide-react";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { LoadingSpinner } from "@/components/shared/LoadingSpinner";
import { useLeverageTrend } from "@/hooks/useAnalytics";
import { formatDate } from "@/lib/utils/date";

interface LeverageTrendChartProps {
  from: string;
  to: string;
}

const LEVERAGE_COLOR = "#10b981"; // emerald — high-leverage / deep work

export function LeverageTrendChart({ from, to }: LeverageTrendChartProps) {
  const { data: weeks, isLoading } = useLeverageTrend(from, to);

  if (isLoading) {
    return (
      <Card>
        <CardContent className="flex h-64 items-center justify-center">
          <LoadingSpinner />
        </CardContent>
      </Card>
    );
  }

  const w = weeks ?? [];

  if (w.length < 2) {
    return (
      <Card>
        <CardHeader>
          <CardTitle className="text-base">Deep-work leverage trend</CardTitle>
        </CardHeader>
        <CardContent className="flex h-48 items-center justify-center">
          <p className="text-sm text-muted-foreground">
            Not enough weeks in this range yet — widen the date range.
          </p>
        </CardContent>
      </Card>
    );
  }

  const chartData = w.map((x) => ({
    week: formatDate(x.weekStart, "MMM d"),
    share: x.sharePct,
  }));
  const latest = w[w.length - 1].sharePct;
  const first = w[0].sharePct;
  const diff = latest - first;
  const up = diff >= 0;
  const TrendIcon = up ? ArrowUp : ArrowDown;

  return (
    <Card>
      <CardHeader>
        <div className="flex items-start justify-between">
          <div>
            <CardTitle className="text-base">Deep-work leverage trend</CardTitle>
            <p className="text-xs text-muted-foreground">% of time on 3-star work, by week</p>
          </div>
          <div className="text-right">
            <p className="text-2xl font-bold tabular-nums">{latest}%</p>
            <span
              className={`flex items-center justify-end gap-0.5 text-xs ${
                up ? "text-emerald-600 dark:text-emerald-500" : "text-red-600 dark:text-red-500"
              }`}
            >
              <TrendIcon className="h-3 w-3" />
              {up ? "+" : "-"}
              {Math.abs(diff)}pt vs first week
            </span>
          </div>
        </div>
      </CardHeader>
      <CardContent>
        <div className="h-56">
          <ResponsiveContainer width="100%" height="100%">
            <BarChart data={chartData}>
              <CartesianGrid strokeDasharray="3 3" className="stroke-muted" />
              <XAxis dataKey="week" className="text-xs" />
              <YAxis className="text-xs" domain={[0, 100]} unit="%" />
              <Tooltip
                formatter={(value: number) => [`${value}%`, "3-star share"]}
                contentStyle={{
                  backgroundColor: "hsl(var(--popover))",
                  border: "1px solid hsl(var(--border))",
                  borderRadius: "8px",
                }}
              />
              <Bar
                dataKey="share"
                fill={LEVERAGE_COLOR}
                radius={[3, 3, 0, 0]}
                isAnimationActive={false}
              />
            </BarChart>
          </ResponsiveContainer>
        </div>
      </CardContent>
    </Card>
  );
}
