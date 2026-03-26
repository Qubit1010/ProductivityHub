import { z } from "zod";

export const createDailyLogSchema = z.object({
  logDate: z.string().regex(/^\d{4}-\d{2}-\d{2}$/),
  sprintStart: z.string().nullable().optional(),
  sprintEnd: z.string().nullable().optional(),
  notes: z.string().nullable().optional(),
  sleepHours: z.number().min(0).max(24).nullable().optional(),
});

export const updateDailyLogSchema = z.object({
  sprintStart: z.string().nullable().optional(),
  sprintEnd: z.string().nullable().optional(),
  notes: z.string().nullable().optional(),
  sleepHours: z.number().min(0).max(24).nullable().optional(),
});

export type CreateDailyLogInput = z.infer<typeof createDailyLogSchema>;
export type UpdateDailyLogInput = z.infer<typeof updateDailyLogSchema>;
