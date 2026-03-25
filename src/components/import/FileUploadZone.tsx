"use client";

import { useCallback } from "react";
import { useDropzone } from "react-dropzone";
import { Upload, FileText } from "lucide-react";
import { cn } from "@/lib/utils";

interface FileUploadZoneProps {
  onFileAccepted: (file: File) => void;
  isUploading: boolean;
}

export function FileUploadZone({
  onFileAccepted,
  isUploading,
}: FileUploadZoneProps) {
  const onDrop = useCallback(
    (acceptedFiles: File[]) => {
      if (acceptedFiles.length > 0) {
        onFileAccepted(acceptedFiles[0]);
      }
    },
    [onFileAccepted]
  );

  const { getRootProps, getInputProps, isDragActive, acceptedFiles } =
    useDropzone({
      onDrop,
      accept: { "text/csv": [".csv"] },
      maxFiles: 1,
      disabled: isUploading,
    });

  return (
    <div
      {...getRootProps()}
      className={cn(
        "flex flex-col items-center justify-center rounded-lg border-2 border-dashed p-12 text-center transition-colors cursor-pointer",
        isDragActive
          ? "border-primary bg-primary/5"
          : "border-muted-foreground/25 hover:border-primary/50",
        isUploading && "opacity-50 cursor-not-allowed"
      )}
    >
      <input {...getInputProps()} />
      {acceptedFiles.length > 0 && !isUploading ? (
        <div className="flex flex-col items-center gap-2">
          <FileText className="h-10 w-10 text-green-500" />
          <p className="text-sm font-medium">{acceptedFiles[0].name}</p>
          <p className="text-xs text-muted-foreground">
            {(acceptedFiles[0].size / 1024).toFixed(1)} KB
          </p>
        </div>
      ) : (
        <div className="flex flex-col items-center gap-2">
          <Upload className="h-10 w-10 text-muted-foreground" />
          {isDragActive ? (
            <p className="text-sm font-medium">Drop the CSV file here</p>
          ) : (
            <>
              <p className="text-sm font-medium">
                Drag & drop a CSV file here
              </p>
              <p className="text-xs text-muted-foreground">
                or click to browse files
              </p>
            </>
          )}
          {isUploading && (
            <p className="text-xs text-muted-foreground">Uploading...</p>
          )}
        </div>
      )}
    </div>
  );
}
