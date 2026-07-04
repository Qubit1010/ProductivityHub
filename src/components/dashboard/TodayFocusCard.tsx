"use client";

import { useEffect, useState } from "react";
import { Bell } from "lucide-react";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { LoadingSpinner } from "@/components/shared/LoadingSpinner";
import { useFocus } from "@/hooks/useAnalytics";
import { useDailyLog, useCreateDailyLog } from "@/hooks/useDailyLog";
import { useCreateTaskEntry } from "@/hooks/useTaskEntries";
import { toDateString } from "@/lib/utils/date";
import { formatDuration } from "@/lib/utils/time";
import type { FocusTask } from "@/types";

function Stars({ n }: { n: number }) {
  return <span className="text-xs text-amber-500">{"★".repeat(n)}</span>;
}

function TaskRow({ task }: { task: FocusTask }) {
  return (
    <li className="flex items-center gap-2 text-sm">
      <span
        className="h-2 w-2 shrink-0 rounded-full"
        style={{ backgroundColor: task.color ?? "#888" }}
      />
      <span className="truncate">{task.title}</span>
      <Stars n={task.starRating} />
    </li>
  );
}

export function TodayFocusCard() {
  const today = toDateString();
  const { data, isLoading, isError } = useFocus(today);
  const { data: todayLog } = useDailyLog(today);
  const createDailyLog = useCreateDailyLog();
  const createTaskEntry = useCreateTaskEntry();
  const [rollingOver, setRollingOver] = useState(false);
  const [canAskNotify, setCanAskNotify] = useState(false);

  useEffect(() => {
    setCanAskNotify("Notification" in window && Notification.permission === "default");
  }, []);

  const requestNotify = async () => {
    if (!("Notification" in window)) return;
    await Notification.requestPermission();
    setCanAskNotify(Notification.permission === "default");
  };

  if (isLoading) {
    return (
      <Card>
        <CardContent className="flex h-32 items-center justify-center">
          <LoadingSpinner />
        </CardContent>
      </Card>
    );
  }

  if (isError || !data) {
    return (
      <Card>
        <CardHeader>
          <CardTitle className="text-base">Today&apos;s Focus</CardTitle>
        </CardHeader>
        <CardContent>
          <p className="text-sm text-muted-foreground">Couldn&apos;t load today&apos;s focus.</p>
        </CardContent>
      </Card>
    );
  }

  const todayTitles = new Set(data.undoneToday.map((t) => t.title));
  // skip tasks already copied to today — a re-click after partial failure can't duplicate
  const rollable = data.yesterdayUndone.filter((t) => !todayTitles.has(t.title));

  const handleRollover = async () => {
    setRollingOver(true);
    try {
      let logId = todayLog?.id;
      if (!logId) {
        const res = await createDailyLog.mutateAsync({ logDate: today });
        logId = res.dailyLog.id;
      }
      for (const task of rollable) {
        await createTaskEntry.mutateAsync({
          dailyLogId: logId,
          categoryId: task.categoryId,
          title: task.title,
          starRating: task.starRating,
          isRolledOver: true,
        });
      }
    } finally {
      setRollingOver(false);
    }
  };

  const nothingToShow =
    data.undoneToday.length === 0 &&
    data.yesterdayUndone.length === 0 &&
    data.agingBacklog.length === 0 &&
    data.goalsBehindPace.length === 0;

  return (
    <Card>
      <CardHeader>
        <div className="flex items-center justify-between">
          <div className="flex items-center gap-2">
            <CardTitle className="text-base">Today&apos;s Focus</CardTitle>
            {canAskNotify && (
              <Button
                variant="ghost"
                size="icon"
                className="h-6 w-6"
                aria-label="Enable browser notifications"
                onClick={requestNotify}
              >
                <Bell className="h-3.5 w-3.5" />
              </Button>
            )}
          </div>
          <p className="text-xs text-muted-foreground">
            Done today: {data.doneToday.tasksCompleted}/{data.doneToday.tasksTotal} ·{" "}
            {formatDuration(data.doneToday.totalMinutes)} · week{" "}
            {formatDuration(data.doneWeek.totalMinutes)}
          </p>
        </div>
      </CardHeader>
      <CardContent className="space-y-4">
        {nothingToShow && (
          <p className="text-sm text-muted-foreground">
            Nothing pending. Plan today&apos;s tasks or pull from the backlog.
          </p>
        )}
        {data.undoneToday.length > 0 && (
          <div>
            <p className="mb-1.5 text-xs font-medium text-muted-foreground">Still open today</p>
            <ul className="space-y-1">
              {data.undoneToday.map((t) => (
                <TaskRow key={t.id} task={t} />
              ))}
            </ul>
          </div>
        )}
        {data.yesterdayUndone.length > 0 && (
          <div>
            <div className="mb-1.5 flex items-center justify-between">
              <p className="text-xs font-medium text-muted-foreground">Missed yesterday</p>
              {rollable.length > 0 && (
                <Button
                  variant="outline"
                  size="sm"
                  onClick={handleRollover}
                  disabled={rollingOver}
                >
                  {rollingOver ? "Moving…" : `Move ${rollable.length} to today`}
                </Button>
              )}
            </div>
            <ul className="space-y-1">
              {data.yesterdayUndone.map((t) => (
                <TaskRow key={t.id} task={t} />
              ))}
            </ul>
          </div>
        )}
        {data.goalsBehindPace.length > 0 && (
          <div>
            <p className="mb-1.5 text-xs font-medium text-muted-foreground">Goals behind pace</p>
            <ul className="space-y-1">
              {data.goalsBehindPace.map((g) => (
                <li key={g.categoryId} className="text-sm">
                  <span className="font-medium">{g.code ?? "?"}</span>{" "}
                  <span className="text-muted-foreground">
                    {formatDuration(g.deficit)} behind ({formatDuration(g.actualMinutes)} /{" "}
                    {formatDuration(g.targetMinutes)})
                  </span>
                </li>
              ))}
            </ul>
          </div>
        )}
        {data.agingBacklog.length > 0 && (
          <div>
            <p className="mb-1.5 text-xs font-medium text-muted-foreground">From the backlog</p>
            <ul className="space-y-1">
              {data.agingBacklog.map((b) => (
                <li key={b.id} className="flex items-center gap-2 text-sm">
                  <span
                    className="h-2 w-2 shrink-0 rounded-full"
                    style={{ backgroundColor: b.color ?? "#888" }}
                  />
                  <span className="truncate">{b.title}</span>
                  <Stars n={b.starRating} />
                  <span className="text-xs text-muted-foreground">{b.ageDays}d old</span>
                </li>
              ))}
            </ul>
          </div>
        )}
      </CardContent>
    </Card>
  );
}
