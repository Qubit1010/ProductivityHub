"use client";

import { useMemo } from "react";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import {
  Tooltip,
  TooltipContent,
  TooltipProvider,
  TooltipTrigger,
} from "@/components/ui/tooltip";
import { LoadingSpinner } from "@/components/shared/LoadingSpinner";
import { useDailyBreakdown } from "@/hooks/useAnalytics";
import { formatDate } from "@/lib/utils/date";
import { formatDuration } from "@/lib/utils/time";
import { cn } from "@/lib/utils";

interface TimeHeatmapProps {
  from: string;
  to: string;
}

export function TimeHeatmap({ from, to }: TimeHeatmapProps) {
  const { data: days, isLoading } = useDailyBreakdown(from, to);

  const dayMap = useMemo(() => {
    const map = new Map<string, number>();
    (days ?? []).forEach((d) => map.set(d.date, d.totalMinutes));
    return map;
  }, [days]);

  const maxMinutes = useMemo(() => {
    let max = 0;
    dayMap.forEach((v) => {
      if (v > max) max = v;
    });
    return max || 1;
  }, [dayMap]);

  const allDates = useMemo(() => {
    const dates: string[] = [];
    const start = new Date(from);
    const end = new Date(to);
    const current = new Date(start);
    while (current <= end) {
      dates.push(current.toISOString().split("T")[0]);
      current.setDate(current.getDate() + 1);
    }
    return dates;
  }, [from, to]);

  const getColor = (minutes: number): string => {
    if (minutes === 0) return "bg-muted";
    const intensity = minutes / maxMinutes;
    if (intensity < 0.25) return "bg-green-200 dark:bg-green-900";
    if (intensity < 0.5) return "bg-green-400 dark:bg-green-700";
    if (intensity < 0.75) return "bg-green-500 dark:bg-green-500";
    return "bg-green-600 dark:bg-green-400";
  };

  if (isLoading) {
    return (
      <Card>
        <CardContent className="flex h-48 items-center justify-center">
          <LoadingSpinner />
        </CardContent>
      </Card>
    );
  }

  return (
    <Card>
      <CardHeader>
        <CardTitle className="text-base">Activity Heatmap</CardTitle>
      </CardHeader>
      <CardContent>
        <TooltipProvider>
          <div className="flex flex-wrap gap-1">
            {allDates.map((date) => {
              const minutes = dayMap.get(date) ?? 0;
              return (
                <Tooltip key={date}>
                  <TooltipTrigger asChild>
                    <div
                      className={cn(
                        "h-3 w-3 rounded-sm transition-colors",
                        getColor(minutes)
                      )}
                    />
                  </TooltipTrigger>
                  <TooltipContent>
                    <p className="text-xs">
                      {formatDate(date)}: {formatDuration(minutes)}
                    </p>
                  </TooltipContent>
                </Tooltip>
              );
            })}
          </div>
        </TooltipProvider>
        <div className="mt-3 flex items-center gap-2 text-xs text-muted-foreground">
          <span>Less</span>
          <div className="flex gap-0.5">
            <div className="h-3 w-3 rounded-sm bg-muted" />
            <div className="h-3 w-3 rounded-sm bg-green-200 dark:bg-green-900" />
            <div className="h-3 w-3 rounded-sm bg-green-400 dark:bg-green-700" />
            <div className="h-3 w-3 rounded-sm bg-green-500 dark:bg-green-500" />
            <div className="h-3 w-3 rounded-sm bg-green-600 dark:bg-green-400" />
          </div>
          <span>More</span>
        </div>
      </CardContent>
    </Card>
  );
}
