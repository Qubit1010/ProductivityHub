import { z } from "zod";

export const createWeeklyGoalSchema = z.object({
  categoryId: z.string().uuid(),
  weekStart: z.string().regex(/^\d{4}-\d{2}-\d{2}$/),
  targetMinutes: z.number().int().positive(),
});

export const updateWeeklyGoalSchema = z.object({
  targetMinutes: z.number().int().positive(),
});

export type CreateWeeklyGoalInput = z.infer<typeof createWeeklyGoalSchema>;
export type UpdateWeeklyGoalInput = z.infer<typeof updateWeeklyGoalSchema>;
