"use client";

import { CheckCircle, AlertCircle, Loader2 } from "lucide-react";
import { Progress } from "@/components/ui/progress";
import type { Import } from "@/types";

interface ImportProgressBarProps {
  importData: Import;
}

export function ImportProgressBar({ importData }: ImportProgressBarProps) {
  const { status, rowCount, rowsImported, rowsSkipped, errorLog } = importData;
  const progress =
    rowCount > 0 ? ((rowsImported + rowsSkipped) / rowCount) * 100 : 0;

  return (
    <div className="space-y-4 rounded-lg border p-4">
      <div className="flex items-center gap-3">
        {status === "processing" && (
          <Loader2 className="h-5 w-5 animate-spin text-primary" />
        )}
        {status === "complete" && (
          <CheckCircle className="h-5 w-5 text-green-500" />
        )}
        {status === "failed" && (
          <AlertCircle className="h-5 w-5 text-destructive" />
        )}
        <div>
          <p className="text-sm font-medium">
            {status === "processing" && "Importing..."}
            {status === "complete" && "Import Complete"}
            {status === "failed" && "Import Failed"}
            {status === "pending" && "Preparing import..."}
          </p>
          <p className="text-xs text-muted-foreground">
            {importData.filename}
          </p>
        </div>
      </div>

      <Progress value={progress} className="h-2" />

      <div className="grid grid-cols-3 gap-4 text-center text-sm">
        <div>
          <p className="text-lg font-bold">{rowsImported}</p>
          <p className="text-xs text-muted-foreground">Imported</p>
        </div>
        <div>
          <p className="text-lg font-bold">{rowsSkipped}</p>
          <p className="text-xs text-muted-foreground">Skipped</p>
        </div>
        <div>
          <p className="text-lg font-bold">{rowCount}</p>
          <p className="text-xs text-muted-foreground">Total</p>
        </div>
      </div>

      {errorLog && (
        <div className="rounded-md bg-destructive/10 p-3">
          <p className="text-xs text-destructive">{errorLog}</p>
        </div>
      )}
    </div>
  );
}
