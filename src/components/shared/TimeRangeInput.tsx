"use client";

import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { cn } from "@/lib/utils";

interface TimeRangeInputProps {
  startValue: string;
  endValue: string;
  onStartChange: (value: string) => void;
  onEndChange: (value: string) => void;
  className?: string;
}

export function TimeRangeInput({
  startValue,
  endValue,
  onStartChange,
  onEndChange,
  className,
}: TimeRangeInputProps) {
  return (
    <div className={cn("flex items-center gap-2", className)}>
      <div className="flex-1">
        <Label htmlFor="time-start" className="text-xs text-muted-foreground">
          Start
        </Label>
        <Input
          id="time-start"
          type="time"
          value={startValue}
          onChange={(e) => onStartChange(e.target.value)}
          className="h-9"
        />
      </div>
      <span className="mt-5 text-muted-foreground">-</span>
      <div className="flex-1">
        <Label htmlFor="time-end" className="text-xs text-muted-foreground">
          End
        </Label>
        <Input
          id="time-end"
          type="time"
          value={endValue}
          onChange={(e) => onEndChange(e.target.value)}
          className="h-9"
        />
      </div>
    </div>
  );
}
