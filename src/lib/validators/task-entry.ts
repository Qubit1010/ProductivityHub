import { z } from "zod";

export const createTaskEntrySchema = z.object({
  dailyLogId: z.string().uuid(),
  categoryId: z.string().uuid(),
  title: z.string().min(1).max(255),
  starRating: z.number().int().min(1).max(3).default(1),
  tag: z.string().max(10).nullable().optional(),
  timeStart: z.string().nullable().optional(),
  timeEnd: z.string().nullable().optional(),
  backlogItemId: z.string().uuid().nullable().optional(),
});

export const updateTaskEntrySchema = z.object({
  categoryId: z.string().uuid().optional(),
  title: z.string().min(1).max(255).optional(),
  starRating: z.number().int().min(1).max(3).optional(),
  tag: z.string().max(10).nullable().optional(),
  timeStart: z.string().nullable().optional(),
  timeEnd: z.string().nullable().optional(),
});

export const completeTaskEntrySchema = z.object({
  isCompleted: z.boolean(),
});

export const toggleCompleteSchema = completeTaskEntrySchema;

export const reorderTaskEntriesSchema = z.object({
  entries: z.array(
    z.object({
      id: z.string().uuid(),
      sortOrder: z.number().int(),
    })
  ),
});

export type CreateTaskEntryInput = z.infer<typeof createTaskEntrySchema>;
export type UpdateTaskEntryInput = z.infer<typeof updateTaskEntrySchema>;
