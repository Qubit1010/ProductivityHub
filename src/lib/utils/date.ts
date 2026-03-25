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

export { addDays, subDays, differenceInDays, parseISO, format };
