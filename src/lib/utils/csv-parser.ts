import type { ColumnMapping } from "@/types";

export function detectColumnMapping(headers: string[]): Partial<ColumnMapping> {
  const mapping: Partial<ColumnMapping> = {};
  const lowerHeaders = headers.map((h) => h.toLowerCase().trim());

  for (let i = 0; i < lowerHeaders.length; i++) {
    const h = lowerHeaders[i];
    if (h.includes("task") || h.includes("name") || h.includes("description")) {
      mapping.taskName = i;
    } else if (h.includes("category") || h.includes("code") || h.includes("type")) {
      mapping.category = i;
    } else if (h.includes("time") || h.includes("range") || h.includes("duration")) {
      mapping.timeRange = i;
    } else if (h.includes("date") || h.includes("day")) {
      mapping.date = i;
    } else if (h.includes("star") || h.includes("rating") || h.includes("priority")) {
      mapping.starRating = i;
    } else if (h.includes("tag") || h.includes("status")) {
      mapping.tag = i;
    }
  }

  return mapping;
}

export function parseTimeRange(timeStr: string): { start: string; end: string } | null {
  if (!timeStr) return null;

  const match = timeStr.match(
    /(\d{1,2}:\d{2}\s*(?:AM|PM)?)\s*[-–]\s*(\d{1,2}:\d{2}\s*(?:AM|PM)?)/i
  );
  if (!match) return null;

  return {
    start: normalizeTime(match[1].trim()),
    end: normalizeTime(match[2].trim()),
  };
}

function normalizeTime(time: string): string {
  const match = time.match(/(\d{1,2}):(\d{2})\s*(AM|PM)?/i);
  if (!match) return time;

  let hours = parseInt(match[1], 10);
  const minutes = match[2];
  const period = match[3]?.toUpperCase();

  if (period === "PM" && hours !== 12) hours += 12;
  if (period === "AM" && hours === 12) hours = 0;

  return `${hours.toString().padStart(2, "0")}:${minutes}`;
}

export function parseStarRating(value: string): number {
  const cleaned = value.trim();
  const starCount = (cleaned.match(/⭐|★|✭|\*/g) || []).length;
  if (starCount > 0) return Math.min(starCount, 3);

  const num = parseInt(cleaned, 10);
  if (!isNaN(num) && num >= 1 && num <= 3) return num;

  return 1;
}

export function computeDurationMinutes(start: string, end: string): number {
  const [startH, startM] = start.split(":").map(Number);
  const [endH, endM] = end.split(":").map(Number);
  const startTotal = startH * 60 + startM;
  let endTotal = endH * 60 + endM;
  if (endTotal <= startTotal) endTotal += 24 * 60;
  return endTotal - startTotal;
}
