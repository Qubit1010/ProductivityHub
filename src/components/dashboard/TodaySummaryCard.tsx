"use client";

import { CheckCircle, Clock, Zap } from "lucide-react";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { LoadingSpinner } from "@/components/shared/LoadingSpinner";
import { useAnalyticsSummary } from "@/hooks/useAnalytics";
import { toDateString } from "@/lib/utils/date";
import { formatDuration } from "@/lib/utils/time";

export function TodaySummaryCard() {
  const today = toDateString();
  const { data, isLoading } = useAnalyticsSummary(today, today);

  if (isLoading) {
    return (
      <Card>
        <CardContent className="flex h-32 items-center justify-center">
          <LoadingSpinner />
        </CardContent>
      </Card>
    );
  }

  const tasksCompleted = data?.tasksCompleted ?? 0;
  const tasksTotal = data?.tasksTotal ?? 0;
  const totalMinutes = data?.totalMinutes ?? 0;
  const sprintUtilization = data?.sprintUtilization ?? 0;

  return (
    <div className="grid gap-4 sm:grid-cols-3">
      <Card>
        <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
          <CardTitle className="text-sm font-medium">Tasks</CardTitle>
          <CheckCircle className="h-4 w-4 text-muted-foreground" />
        </CardHeader>
        <CardContent>
          <div className="text-2xl font-bold">
            {tasksCompleted}/{tasksTotal}
          </div>
          <p className="text-xs text-muted-foreground">
            {tasksTotal > 0
              ? `${Math.round((tasksCompleted / tasksTotal) * 100)}% completed`
              : "No tasks yet"}
          </p>
        </CardContent>
      </Card>

      <Card>
        <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
          <CardTitle className="text-sm font-medium">Hours Logged</CardTitle>
          <Clock className="h-4 w-4 text-muted-foreground" />
        </CardHeader>
        <CardContent>
          <div className="text-2xl font-bold">
            {formatDuration(totalMinutes)}
          </div>
          <p className="text-xs text-muted-foreground">
            {totalMinutes > 0
              ? `${Math.round(totalMinutes / 60)} hours today`
              : "Start logging time"}
          </p>
        </CardContent>
      </Card>

      <Card>
        <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
          <CardTitle className="text-sm font-medium">Sprint Utilization</CardTitle>
          <Zap className="h-4 w-4 text-muted-foreground" />
        </CardHeader>
        <CardContent>
          <div className="text-2xl font-bold">
            {Math.round(sprintUtilization)}%
          </div>
          <p className="text-xs text-muted-foreground">
            Of sprint window used
          </p>
        </CardContent>
      </Card>
    </div>
  );
}
