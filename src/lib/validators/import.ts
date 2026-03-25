import { z } from "zod";

export const columnMappingSchema = z.object({
  taskName: z.number().int().min(0),
  category: z.number().int().min(0),
  timeRange: z.number().int().min(0),
  date: z.number().int().min(0),
  starRating: z.number().int().min(0).optional(),
  tag: z.number().int().min(0).optional(),
  backlogColumns: z
    .array(
      z.object({
        columnIndex: z.number().int().min(0),
        categoryCode: z.string(),
      })
    )
    .optional(),
});

export const confirmImportSchema = z.object({
  importId: z.string().uuid(),
  mapping: columnMappingSchema,
});

export type ColumnMappingInput = z.infer<typeof columnMappingSchema>;
export type ConfirmImportInput = z.infer<typeof confirmImportSchema>;
