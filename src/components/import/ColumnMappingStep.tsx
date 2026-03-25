"use client";

import { Label } from "@/components/ui/label";
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select";
import type { ColumnMapping } from "@/types";

interface ColumnMappingStepProps {
  headers: string[];
  mapping: ColumnMapping;
  onMappingChange: (mapping: ColumnMapping) => void;
}

const UNMAPPED = "__unmapped__";

export function ColumnMappingStep({
  headers,
  mapping,
  onMappingChange,
}: ColumnMappingStepProps) {
  const fields = [
    { key: "taskName" as const, label: "Task Name", required: true },
    { key: "category" as const, label: "Category", required: true },
    { key: "timeRange" as const, label: "Time Range", required: true },
    { key: "date" as const, label: "Date", required: true },
    { key: "starRating" as const, label: "Star Rating", required: false },
    { key: "tag" as const, label: "Tag", required: false },
  ];

  const handleChange = (
    field: keyof ColumnMapping,
    value: string
  ) => {
    const numValue = value === UNMAPPED ? -1 : parseInt(value, 10);
    onMappingChange({
      ...mapping,
      [field]: numValue,
    });
  };

  return (
    <div className="space-y-4">
      <div>
        <h3 className="text-sm font-medium">Map CSV Columns</h3>
        <p className="text-xs text-muted-foreground mt-1">
          Match each CSV column to the corresponding field. Required fields are
          marked with *.
        </p>
      </div>

      <div className="grid gap-4 sm:grid-cols-2">
        {fields.map((field) => {
          const currentValue =
            mapping[field.key] !== undefined && mapping[field.key] !== -1
              ? String(mapping[field.key])
              : UNMAPPED;

          return (
            <div key={field.key} className="space-y-1.5">
              <Label className="text-sm">
                {field.label}
                {field.required && (
                  <span className="text-destructive ml-0.5">*</span>
                )}
              </Label>
              <Select
                value={currentValue}
                onValueChange={(v) => handleChange(field.key, v)}
              >
                <SelectTrigger>
                  <SelectValue placeholder="Select column" />
                </SelectTrigger>
                <SelectContent>
                  <SelectItem value={UNMAPPED}>-- Not mapped --</SelectItem>
                  {headers.map((header, idx) => (
                    <SelectItem key={idx} value={String(idx)}>
                      {header} (Col {idx + 1})
                    </SelectItem>
                  ))}
                </SelectContent>
              </Select>
            </div>
          );
        })}
      </div>
    </div>
  );
}
