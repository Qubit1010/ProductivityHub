"use client";

import { useState } from "react";
import { format, startOfWeek, endOfWeek, addWeeks, subWeeks } from "date-fns";
import { AppShell } from "@/components/layout/AppShell";
import { WeeklyGoalProgress } from "@/components/analytics/WeeklyGoalProgress";
import { useDailyBreakdown } from "@/hooks/useAnalytics";
import { Button } from "@/components/ui/button";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { ChevronLeft, ChevronRight } from "lucide-react";

export default function WeekPage() {
  const [currentDate, setCurrentDate] = useState(new Date());
  const weekStart = startOfWeek(currentDate, { weekStartsOn: 1 });
  const weekEnd = endOfWeek(currentDate, { weekStartsOn: 1 });
  const from = format(weekStart, "yyyy-MM-dd");
  const to = format(weekEnd, "yyyy-MM-dd");

  const { data: days } = useDailyBreakdown(from, to);

  return (
    <AppShell>
      <div className="space-y-6">
        <div className="flex items-center justify-between">
          <h1 className="text-3xl font-bold">Weekly View</h1>
          <div className="flex items-center gap-2">
            <Button variant="outline" size="icon" onClick={() => setCurrentDate(subWeeks(currentDate, 1))}>
              <ChevronLeft className="h-4 w-4" />
            </Button>
            <span className="text-sm font-medium min-w-[200px] text-center">
              {format(weekStart, "MMM d")} — {format(weekEnd, "MMM d, yyyy")}
            </span>
            <Button variant="outline" size="icon" onClick={() => setCurrentDate(addWeeks(currentDate, 1))}>
              <ChevronRight className="h-4 w-4" />
            </Button>
          </div>
        </div>

        <div className="grid grid-cols-7 gap-2">
          {(days || []).map((day: { date: string; totalMinutes: number; tasksCompleted: number; tasksTotal: number; categories: { categoryId: string; code: string; color: string; minutes: number }[] }) => (
            <Card key={day.date} className="min-h-[120px]">
              <CardHeader className="p-3 pb-1">
                <CardTitle className="text-xs font-medium text-muted-foreground">
                  {format(new Date(day.date), "EEE d")}
                </CardTitle>
              </CardHeader>
              <CardContent className="p-3 pt-0">
                <p className="text-lg font-bold">{day.tasksCompleted}/{day.tasksTotal}</p>
                <p className="text-xs text-muted-foreground">{Math.round(day.totalMinutes / 60 * 10) / 10}h</p>
                <div className="flex gap-0.5 mt-2">
                  {day.categories.map((cat: { categoryId: string; color: string; minutes: number }) => (
                    <div
                      key={cat.categoryId}
                      className="h-2 rounded-full"
                      style={{
                        backgroundColor: cat.color,
                        flex: cat.minutes,
                      }}
                    />
                  ))}
                </div>
              </CardContent>
            </Card>
          ))}
        </div>

        <WeeklyGoalProgress weekStart={from} />
      </div>
    </AppShell>
  );
}
