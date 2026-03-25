"use client";

import { CheckCircle, Clock, ListChecks } from "lucide-react";
import { computeDurationMinutes, formatDuration } from "@/lib/utils/time";
import type { TaskEntry } from "@/types";

interface DayCompletionSummaryProps {
  tasks: TaskEntry[];
}

export function DayCompletionSummary({ tasks }: DayCompletionSummaryProps) {
  const total = tasks.length;
  const completed = tasks.filter((t) => t.isCompleted).length;
  const totalMinutes = tasks.reduce((sum, t) => {
    if (t.timeStart && t.timeEnd) {
      return sum + computeDurationMinutes(t.timeStart, t.timeEnd);
    }
    return sum + (t.durationMinutes ?? 0);
  }, 0);

  return (
    <div className="flex items-center gap-6 rounded-lg border bg-card px-4 py-3">
      <div className="flex items-center gap-2">
        <ListChecks className="h-4 w-4 text-muted-foreground" />
        <span className="text-sm">
          <span className="font-medium">{total}</span>{" "}
          <span className="text-muted-foreground">tasks</span>
        </span>
      </div>
      <div className="flex items-center gap-2">
        <CheckCircle className="h-4 w-4 text-green-500" />
        <span className="text-sm">
          <span className="font-medium">{completed}</span>{" "}
          <span className="text-muted-foreground">completed</span>
        </span>
      </div>
      <div className="flex items-center gap-2">
        <Clock className="h-4 w-4 text-muted-foreground" />
        <span className="text-sm">
          <span className="font-medium">{formatDuration(totalMinutes)}</span>{" "}
          <span className="text-muted-foreground">logged</span>
        </span>
      </div>
      {total > 0 && (
        <div className="ml-auto text-sm font-medium">
          {Math.round((completed / total) * 100)}%
        </div>
      )}
    </div>
  );
}
