"use client";

import { useQuery, useMutation, useQueryClient } from "@tanstack/react-query";
import { api } from "@/lib/api/client";

export function useDailyLog(date: string) {
  return useQuery({
    queryKey: ["dailyLog", date],
    queryFn: () => api.dailyLogs.getByDate(date),
    select: (data) => data.dailyLog,
  });
}

export function useDailyLogs(from: string, to: string) {
  return useQuery({
    queryKey: ["dailyLogs", from, to],
    queryFn: () => api.dailyLogs.getByRange(from, to),
    select: (data) => data.dailyLogs,
  });
}

export function useCreateDailyLog() {
  const qc = useQueryClient();
  return useMutation({
    mutationFn: api.dailyLogs.create,
    onSuccess: (_, vars) => {
      qc.invalidateQueries({ queryKey: ["dailyLog", vars.logDate] });
      qc.invalidateQueries({ queryKey: ["dailyLogs"] });
    },
  });
}

export function useUpdateDailyLog() {
  const qc = useQueryClient();
  return useMutation({
    mutationFn: ({ id, ...data }: { id: string; sprintStart?: string; sprintEnd?: string; notes?: string }) =>
      api.dailyLogs.update(id, data),
    onSuccess: () => {
      qc.invalidateQueries({ queryKey: ["dailyLog"] });
      qc.invalidateQueries({ queryKey: ["dailyLogs"] });
    },
  });
}
