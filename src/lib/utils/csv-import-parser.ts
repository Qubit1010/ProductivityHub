import Papa from "papaparse";
import { parseStarRating, computeDurationMinutes } from "./csv-parser";

/** Full and abbreviated day names → used to detect day-header rows */
const DAY_NAMES = new Set([
  "monday", "tuesday", "wednesday", "thursday", "thurday", "friday", "saturday", "sunday",
  "md", "tu", "wd", "th", "fr", "st", "sn",
]);

/** Month names → used to detect month-header rows (row 0) */
const MONTH_NAMES = new Set([
  "january", "february", "march", "april", "may", "june",
  "july", "august", "september", "october", "november", "december",
]);

/** Category normalization: raw CSV value → { code, name, color } */
const CATEGORY_MAP: Record<string, { code: string; name: string; color: string }> = {
  // Full names (early format)
  "education": { code: "UN", name: "University", color: "#8B5CF6" },
  "work": { code: "WK", name: "Work", color: "#22C55E" },
  "personal": { code: "PR", name: "Personal", color: "#E11D48" },
  "learning": { code: "LR", name: "Learning", color: "#EAB308" },
  "entertainment": { code: "EN", name: "Entertainment", color: "#F59E0B" },
  "time waste": { code: "TW", name: "Time Waste", color: "#6B7280" },
  "general": { code: "GN", name: "General", color: "#6B7280" },
  // Abbreviation codes (later format)
  "wk": { code: "WK", name: "Work", color: "#22C55E" },
  "lr": { code: "LR", name: "Learning", color: "#EAB308" },
  "pr": { code: "PR", name: "Personal", color: "#E11D48" },
  "un": { code: "UN", name: "University", color: "#8B5CF6" },
  "ed": { code: "UN", name: "University", color: "#8B5CF6" },
  "en": { code: "EN", name: "Entertainment", color: "#F59E0B" },
  "tw": { code: "TW", name: "Time Waste", color: "#6B7280" },
  "im": { code: "IM", name: "Important", color: "#EF4444" },
  "sm": { code: "SM", name: "Social Media", color: "#F59E0B" },
  "up": { code: "UP", name: "Upwork", color: "#10B981" },
  "fr": { code: "FR", name: "Freelance", color: "#14B8A6" },
  "rd": { code: "RD", name: "Research & Development", color: "#6366F1" },
  "ats": { code: "ATs", name: "Automations", color: "#F97316" },
  "tls": { code: "TIs", name: "Tools", color: "#84CC16" },
  "agn": { code: "AGN", name: "Agency", color: "#EC4899" },
  "cr": { code: "CR", name: "Code Review", color: "#06B6D4" },
};

export interface ParsedTask {
  date: string; // yyyy-MM-dd
  title: string;
  categoryCode: string;
  categoryName: string;
  categoryColor: string;
  starRating: number;
  timeStart: string | null;
  timeEnd: string | null;
  totalDurationMinutes: number;
  notes: string;
  tag: string; // "" or "missed"
}

export interface ImportParseResult {
  tasks: ParsedTask[];
  sprintTimes: Record<string, { start: string | null; end: string | null }>;
  skippedRows: number;
  errors: string[];
}

/**
 * Parses the user's custom CSV format.
 * Handles both early format (full day/category names) and later format (abbreviations).
 */
export function parseCustomCsv(csvText: string): ImportParseResult {
  const parsed = Papa.parse(csvText, { header: false, skipEmptyLines: false });
  const rows = parsed.data as string[][];

  const tasks: ParsedTask[] = [];
  const errors: string[] = [];
  const sprintTimes: Record<string, { start: string | null; end: string | null }> = {};
  let skippedRows = 0;
  let currentDate = "";

  for (let i = 0; i < rows.length; i++) {
    const row = rows[i];
    if (!row || row.length < 2) {
      skippedRows++;
      continue;
    }

    const col0 = (row[0] || "").trim();
    const col1 = (row[1] || "").trim();
    const col2 = (row[2] || "").trim();
    const col3 = (row[3] || "").trim();
    const col4 = (row[4] || "").trim();
    const col5 = (row[5] || "").trim();
    const col6 = (row[6] || "").trim();
    const col7 = (row[7] || "").trim();

    // Check if this is a month-header row (e.g., "June" in col0)
    if (MONTH_NAMES.has(col0.toLowerCase())) {
      skippedRows++;
      continue;
    }

    // Try to find a date in column 7 (dd/mm/yyyy format)
    const dateFromCol7 = parseDateFromString(col7);
    if (dateFromCol7) {
      currentDate = dateFromCol7;
    }

    // Extract sprint times from col6 (e.g., "Sp 09:00AM - 03:00PM" or "12:00AM - 07:00AM SP")
    if (col6 && currentDate) {
      const sprint = parseSprintTime(col6);
      if (sprint) {
        sprintTimes[currentDate] = sprint;
      }
    }

    // Check if this is a day-header row
    const isDayHeader = DAY_NAMES.has(col0.toLowerCase());

    if (isDayHeader && !col1) {
      // Day header with no task — skip
      skippedRows++;
      continue;
    }

    // Skip rows without a task name
    if (!col1) {
      skippedRows++;
      continue;
    }

    // Skip rows without a current date context
    if (!currentDate) {
      skippedRows++;
      continue;
    }

    // Determine tag from col0
    let tag = "";
    if (col0.toLowerCase() === "missed") {
      tag = "missed";
    }

    // Parse star rating
    const starRating = col2 ? parseStarRating(col2) : 1;

    // Normalize category
    const resolved = resolveCategory(col3);

    // Parse time ranges
    const timeRanges = parseMultipleTimeRanges(col4);
    let totalDuration = 0;
    for (const range of timeRanges) {
      if (range.start && range.end) {
        totalDuration += computeDurationMinutes(range.start, range.end);
      }
    }

    // Handle text durations (e.g., "1 Hour", "30 Minutes")
    if (totalDuration === 0 && col4) {
      totalDuration = parseTextDuration(col4);
    }

    const firstRange = timeRanges[0];

    tasks.push({
      date: currentDate,
      title: col1,
      categoryCode: resolved.code,
      categoryName: resolved.name,
      categoryColor: resolved.color,
      starRating,
      timeStart: firstRange?.start || null,
      timeEnd: firstRange?.end || null,
      totalDurationMinutes: totalDuration,
      notes: col5,
      tag,
    });
  }

  return { tasks, sprintTimes, skippedRows, errors };
}

