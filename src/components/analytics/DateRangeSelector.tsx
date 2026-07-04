"use client";

import { Button } from "@/components/ui/button";
import { DatePicker } from "@/components/shared/DatePicker";
import { getPresetRange, type RangePreset } from "@/lib/utils/date";

interface DateRangeSelectorProps {
  from: string;
  to: string;
  onFromChange: (date: string) => void;
  onToChange: (date: string) => void;
}

const PRESETS: { label: string; preset: RangePreset }[] = [
  { label: "This Week", preset: "this-week" },
  { label: "Last Week", preset: "last-week" },
  { label: "This Month", preset: "this-month" },
  { label: "Last Month", preset: "last-month" },
  { label: "This Quarter", preset: "this-quarter" },
  { label: "Last Quarter", preset: "last-quarter" },
  { label: "Last 30 Days", preset: "last-30-days" },
];

export function DateRangeSelector({
  from,
  to,
  onFromChange,
  onToChange,
}: DateRangeSelectorProps) {
  const presets = PRESETS.map(({ label, preset }) => ({
    label,
    apply: () => {
      const range = getPresetRange(preset);
      onFromChange(range.from);
      onToChange(range.to);
    },
  }));

  return (
    <div className="flex flex-wrap items-center gap-2">
      <DatePicker value={from} onChange={onFromChange} placeholder="From" className="w-[160px]" />
      <span className="text-muted-foreground">to</span>
      <DatePicker value={to} onChange={onToChange} placeholder="To" className="w-[160px]" />
      <div className="flex gap-1">
        {presets.map((preset) => (
          <Button
            key={preset.label}
            variant="outline"
            size="sm"
            onClick={preset.apply}
          >
            {preset.label}
          </Button>
        ))}
      </div>
    </div>
  );
}
