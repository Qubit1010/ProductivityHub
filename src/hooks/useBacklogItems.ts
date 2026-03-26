"use client";

import { useQuery, useMutation, useQueryClient } from "@tanstack/react-query";
import { api } from "@/lib/api/client";

export function useBacklogItems(categoryId?: string) {
  return useQuery({
    queryKey: ["backlogItems", categoryId],
    queryFn: () => api.backlogItems.list(categoryId),
    select: (data) => data.backlogItems,
  });
}

export function useCreateBacklogItem() {
  const qc = useQueryClient();
  return useMutation({
    mutationFn: api.backlogItems.create,
    onSuccess: () => qc.invalidateQueries({ queryKey: ["backlogItems"] }),
  });
}

export function useUpdateBacklogItem() {
  const qc = useQueryClient();
  return useMutation({
    mutationFn: ({ id, ...data }: { id: string; title?: string; starRating?: number; categoryId?: string; isActive?: boolean }) =>
      api.backlogItems.update(id, data),
    onSuccess: () => qc.invalidateQueries({ queryKey: ["backlogItems"] }),
  });
}

export function useDeleteBacklogItem() {
  const qc = useQueryClient();
  return useMutation({
    mutationFn: api.backlogItems.delete,
    onSuccess: () => qc.invalidateQueries({ queryKey: ["backlogItems"] }),
  });
}

export function useReorderBacklogItems() {
  const qc = useQueryClient();
  return useMutation({
    mutationFn: api.backlogItems.reorder,
    onSuccess: () => qc.invalidateQueries({ queryKey: ["backlogItems"] }),
  });
}