/** Resolve a raw category string to a normalized { code, name, color } */
function resolveCategory(raw: string): { code: string; name: string; color: string } {
  if (!raw) return { code: "GN", name: "General", color: "#6B7280" };
  const lookup = CATEGORY_MAP[raw.toLowerCase()];
  if (lookup) return lookup;
  // Unknown category — use the raw value as both code and name
  const code = raw.substring(0, 10).toUpperCase().replace(/\s+/g, "");
  return { code, name: raw, color: "#6B7280" };
}

/** Parse dd/mm/yyyy date string to yyyy-MM-dd */
function parseDateFromString(str: string): string | null {
  if (!str) return null;
  const match = str.match(/^(\d{1,2})\/(\d{1,2})\/(\d{4})$/);
  if (!match) return null;
  const day = match[1].padStart(2, "0");
  const month = match[2].padStart(2, "0");
  const year = match[3];
  return `${year}-${month}-${day}`;
}

/** Parse sprint time from col6 like "Sp 09:00AM - 03:00PM" or "12:00AM - 07:00AM SP" */
function parseSprintTime(str: string): { start: string | null; end: string | null } | null {
  if (!str.toLowerCase().includes("sp")) return null;
  const match = str.match(
    /(\d{1,2}:\d{2}\s*(?:AM|PM)?)\s*[-–]\s*(\d{1,2}:\d{2}\s*(?:AM|PM)?)/i
  );
  if (!match) return null;
  return {
    start: normalizeTime(match[1].trim()),
    end: normalizeTime(match[2].trim()),
  };
}

/** Parse time ranges like "4:30AM - 5:05AM" or "4:30AM - 5:05AM, 7:30PM - 8:30PM" */
function parseMultipleTimeRanges(timeStr: string): { start: string; end: string | null }[] {
  if (!timeStr) return [];

  const ranges: { start: string; end: string | null }[] = [];
  const parts = timeStr.split(",").map((s) => s.trim()).filter(Boolean);

  for (const part of parts) {
    // Full range: "4:30AM - 5:05AM"
    const fullMatch = part.match(
      /(\d{1,2}:\d{2}\s*(?:AM|PM)?)\s*[-–]\s*(\d{1,2}:\d{2,3}\s*(?:AM|PM)?)/i
    );
    if (fullMatch) {
      const start = normalizeTime(fullMatch[1].trim());
      const end = normalizeTime(fullMatch[2].trim());
      if (start) {
        ranges.push({ start, end: end || null });
      }
      continue;
    }

    // Incomplete range: "05:30AM -" (no end time)
    const partialMatch = part.match(
      /(\d{1,2}:\d{2}\s*(?:AM|PM)?)\s*[-–]\s*$/i
    );
    if (partialMatch) {
      const start = normalizeTime(partialMatch[1].trim());
      if (start) {
        ranges.push({ start, end: null });
      }
      continue;
    }

    // Standalone time: "11:45AM" (no dash at all)
    const standaloneMatch = part.match(/^(\d{1,2}:\d{2}\s*(?:AM|PM)?)$/i);
    if (standaloneMatch) {
      const start = normalizeTime(standaloneMatch[1].trim());
      if (start) {
        ranges.push({ start, end: null });
      }
    }
  }

  return ranges;
}

/** Parse text durations like "1 Hour", "30 Minutes", "1.5 Hours" */
function parseTextDuration(str: string): number {
  const hourMatch = str.match(/([\d.]+)\s*hours?/i);
  if (hourMatch) return Math.round(parseFloat(hourMatch[1]) * 60);

  const minMatch = str.match(/([\d.]+)\s*(?:minutes?|mins?)/i);
  if (minMatch) return Math.round(parseFloat(minMatch[1]));

  return 0;
}

function normalizeTime(time: string): string {
  const match = time.match(/(\d{1,2}):(\d{2,3})\s*(AM|PM)?/i);
  if (!match) return time;

  let hours = parseInt(match[1], 10);
  const minutes = match[2].slice(0, 2); // Handle typos like "07:300AM"
  const period = match[3]?.toUpperCase();

  if (period === "PM" && hours !== 12) hours += 12;
  if (period === "AM" && hours === 12) hours = 0;

  return `${hours.toString().padStart(2, "0")}:${minutes}`;
}
