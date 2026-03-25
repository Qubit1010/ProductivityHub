"use client";

import { useQuery, useMutation, useQueryClient } from "@tanstack/react-query";
import { api } from "@/lib/api/client";

export function useWeeklyGoals(weekStart: string) {
  return useQuery({
    queryKey: ["weeklyGoals", weekStart],
    queryFn: () => api.weeklyGoals.list(weekStart),
    select: (data) => data.weeklyGoals,
  });
}

export function useCreateWeeklyGoal() {
  const qc = useQueryClient();
  return useMutation({
    mutationFn: api.weeklyGoals.create,
    onSuccess: () => qc.invalidateQueries({ queryKey: ["weeklyGoals"] }),
  });
}

export function useUpdateWeeklyGoal() {
  const qc = useQueryClient();
  return useMutation({
    mutationFn: ({ id, targetMinutes }: { id: string; targetMinutes: number }) =>
      api.weeklyGoals.update(id, { targetMinutes }),
    onSuccess: () => qc.invalidateQueries({ queryKey: ["weeklyGoals"] }),
  });
}

export function useDeleteWeeklyGoal() {
  const qc = useQueryClient();
  return useMutation({
    mutationFn: api.weeklyGoals.delete,
    onSuccess: () => qc.invalidateQueries({ queryKey: ["weeklyGoals"] }),
  });
}
