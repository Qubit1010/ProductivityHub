"use client";

import { useEffect } from "react";
import { AppShell } from "@/components/layout/AppShell";
import { TaskEntryList } from "@/components/planner/TaskEntryList";
import { SprintTimeBar } from "@/components/planner/SprintTimeBar";
import { AddTaskDialog } from "@/components/planner/AddTaskDialog";
import { BacklogSidebar } from "@/components/planner/BacklogSidebar";
import { DayCompletionSummary } from "@/components/planner/DayCompletionSummary";
import { useDailyLog, useCreateDailyLog } from "@/hooks/useDailyLog";
import { useTaskEntries } from "@/hooks/useTaskEntries";

export default function DayPlannerPage({ params }: { params: { date: string } }) {
  const { data: dailyLog, isLoading: logLoading } = useDailyLog(params.date);
  const createDailyLog = useCreateDailyLog();
  const { data: tasks, isLoading: tasksLoading } = useTaskEntries(dailyLog?.id);

  useEffect(() => {
    if (!logLoading && !dailyLog && !createDailyLog.isPending) {
      createDailyLog.mutate({ logDate: params.date });
    }
  }, [logLoading, dailyLog, params.date, createDailyLog]);

  return (
    <AppShell>
      <div className="flex gap-6">
        <div className="flex-1 space-y-4">
          <div className="flex items-center justify-between">
            <h1 className="text-3xl font-bold">{params.date}</h1>
            {dailyLog && <AddTaskDialog dailyLogId={dailyLog.id} />}
          </div>
          <SprintTimeBar dailyLog={dailyLog ?? null} tasks={tasks || []} />
          <TaskEntryList dailyLogId={dailyLog?.id ?? ""} tasks={tasks || []} isLoading={logLoading || tasksLoading} />
          <DayCompletionSummary tasks={tasks || []} />
        </div>
        <BacklogSidebar dailyLogId={dailyLog?.id} />
      </div>
    </AppShell>
  );
}
