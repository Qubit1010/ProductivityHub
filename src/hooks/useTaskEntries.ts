"use client";

import { useQuery, useMutation, useQueryClient } from "@tanstack/react-query";
import { api } from "@/lib/api/client";

export function useTaskEntries(dailyLogId: string | undefined) {
  return useQuery({
    queryKey: ["taskEntries", dailyLogId],
    queryFn: () => api.taskEntries.listByDailyLog(dailyLogId!),
    select: (data) => data.taskEntries,
    enabled: !!dailyLogId,
  });
}

export function useTaskEntriesByRange(from: string, to: string) {
  return useQuery({
    queryKey: ["taskEntries", "range", from, to],
    queryFn: () => api.taskEntries.listByRange(from, to),
    select: (data) => data.taskEntries,
  });
}

export function useCreateTaskEntry() {
  const qc = useQueryClient();
  return useMutation({
    mutationFn: api.taskEntries.create,
    onSuccess: () => {
      qc.invalidateQueries({ queryKey: ["taskEntries"] });
      qc.invalidateQueries({ queryKey: ["analytics"] });
    },
  });
}

export function useUpdateTaskEntry() {
  const qc = useQueryClient();
  return useMutation({
    mutationFn: ({ id, ...data }: { id: string; [key: string]: unknown }) =>
      api.taskEntries.update(id, data),
    onSuccess: () => {
      qc.invalidateQueries({ queryKey: ["taskEntries"] });
      qc.invalidateQueries({ queryKey: ["analytics"] });
    },
  });
}

export function useDeleteTaskEntry() {
  const qc = useQueryClient();
  return useMutation({
    mutationFn: api.taskEntries.delete,
    onSuccess: () => {
      qc.invalidateQueries({ queryKey: ["taskEntries"] });
      qc.invalidateQueries({ queryKey: ["analytics"] });
    },
  });
}

export function useToggleTaskComplete() {
  const qc = useQueryClient();
  return useMutation({
    mutationFn: ({ id, isCompleted }: { id: string; isCompleted: boolean }) =>
      api.taskEntries.toggleComplete(id, isCompleted),
    onSuccess: () => {
      qc.invalidateQueries({ queryKey: ["taskEntries"] });
      qc.invalidateQueries({ queryKey: ["analytics"] });
    },
  });
}

export function useReorderTaskEntries() {
  const qc = useQueryClient();
  return useMutation({
    mutationFn: api.taskEntries.reorder,
    onSuccess: () => qc.invalidateQueries({ queryKey: ["taskEntries"] }),
  });
}
