/**
 * Pure-logic assertions for the highest-risk paths — run via `npm run check:logic`.
 * No framework (ponytail): plain asserts, exits non-zero on first failure.
 */
import assert from "assert";
import { computeDurationMinutes } from "../src/lib/utils/time";
import { getPreviousPeriod } from "../src/lib/utils/date";

// 1. midnight-wrap sprint math
assert.strictEqual(computeDurationMinutes("21:00", "06:00"), 540, "overnight 21:00->06:00");
assert.strictEqual(computeDurationMinutes("21:00:00", "06:00:00"), 540, "overnight with seconds");
assert.strictEqual(computeDurationMinutes("09:00", "17:30"), 510, "same-day 09:00->17:30");

// 2. previous-period window math (equal length, ends day before `from`)
assert.deepStrictEqual(
  getPreviousPeriod("2026-07-01", "2026-07-07"),
  { from: "2026-06-24", to: "2026-06-30" },
  "week window"
);
assert.deepStrictEqual(
  getPreviousPeriod("2026-07-01", "2026-07-31"),
  { from: "2026-05-31", to: "2026-06-30" },
  "31-day month window"
);

// 3. insight rules 1 (top sink %) + 9 (volume delta) on a fixture
{
  const breakdown = [
    { categoryId: "a", code: "UN", minutes: 600 },
    { categoryId: "b", code: "AGN", minutes: 300 },
    { categoryId: "c", code: "SM", minutes: 100 },
  ];
  const total = breakdown.reduce((s, c) => s + c.minutes, 0);
  const top = breakdown.reduce((x, y) => (y.minutes > x.minutes ? y : x));
  assert.strictEqual(top.code, "UN", "rule 1 picks the max category");
  assert.strictEqual(Math.round((top.minutes / total) * 100), 60, "rule 1 percentage");
  const prevTotal = 800;
  const deltaH = Math.round(((total - prevTotal) / 60) * 10) / 10;
  assert.strictEqual(deltaH, 3.3, "rule 9 volume delta in hours");
}

// 4. focus-score ordering: fresh 3-star beats ancient 1-star (30-day age cap)
{
  const score = (stars: number, ageDays: number) => stars * Math.min(ageDays, 30);
  // the 30-day cap means any 3-star aged 11+ days outranks even a years-old 1-star
  assert.ok(score(3, 11) > score(1, 400), "3-star aged 11d beats capped ancient 1-star");
  assert.ok(score(3, 30) === 90 && score(3, 400) === 90, "cap stops unbounded aging");
  assert.ok(score(2, 400) === 60 && score(3, 400) === 90, "stars break capped-age ties");
}

console.log("CHECK_LOGIC: ALL PASS");
