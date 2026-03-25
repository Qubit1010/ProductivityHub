import { z } from "zod";

export const createBacklogItemSchema = z.object({
  categoryId: z.string().uuid(),
  title: z.string().min(1).max(255),
  starRating: z.number().int().min(1).max(3).default(1),
});

export const updateBacklogItemSchema = z.object({
  title: z.string().min(1).max(255).optional(),
  starRating: z.number().int().min(1).max(3).optional(),
  categoryId: z.string().uuid().optional(),
  isActive: z.boolean().optional(),
});

export type CreateBacklogItemInput = z.infer<typeof createBacklogItemSchema>;
export type UpdateBacklogItemInput = z.infer<typeof updateBacklogItemSchema>;
