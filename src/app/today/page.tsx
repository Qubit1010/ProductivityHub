"use client";

import { useEffect } from "react";
import { format } from "date-fns";
import { AppShell } from "@/components/layout/AppShell";
import { TaskEntryList } from "@/components/planner/TaskEntryList";
import { SprintTimeBar } from "@/components/planner/SprintTimeBar";
import { AddTaskDialog } from "@/components/planner/AddTaskDialog";
import { BacklogSidebar } from "@/components/planner/BacklogSidebar";
import { DayCompletionSummary } from "@/components/planner/DayCompletionSummary";
import { SleepTracker } from "@/components/planner/SleepTracker";
import { useDailyLog, useCreateDailyLog } from "@/hooks/useDailyLog";
import { useTaskEntries } from "@/hooks/useTaskEntries";

export default function TodayPage() {
  const today = format(new Date(), "yyyy-MM-dd");
  const { data: dailyLog, isLoading: logLoading } = useDailyLog(today);
  const createDailyLog = useCreateDailyLog();
  const { data: tasks, isLoading: tasksLoading } = useTaskEntries(dailyLog?.id);

  useEffect(() => {
    if (!logLoading && !dailyLog && !createDailyLog.isPending) {
      createDailyLog.mutate({ logDate: today });
    }
  }, [logLoading, dailyLog, today, createDailyLog]);

  return (
    <AppShell>
      <div className="flex gap-6">
        <div className="flex-1 space-y-4">
          <div className="flex items-center justify-between">
            <h1 className="text-3xl font-bold">Today&apos;s Plan</h1>
            <div className="flex gap-2">
              {dailyLog && <AddTaskDialog dailyLogId={dailyLog.id} />}
            </div>
          </div>
          {dailyLog && (
            <SleepTracker dailyLogId={dailyLog.id} sleepHours={dailyLog.sleepHours} />
          )}
          <SprintTimeBar dailyLog={dailyLog ?? null} tasks={tasks || []} />
          <TaskEntryList dailyLogId={dailyLog?.id ?? ""} tasks={tasks || []} isLoading={logLoading || tasksLoading} />
          <DayCompletionSummary tasks={tasks || []} />
        </div>
        <BacklogSidebar dailyLogId={dailyLog?.id} />
      </div>
    </AppShell>
  );
}
