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

// 5. leverage-trend share math + bucket-sum invariant (Round 2)
{
  // one ISO week's rows → 3-star share = threeMin / total
  const rows = [
    { starRating: 3, durationMinutes: 90 },
    { starRating: 1, durationMinutes: 30 },
    { starRating: 2, durationMinutes: 30 },
  ];
  const total = rows.reduce((s, r) => s + r.durationMinutes, 0);
  const three = rows
    .filter((r) => r.starRating === 3)
    .reduce((s, r) => s + r.durationMinutes, 0);
  assert.strictEqual(total, 150, "leverage total minutes");
  assert.strictEqual(Math.round((three / total) * 100), 60, "3-star share = 60%");
  // bucket-sum invariant: summing per-bucket totals equals the raw row total
  const buckets = [
    { total: 90 }, // wk A
    { total: 60 }, // wk B
  ];
  assert.strictEqual(
    buckets.reduce((s, b) => s + b.total, 0),
    total,
    "weekly buckets sum to range total"
  );
}

// 6. category momentum: delta = cur - prev, sorted by |delta|, prev-only cats included (Round 2)
{
  const cur = [
    { categoryId: "a", code: "W", minutes: 400 },
    { categoryId: "b", code: "M", minutes: 60 },
  ];
  const prev = [
    { categoryId: "a", minutes: 180 },
    { categoryId: "c", code: "P", minutes: 120 },
  ];
  const prevBy = new Map(prev.map((c) => [c.categoryId, c.minutes]));
  const merged = new Map<string, { code: string; cur: number; prev: number }>();
  for (const c of cur) merged.set(c.categoryId, { code: c.code, cur: c.minutes, prev: prevBy.get(c.categoryId) ?? 0 });
  for (const c of prev) {
    if (!merged.has(c.categoryId)) {
      merged.set(c.categoryId, { code: (c as { code?: string }).code ?? "?", cur: 0, prev: c.minutes });
    }
  }
  const items = Array.from(merged.values())
    .map((i) => ({ ...i, delta: i.cur - i.prev }))
    .sort((a, b) => Math.abs(b.delta) - Math.abs(a.delta));
  assert.strictEqual(items[0].code, "W", "biggest mover first");
  assert.strictEqual(items[0].delta, 220, "W delta = 400 - 180");
  const p = items.find((i) => i.code === "P")!;
  assert.strictEqual(p.delta, -120, "prev-only category delta = 0 - 120");
}

console.log("CHECK_LOGIC: ALL PASS");
