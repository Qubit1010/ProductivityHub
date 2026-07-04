"use client";

import { useEffect, useState } from "react";
import { Bell, Plus, X } from "lucide-react";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { LoadingSpinner } from "@/components/shared/LoadingSpinner";
import { useFocus } from "@/hooks/useAnalytics";
import { useDailyLog, useCreateDailyLog } from "@/hooks/useDailyLog";
import { useCreateTaskEntry } from "@/hooks/useTaskEntries";
import { toDateString } from "@/lib/utils/date";
import { formatDuration } from "@/lib/utils/time";

function Stars({ n }: { n: number }) {
  return <span className="text-xs text-amber-500">{"★".repeat(n)}</span>;
}

function SuggestionRow({
  color,
  title,
  starRating,
  meta,
  busy,
  onAdd,
  onDismiss,
}: {
  color: string | null;
  title: string;
  starRating: number;
  meta?: string;
  busy: boolean;
  onAdd: () => void;
  onDismiss: () => void;
}) {
  return (
    <li className="flex items-center gap-2 text-sm">
      <span
        className="h-2 w-2 shrink-0 rounded-full"
        style={{ backgroundColor: color ?? "#888" }}
      />
      <span className="truncate">{title}</span>
      <Stars n={starRating} />
      {meta && <span className="text-xs text-muted-foreground">{meta}</span>}
      <div className="ml-auto flex shrink-0 items-center gap-0.5">
        <Button
          variant="ghost"
          size="icon"
          className="h-6 w-6"
          aria-label={`Add "${title}" to today`}
          disabled={busy}
          onClick={onAdd}
        >
          <Plus className="h-3.5 w-3.5" />
        </Button>
        <Button
          variant="ghost"
          size="icon"
          className="h-6 w-6 text-muted-foreground"
          aria-label={`Dismiss "${title}"`}
          disabled={busy}
          onClick={onDismiss}
        >
          <X className="h-3.5 w-3.5" />
        </Button>
      </div>
    </li>
  );
}

export function TodayFocusCard() {
  const today = toDateString();
  const { data, isLoading, isError } = useFocus(today);
  const { data: todayLog } = useDailyLog(today);
  const createDailyLog = useCreateDailyLog();
  const createTaskEntry = useCreateTaskEntry();
  const [busyId, setBusyId] = useState<string | null>(null);
  const [bulkBusy, setBulkBusy] = useState(false);
  const [dismissed, setDismissed] = useState<Set<string>>(new Set());
  const [canAskNotify, setCanAskNotify] = useState(false);

  const dismissKey = `focus-dismissed:${today}`;

  useEffect(() => {
    setCanAskNotify("Notification" in window && Notification.permission === "default");
    try {
      const raw = localStorage.getItem(dismissKey);
      if (raw) setDismissed(new Set(JSON.parse(raw) as string[]));
    } catch {
      // ignore corrupt/absent localStorage
    }
  }, [dismissKey]);

  const dismiss = (id: string) => {
    setDismissed((prev) => {
      const next = new Set(prev).add(id);
      try {
        localStorage.setItem(dismissKey, JSON.stringify(Array.from(next)));
      } catch {
        // ignore write failures
      }
      return next;
    });
  };

  const requestNotify = async () => {
    if (!("Notification" in window)) return;
    await Notification.requestPermission();
    setCanAskNotify(Notification.permission === "default");
  };

  // guarantee today's daily log exists before any add
  const ensureLog = async () => {
    if (todayLog?.id) return todayLog.id;
    const res = await createDailyLog.mutateAsync({ logDate: today });
    return res.dailyLog.id;
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

  // dedup: hide anything already sitting in today's plan (by title) or dismissed today
  const todayTitles = new Set(data.undoneToday.map((t) => t.title));
  const missed = data.yesterdayUndone.filter(
    (t) => !todayTitles.has(t.title) && !dismissed.has(t.id)
  );
  const backlog = data.agingBacklog.filter(
    (b) => !todayTitles.has(b.title) && !dismissed.has(b.id)
  );

  const addMissed = async (task: (typeof missed)[number]) => {
    setBusyId(task.id);
    try {
      const logId = await ensureLog();
      await createTaskEntry.mutateAsync({
        dailyLogId: logId,
        categoryId: task.categoryId,
        title: task.title,
        starRating: task.starRating,
        isRolledOver: true,
      });
      dismiss(task.id);
    } finally {
      setBusyId(null);
    }
  };

  const addBacklog = async (item: (typeof backlog)[number]) => {
    setBusyId(item.id);
    try {
      const logId = await ensureLog();
      await createTaskEntry.mutateAsync({
        dailyLogId: logId,
        categoryId: item.categoryId,
        title: item.title,
        starRating: item.starRating,
        backlogItemId: item.id,
      });
      dismiss(item.id);
    } finally {
      setBusyId(null);
    }
  };

  const moveAllMissed = async () => {
    setBulkBusy(true);
    try {
      const logId = await ensureLog();
      for (const t of missed) {
        await createTaskEntry.mutateAsync({
          dailyLogId: logId,
          categoryId: t.categoryId,
          title: t.title,
          starRating: t.starRating,
          isRolledOver: true,
        });
        dismiss(t.id);
      }
    } finally {
      setBulkBusy(false);
    }
  };

  const nothing = missed.length === 0 && backlog.length === 0;

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
        {nothing && (
          <p className="text-sm text-muted-foreground">
            Nothing pending — plan your day below.
          </p>
        )}
        {missed.length > 0 && (
          <div>
            <div className="mb-1.5 flex items-center justify-between">
              <p className="text-xs font-medium text-muted-foreground">Missed yesterday</p>
              {missed.length > 1 && (
                <Button
                  variant="outline"
                  size="sm"
                  onClick={moveAllMissed}
                  disabled={bulkBusy || busyId !== null}
                >
                  {bulkBusy ? "Moving…" : `Move all ${missed.length}`}
                </Button>
              )}
            </div>
            <ul className="space-y-1">
              {missed.map((t) => (
                <SuggestionRow
                  key={t.id}
                  color={t.color}
                  title={t.title}
                  starRating={t.starRating}
                  busy={busyId === t.id || bulkBusy}
                  onAdd={() => addMissed(t)}
                  onDismiss={() => dismiss(t.id)}
                />
              ))}
            </ul>
          </div>
        )}
        {backlog.length > 0 && (
          <div>
            <p className="mb-1.5 text-xs font-medium text-muted-foreground">From the backlog</p>
            <ul className="space-y-1">
              {backlog.map((b) => (
                <SuggestionRow
                  key={b.id}
                  color={b.color}
                  title={b.title}
                  starRating={b.starRating}
                  meta={`${b.ageDays}d old`}
                  busy={busyId === b.id || bulkBusy}
                  onAdd={() => addBacklog(b)}
                  onDismiss={() => dismiss(b.id)}
                />
              ))}
            </ul>
          </div>
        )}
      </CardContent>
    </Card>
  );
}
