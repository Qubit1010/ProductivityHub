/**
 * Parse time string like "02:00PM", "14:00", "2:00 PM" to 24h "HH:mm" format
 */
export function parseTimeString(time: string): string | null {
  if (!time) return null;

  const clean = time.trim().toUpperCase();

  // Already 24h format HH:mm
  const match24 = clean.match(/^(\d{1,2}):(\d{2})$/);
  if (match24) {
    const h = parseInt(match24[1], 10);
    const m = parseInt(match24[2], 10);
    if (h >= 0 && h < 24 && m >= 0 && m < 60) {
      return `${h.toString().padStart(2, "0")}:${m.toString().padStart(2, "0")}`;
    }
  }

  // 12h format like "02:00PM" or "2:00 PM"
  const match12 = clean.match(/^(\d{1,2}):(\d{2})\s*(AM|PM)$/);
  if (match12) {
    let h = parseInt(match12[1], 10);
    const m = parseInt(match12[2], 10);
    const period = match12[3];
    if (period === "PM" && h < 12) h += 12;
    if (period === "AM" && h === 12) h = 0;
    if (h >= 0 && h < 24 && m >= 0 && m < 60) {
      return `${h.toString().padStart(2, "0")}:${m.toString().padStart(2, "0")}`;
    }
  }

  return null;
}

/**
 * Parse a time range string like "02:00PM - 03:00PM" into start/end
 */
export function parseTimeRange(range: string): { start: string; end: string } | null {
  const parts = range.split(/\s*-\s*/);
  if (parts.length !== 2) return null;

  const start = parseTimeString(parts[0]);
  const end = parseTimeString(parts[1]);

  if (!start || !end) return null;
  return { start, end };
}

/**
 * Compute duration in minutes between two HH:mm times.
 * Handles midnight crossing (e.g., 23:00 to 01:00 = 120 minutes).
 */
export function computeDurationMinutes(start: string, end: string): number {
  const [sh, sm] = start.split(":").map(Number);
  const [eh, em] = end.split(":").map(Number);

  const startMin = sh * 60 + sm;
  let endMin = eh * 60 + em;

  if (endMin <= startMin) {
    endMin += 24 * 60; // midnight crossing
  }

  return endMin - startMin;
}

/**
 * Format HH:mm to 12h display like "2:00 PM"
 */
export function formatTime12h(time: string): string {
  const [h, m] = time.split(":").map(Number);
  const period = h >= 12 ? "PM" : "AM";
  const hour12 = h === 0 ? 12 : h > 12 ? h - 12 : h;
  return `${hour12}:${m.toString().padStart(2, "0")} ${period}`;
}

/**
 * Format minutes into human readable "Xh Ym"
 */
export function formatDuration(minutes: number): string {
  if (minutes < 60) return `${minutes}m`;
  const h = Math.floor(minutes / 60);
  const m = minutes % 60;
  return m > 0 ? `${h}h ${m}m` : `${h}h`;
}
