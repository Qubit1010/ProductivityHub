"use client";

import {
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableHeader,
  TableRow,
} from "@/components/ui/table";
import { ScrollArea } from "@/components/ui/scroll-area";
import type { ColumnMapping } from "@/types";

interface DataPreviewTableProps {
  headers: string[];
  rows: string[][];
  mapping: ColumnMapping;
}

const FIELD_LABELS: Record<string, string> = {
  taskName: "Task Name",
  category: "Category",
  timeRange: "Time Range",
  date: "Date",
  starRating: "Star Rating",
  tag: "Tag",
};

export function DataPreviewTable({
  headers,
  rows,
  mapping,
}: DataPreviewTableProps) {
  const mappedFields = Object.entries(mapping)
    .filter(
      ([key, val]) =>
        typeof val === "number" && val >= 0 && key !== "backlogColumns"
    )
    .map(([key, val]) => ({
      field: key,
      label: FIELD_LABELS[key] ?? key,
      colIndex: val as number,
    }));

  const previewRows = rows.slice(0, 20);

  return (
    <div className="space-y-2">
      <h3 className="text-sm font-medium">
        Data Preview ({Math.min(rows.length, 20)} of {rows.length} rows)
      </h3>
      <ScrollArea className="h-[360px] rounded-md border">
        <Table>
          <TableHeader>
            <TableRow>
              <TableHead className="w-10">#</TableHead>
              {mappedFields.map((f) => (
                <TableHead key={f.field}>
                  <div>
                    <div className="font-medium">{f.label}</div>
                    <div className="text-xs font-normal text-muted-foreground">
                      {headers[f.colIndex]}
                    </div>
                  </div>
                </TableHead>
              ))}
            </TableRow>
          </TableHeader>
          <TableBody>
            {previewRows.map((row, rowIdx) => (
              <TableRow key={rowIdx}>
                <TableCell className="text-muted-foreground">
                  {rowIdx + 1}
                </TableCell>
                {mappedFields.map((f) => (
                  <TableCell key={f.field}>
                    {row[f.colIndex] ?? (
                      <span className="text-muted-foreground">-</span>
                    )}
                  </TableCell>
                ))}
              </TableRow>
            ))}
          </TableBody>
        </Table>
      </ScrollArea>
    </div>
  );
}
