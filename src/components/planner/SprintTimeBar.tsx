"use client";

import { Progress } from "@/components/ui/progress";
import { Card, CardContent } from "@/components/ui/card";
import { formatTime12h, computeDurationMinutes, formatDuration } from "@/lib/utils/time";
import type { DailyLog, TaskEntry } from "@/types";

interface SprintTimeBarProps {
  dailyLog: DailyLog | null;
  tasks: TaskEntry[];
}

export function SprintTimeBar({ dailyLog, tasks }: SprintTimeBarProps) {
  const sprintStart = dailyLog?.sprintStart;
  const sprintEnd = dailyLog?.sprintEnd;

  if (!sprintStart || !sprintEnd) {
    return (
      <Card>
        <CardContent className="py-3">
          <p className="text-sm text-muted-foreground">
            No sprint window set for this day. Edit the daily log to set sprint
            start/end times.
          </p>
        </CardContent>
      </Card>
    );
  }

  const sprintMinutes = computeDurationMinutes(sprintStart, sprintEnd);
  const loggedMinutes = tasks.reduce((sum, t) => {
    if (t.timeStart && t.timeEnd) {
      return sum + computeDurationMinutes(t.timeStart, t.timeEnd);
    }
    return sum + (t.durationMinutes ?? 0);
  }, 0);

  const utilization = sprintMinutes > 0 ? (loggedMinutes / sprintMinutes) * 100 : 0;

  return (
    <Card>
      <CardContent className="py-3">
        <div className="mb-2 flex items-center justify-between text-sm">
          <span className="text-muted-foreground">
            Sprint: {formatTime12h(sprintStart)} - {formatTime12h(sprintEnd)}
          </span>
          <span className="font-medium">
            {formatDuration(loggedMinutes)} / {formatDuration(sprintMinutes)} (
            {Math.round(utilization)}%)
          </span>
        </div>
        <Progress value={Math.min(utilization, 100)} className="h-2" />
      </CardContent>
    </Card>
  );
}
