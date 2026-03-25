"use client";

import { Flame, Trophy } from "lucide-react";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { LoadingSpinner } from "@/components/shared/LoadingSpinner";
import { useStreaks } from "@/hooks/useAnalytics";

export function StreakBadge() {
  const { data, isLoading } = useStreaks();

  if (isLoading) {
    return (
      <Card>
        <CardContent className="flex h-24 items-center justify-center">
          <LoadingSpinner />
        </CardContent>
      </Card>
    );
  }

  const currentStreak = data?.currentStreak ?? 0;
  const bestStreak = data?.bestStreak ?? 0;

  return (
    <Card>
      <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
        <CardTitle className="text-sm font-medium">Streak</CardTitle>
        <Flame className="h-4 w-4 text-orange-500" />
      </CardHeader>
      <CardContent>
        <div className="flex items-center gap-4">
          <div>
            <div className="flex items-center gap-1.5">
              <Flame className="h-5 w-5 text-orange-500" />
              <span className="text-2xl font-bold">{currentStreak}</span>
            </div>
            <p className="text-xs text-muted-foreground">Current streak</p>
          </div>
          <div className="h-8 w-px bg-border" />
          <div>
            <div className="flex items-center gap-1.5">
              <Trophy className="h-5 w-5 text-yellow-500" />
              <span className="text-2xl font-bold">{bestStreak}</span>
            </div>
            <p className="text-xs text-muted-foreground">Best streak</p>
          </div>
        </div>
      </CardContent>
    </Card>
  );
}
