"use client";

import { Button } from "@/components/ui/button";
import { DatePicker } from "@/components/shared/DatePicker";
import { toDateString, subDays, getWeekBounds, format } from "@/lib/utils/date";
import { startOfMonth, format as fnsFormat } from "date-fns";

interface DateRangeSelectorProps {
  from: string;
  to: string;
  onFromChange: (date: string) => void;
  onToChange: (date: string) => void;
}

export function DateRangeSelector({
  from,
  to,
  onFromChange,
  onToChange,
}: DateRangeSelectorProps) {
  const today = toDateString();

  const presets = [
    {
      label: "This Week",
      apply: () => {
        const bounds = getWeekBounds();
        onFromChange(bounds.start);
        onToChange(bounds.end);
      },
    },
    {
      label: "This Month",
      apply: () => {
        const monthStart = fnsFormat(startOfMonth(new Date()), "yyyy-MM-dd");
        onFromChange(monthStart);
        onToChange(today);
      },
    },
    {
      label: "Last 30 Days",
      apply: () => {
        onFromChange(format(subDays(new Date(), 30), "yyyy-MM-dd"));
        onToChange(today);
      },
    },
  ];

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
