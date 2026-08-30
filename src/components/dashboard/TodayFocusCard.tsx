"use client";

import { useEffect, useState } from "react";
import { Bell, Plus, X } from "lucide-react";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select";
import { StarRating } from "@/components/shared/StarRating";
import { LoadingSpinner } from "@/components/shared/LoadingSpinner";
import { useFocus } from "@/hooks/useAnalytics";
import { useCategories } from "@/hooks/useCategories";
import { useDailyLog, useCreateDailyLog } from "@/hooks/useDailyLog";
import { useCreateTaskEntry } from "@/hooks/useTaskEntries";
import { toDateString } from "@/lib/utils/date";
import { formatDuration } from "@/lib/utils/time";

// ponytail: rapid-fire quick-add row (title+category+stars), form stays open after
// each add so the user can chain 4-6 tasks without reopening AddTaskDialog each time.
function QuickAddRow({
  dailyLogId,
  onAdded,
}: {
  dailyLogId: string | undefined;
  onAdded: () => void;
}) {
  const { data: categories } = useCategories();
  const createDailyLog = useCreateDailyLog();
  const createTaskEntry = useCreateTaskEntry();
  const [title, setTitle] = useState("");
  const [categoryId, setCategoryId] = useState("");
  const [starRating, setStarRating] = useState(1);
  const [busy, setBusy] = useState(false);

  useEffect(() => {
    if (!categoryId && categories?.[0]) setCategoryId(categories[0].id);
  }, [categories, categoryId]);

  const submit = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!title.trim() || !categoryId || busy) return;
    setBusy(true);
    try {
      const logId = dailyLogId ?? (await createDailyLog.mutateAsync({ logDate: toDateString() })).dailyLog.id;
      await createTaskEntry.mutateAsync({
        dailyLogId: logId,
        categoryId,
        title: title.trim(),
        starRating,
        logToBacklog: true,
      });
      setTitle("");
      onAdded();
    } finally {
      setBusy(false);
    }
  };

  return (
    <form onSubmit={submit} className="flex flex-wrap items-center gap-2">
      <Input
        value={title}
        onChange={(e) => setTitle(e.target.value)}
        placeholder="Add a task for today..."
        className="h-8 min-w-[160px] flex-1"
      />
      <Select value={categoryId} onValueChange={setCategoryId}>
        <SelectTrigger className="h-8 w-[130px] shrink-0">
          <SelectValue placeholder="Category" />
        </SelectTrigger>
        <SelectContent>
          {(categories ?? []).map((cat) => (
            <SelectItem key={cat.id} value={cat.id}>
              <div className="flex items-center gap-2">
                <div className="h-2.5 w-2.5 rounded-full" style={{ backgroundColor: cat.color }} />
                {cat.code}
              </div>
            </SelectItem>
          ))}
        </SelectContent>
      </Select>
      <StarRating value={starRating} editable onChange={setStarRating} size={16} />
      <Button type="submit" size="sm" disabled={!title.trim() || !categoryId || busy}>
        {busy ? "Adding…" : "Add"}
      </Button>
    </form>
  );
}

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
        <QuickAddRow dailyLogId={todayLog?.id} onAdded={() => {}} />
        {nothing && (
          <p className="text-sm text-muted-foreground">
            Nothing pending — add tasks above or plan your day below.
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
