"use client";

import { useState } from "react";
import Link from "next/link";
import { format, startOfWeek, endOfWeek, addWeeks, subWeeks } from "date-fns";
import { AppShell } from "@/components/layout/AppShell";
import { useDailyBreakdown, useAnalyticsSummary } from "@/hooks/useAnalytics";
import { Button } from "@/components/ui/button";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { ChevronLeft, ChevronRight } from "lucide-react";

const hrs = (min: number) => Math.round((min / 60) * 10) / 10;

export default function WeekPage() {
  const [currentDate, setCurrentDate] = useState(new Date());
  const weekStart = startOfWeek(currentDate, { weekStartsOn: 1 });
  const weekEnd = endOfWeek(currentDate, { weekStartsOn: 1 });
  const from = format(weekStart, "yyyy-MM-dd");
  const to = format(weekEnd, "yyyy-MM-dd");

  const { data: days } = useDailyBreakdown(from, to);
  const { data: summary } = useAnalyticsSummary(from, to);

  const topCats = (summary?.categoryBreakdown ?? [])
    .slice()
    .sort((a, b) => b.minutes - a.minutes)
    .slice(0, 3);
  const bestDay = (days ?? []).reduce<{ date: string; totalMinutes: number } | null>(
    (acc, d) =>
      !acc || d.totalMinutes > acc.totalMinutes ? { date: d.date, totalMinutes: d.totalMinutes } : acc,
    null
  );

  return (
    <AppShell>
      <div className="space-y-6">
        <div className="flex items-center justify-between">
          <h1 className="text-3xl font-bold">Weekly View</h1>
          <div className="flex items-center gap-2">
            <Button variant="outline" size="icon" onClick={() => setCurrentDate(subWeeks(currentDate, 1))}>
              <ChevronLeft className="h-4 w-4" />
            </Button>
            <span className="min-w-[200px] text-center text-sm font-medium">
              {format(weekStart, "MMM d")} — {format(weekEnd, "MMM d, yyyy")}
            </span>
            <Button variant="outline" size="icon" onClick={() => setCurrentDate(addWeeks(currentDate, 1))}>
              <ChevronRight className="h-4 w-4" />
            </Button>
          </div>
        </div>

        <Card>
          <CardContent className="flex flex-wrap items-center gap-x-8 gap-y-3 py-4">
            <div>
              <p className="text-xs text-muted-foreground">Total</p>
              <p className="text-xl font-bold">{hrs(summary?.totalMinutes ?? 0)}h</p>
            </div>
            <div>
              <p className="text-xs text-muted-foreground">Tasks done</p>
              <p className="text-xl font-bold">
                {summary?.tasksCompleted ?? 0}/{summary?.tasksTotal ?? 0}
                <span className="ml-1 text-sm font-normal text-muted-foreground">
                  ({summary?.completionRate ?? 0}%)
                </span>
              </p>
            </div>
            <div>
              <p className="text-xs text-muted-foreground">Best day</p>
              <p className="text-xl font-bold">
                {bestDay && bestDay.totalMinutes > 0
                  ? `${format(new Date(bestDay.date), "EEE")} · ${hrs(bestDay.totalMinutes)}h`
                  : "—"}
              </p>
            </div>
            {topCats.length > 0 && (
              <div>
                <p className="text-xs text-muted-foreground">Top categories</p>
                <div className="mt-1 flex flex-wrap gap-1.5">
                  {topCats.map((c) => (
                    <span
                      key={c.categoryId}
                      className="inline-flex items-center gap-1 rounded-full border px-2 py-0.5 text-xs"
                    >
                      <span className="h-2 w-2 rounded-full" style={{ backgroundColor: c.color }} />
                      {c.code} · {hrs(c.minutes)}h
                    </span>
                  ))}
                </div>
              </div>
            )}
          </CardContent>
        </Card>

        <div className="grid grid-cols-7 gap-2">
          {(days || []).map((day) => (
            <Link key={day.date} href={`/day/${day.date}`} className="block">
              <Card className="min-h-[120px] transition-colors hover:border-primary hover:bg-accent/50">
                <CardHeader className="p-3 pb-1">
                  <CardTitle className="text-xs font-medium text-muted-foreground">
                    {format(new Date(day.date), "EEE d")}
                  </CardTitle>
                </CardHeader>
                <CardContent className="p-3 pt-0">
                  <p className="text-lg font-bold">
                    {day.tasksCompleted}/{day.tasksTotal}
                  </p>
                  <p className="text-xs text-muted-foreground">{hrs(day.totalMinutes)}h</p>
                  <div className="mt-2 flex gap-0.5">
                    {day.categories.map((cat) => (
                      <div
                        key={cat.categoryId}
                        className="h-2 rounded-full"
                        style={{ backgroundColor: cat.color, flex: cat.minutes }}
                      />
                    ))}
                  </div>
                </CardContent>
              </Card>
            </Link>
          ))}
        </div>
      </div>
    </AppShell>
  );
}
