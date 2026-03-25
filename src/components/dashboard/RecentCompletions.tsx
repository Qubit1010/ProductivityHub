"use client";

import { CheckCircle2 } from "lucide-react";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { ScrollArea } from "@/components/ui/scroll-area";
import { CategoryBadge } from "@/components/shared/CategoryBadge";
import { StarRating } from "@/components/shared/StarRating";
import { LoadingSpinner } from "@/components/shared/LoadingSpinner";
import { useTaskEntriesByRange } from "@/hooks/useTaskEntries";
import { toDateString, subDays, format } from "@/lib/utils/date";
import { formatTime12h } from "@/lib/utils/time";
import type { TaskEntry } from "@/types";

export function RecentCompletions() {
  const today = toDateString();
  const sevenDaysAgo = format(subDays(new Date(), 7), "yyyy-MM-dd");
  const { data: tasks, isLoading } = useTaskEntriesByRange(sevenDaysAgo, today);

  if (isLoading) {
    return (
      <Card>
        <CardContent className="flex h-48 items-center justify-center">
          <LoadingSpinner />
        </CardContent>
      </Card>
    );
  }

  const completed = (tasks ?? [])
    .filter((t: TaskEntry) => t.isCompleted)
    .sort((a: TaskEntry, b: TaskEntry) => {
      const aTime = a.completedAt ?? a.updatedAt;
      const bTime = b.completedAt ?? b.updatedAt;
      return new Date(bTime).getTime() - new Date(aTime).getTime();
    })
    .slice(0, 10);

  return (
    <Card>
      <CardHeader>
        <CardTitle className="text-base">Recent Completions</CardTitle>
      </CardHeader>
      <CardContent>
        {completed.length === 0 ? (
          <p className="text-sm text-muted-foreground">
            No completed tasks yet this week
          </p>
        ) : (
          <ScrollArea className="h-64">
            <div className="space-y-3">
              {completed.map((task: TaskEntry) => (
                <div
                  key={task.id}
                  className="flex items-center gap-3 rounded-lg border p-3"
                >
                  <CheckCircle2 className="h-4 w-4 shrink-0 text-green-500" />
                  <div className="flex-1 min-w-0">
                    <p className="truncate text-sm font-medium">
                      {task.title}
                    </p>
                    <div className="flex items-center gap-2 mt-1">
                      {task.category && (
                        <CategoryBadge category={task.category} />
                      )}
                      {task.timeStart && (
                        <span className="text-xs text-muted-foreground">
                          {formatTime12h(task.timeStart)}
                        </span>
                      )}
                    </div>
                  </div>
                  <StarRating value={task.starRating} size={12} />
                </div>
              ))}
            </div>
          </ScrollArea>
        )}
      </CardContent>
    </Card>
  );
}
