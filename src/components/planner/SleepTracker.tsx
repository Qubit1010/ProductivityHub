"use client";

import { useState, useEffect } from "react";
import { Moon, Minus, Plus } from "lucide-react";
import { Button } from "@/components/ui/button";
import { useUpdateDailyLog } from "@/hooks/useDailyLog";
import { cn } from "@/lib/utils";

interface SleepTrackerProps {
  dailyLogId: string;
  sleepHours: number | null;
}

export function SleepTracker({ dailyLogId, sleepHours }: SleepTrackerProps) {
  const [hours, setHours] = useState<number | null>(sleepHours);
  const updateLog = useUpdateDailyLog();

  useEffect(() => {
    setHours(sleepHours);
  }, [sleepHours]);

  const save = (value: number | null) => {
    setHours(value);
    updateLog.mutate({ id: dailyLogId, sleepHours: value });
  };

  const increment = () => {
    const next = Math.min(24, (hours ?? 0) + 0.5);
    save(next);
  };

  const decrement = () => {
    const next = Math.max(0, (hours ?? 0) - 0.5);
    save(next);
  };

  const quality =
    hours === null
      ? null
      : hours >= 7
        ? "good"
        : hours >= 5
          ? "fair"
          : "poor";

  return (
    <div className="flex items-center gap-3 rounded-lg border bg-card p-3">
      <Moon
        className={cn(
          "h-5 w-5",
          quality === "good" && "text-emerald-400",
          quality === "fair" && "text-amber-400",
          quality === "poor" && "text-red-400",
          quality === null && "text-muted-foreground"
        )}
      />
      <span className="text-sm font-medium text-muted-foreground">Sleep</span>
      <div className="flex items-center gap-1">
        <Button
          variant="ghost"
          size="icon"
          className="h-7 w-7"
          onClick={decrement}
          disabled={hours !== null && hours <= 0}
        >
          <Minus className="h-3.5 w-3.5" />
        </Button>
        <span className="min-w-[3rem] text-center text-lg font-semibold tabular-nums">
          {hours !== null ? `${hours}h` : "—"}
        </span>
        <Button
          variant="ghost"
          size="icon"
          className="h-7 w-7"
          onClick={increment}
        >
          <Plus className="h-3.5 w-3.5" />
        </Button>
      </div>
      {quality && (
        <span
          className={cn(
            "text-xs font-medium",
            quality === "good" && "text-emerald-400",
            quality === "fair" && "text-amber-400",
            quality === "poor" && "text-red-400"
          )}
        >
          {quality === "good" ? "Well rested" : quality === "fair" ? "Could be better" : "Sleep deprived"}
        </span>
      )}
    </div>
  );
}
