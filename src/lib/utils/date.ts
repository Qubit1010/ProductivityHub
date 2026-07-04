import {
  format,
  parseISO,
  startOfWeek,
  endOfWeek,
  addDays,
  subDays,
  isToday,
  isYesterday,
  differenceInDays,
  startOfMonth,
  endOfMonth,
  subMonths,
  startOfQuarter,
  endOfQuarter,
  subQuarters,
} from "date-fns";

export function formatDate(date: string | Date, fmt: string = "MMM d, yyyy") {
  const d = typeof date === "string" ? parseISO(date) : date;
  return format(d, fmt);
}

export function formatDateShort(date: string | Date) {
  return formatDate(date, "MMM d");
}

export function getWeekBounds(date: Date = new Date()) {
  const start = startOfWeek(date, { weekStartsOn: 1 });
  const end = endOfWeek(date, { weekStartsOn: 1 });
  return {
    start: format(start, "yyyy-MM-dd"),
    end: format(end, "yyyy-MM-dd"),
  };
}

export function getWeekDays(weekStart: string): string[] {
  const start = parseISO(weekStart);
  return Array.from({ length: 7 }, (_, i) => format(addDays(start, i), "yyyy-MM-dd"));
}

export function toDateString(date: Date = new Date()) {
  return format(date, "yyyy-MM-dd");
}

export function getRelativeDay(date: string): string {
  const d = parseISO(date);
  if (isToday(d)) return "Today";
  if (isYesterday(d)) return "Yesterday";
  return formatDate(date, "EEEE, MMM d");
}

/**
 * Equal-length window immediately before [from, to] — ends the day before `from`.
 * Used for period-over-period insight comparisons.
 */
export function getPreviousPeriod(from: string, to: string) {
  const lengthDays = differenceInDays(parseISO(to), parseISO(from)) + 1;
  const prevTo = subDays(parseISO(from), 1);
  const prevFrom = subDays(prevTo, lengthDays - 1);
  return {
    from: format(prevFrom, "yyyy-MM-dd"),
    to: format(prevTo, "yyyy-MM-dd"),
  };
}

export type RangePreset =
  | "this-week"
  | "last-week"
  | "this-month"
  | "last-month"
  | "this-quarter"
  | "last-quarter"
  | "last-30-days";

export function getPresetRange(preset: RangePreset): { from: string; to: string } {
  const now = new Date();
  const fmt = (d: Date) => format(d, "yyyy-MM-dd");
  switch (preset) {
    case "this-week": {
      const b = getWeekBounds(now);
      return { from: b.start, to: b.end };
    }
    case "last-week": {
      const b = getWeekBounds(subDays(startOfWeek(now, { weekStartsOn: 1 }), 1));
      return { from: b.start, to: b.end };
    }
    case "this-month":
      return { from: fmt(startOfMonth(now)), to: fmt(now) };
    case "last-month": {
      const m = subMonths(now, 1);
      return { from: fmt(startOfMonth(m)), to: fmt(endOfMonth(m)) };
    }
    case "this-quarter":
      return { from: fmt(startOfQuarter(now)), to: fmt(now) };
    case "last-quarter": {
      const q = subQuarters(now, 1);
      return { from: fmt(startOfQuarter(q)), to: fmt(endOfQuarter(q)) };
    }
    case "last-30-days":
      return { from: fmt(subDays(now, 30)), to: fmt(now) };
  }
}

export { addDays, subDays, differenceInDays, parseISO, format };
