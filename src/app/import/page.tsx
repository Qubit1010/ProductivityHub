"use client";

import { useState } from "react";
import { AppShell } from "@/components/layout/AppShell";
import { FileUploadZone } from "@/components/import/FileUploadZone";
import { ImportProgressBar } from "@/components/import/ImportProgressBar";
import { api } from "@/lib/api/client";
import { Button } from "@/components/ui/button";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import type { Import } from "@/types";

type ImportStep = "upload" | "importing" | "done" | "error";

export default function ImportPage() {
  const [step, setStep] = useState<ImportStep>("upload");
  const [isUploading, setIsUploading] = useState(false);
  const [importData, setImportData] = useState<Import | null>(null);
  const [errorMessage, setErrorMessage] = useState<string>("");

  async function handleFileUpload(file: File) {
    setIsUploading(true);
    setStep("importing");
    setImportData({
      id: "",
      filename: file.name,
      rowCount: 0,
      rowsImported: 0,
      rowsSkipped: 0,
      status: "processing",
      errorLog: null,
      createdAt: new Date().toISOString(),
    });

    try {
      const data = await api.import.processFile(file);
      setImportData(data.import);
      setStep("done");
    } catch (err) {
      const msg = err instanceof Error ? err.message : "Import failed";
      setErrorMessage(msg);
      setStep("error");
    } finally {
      setIsUploading(false);
    }
  }

  function handleReset() {
    setStep("upload");
    setImportData(null);
    setErrorMessage("");
  }

  return (
    <AppShell>
      <div className="space-y-6 max-w-4xl">
        <h1 className="text-3xl font-bold">Import CSV</h1>
        <p className="text-muted-foreground">
          Upload your task log CSV file. It will be processed and imported automatically.
        </p>

        {step === "upload" && (
          <FileUploadZone onFileAccepted={handleFileUpload} isUploading={isUploading} />
        )}

        {step === "importing" && importData && (
          <ImportProgressBar importData={importData} />
        )}

        {step === "done" && importData && (
          <Card>
            <CardHeader><CardTitle>Import Complete</CardTitle></CardHeader>
            <CardContent className="space-y-3">
              <p className="text-green-600 dark:text-green-400 font-medium">
                {importData.rowsImported} tasks imported successfully
              </p>
              {importData.rowsSkipped > 0 && (
                <p className="text-yellow-600 dark:text-yellow-400">
                  {importData.rowsSkipped} rows skipped (empty rows, headers, etc.)
                </p>
              )}
              {importData.errorLog && (
                <details className="text-sm">
                  <summary className="cursor-pointer text-muted-foreground">
                    View import errors
                  </summary>
                  <pre className="mt-2 p-3 bg-muted rounded-md text-xs whitespace-pre-wrap max-h-60 overflow-auto">
                    {importData.errorLog}
                  </pre>
                </details>
              )}
              <Button onClick={handleReset}>Import Another File</Button>
            </CardContent>
          </Card>
        )}

        {step === "error" && (
          <Card>
            <CardHeader><CardTitle>Import Failed</CardTitle></CardHeader>
            <CardContent className="space-y-3">
              <p className="text-red-600 dark:text-red-400">{errorMessage}</p>
              <Button onClick={handleReset}>Try Again</Button>
            </CardContent>
          </Card>
        )}
      </div>
    </AppShell>
  );
}
