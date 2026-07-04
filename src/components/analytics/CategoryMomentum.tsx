"use client";

import { ArrowDown, ArrowUp } from "lucide-react";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { LoadingSpinner } from "@/components/shared/LoadingSpinner";
import { useMomentum } from "@/hooks/useAnalytics";

interface CategoryMomentumProps {
  from: string;
  to: string;
}

const hrs = (min: number) => Math.round((min / 60) * 10) / 10;

export function CategoryMomentum({ from, to }: CategoryMomentumProps) {
  const { data: items, isLoading } = useMomentum(from, to);

  if (isLoading) {
    return (
      <Card>
        <CardContent className="flex h-40 items-center justify-center">
          <LoadingSpinner />
        </CardContent>
      </Card>
    );
  }

  // only surface moves worth noticing (>= 15 min shift), top 8 by magnitude
  const movers = (items ?? []).filter((i) => Math.abs(i.deltaMinutes) >= 15).slice(0, 8);

  return (
    <Card>
      <CardHeader>
        <CardTitle className="text-base">Category momentum</CardTitle>
        <p className="text-xs text-muted-foreground">vs previous period</p>
      </CardHeader>
      <CardContent>
        {movers.length === 0 ? (
          <p className="text-sm text-muted-foreground">
            No notable category shifts vs the previous period.
          </p>
        ) : (
          <ul className="space-y-1.5">
            {movers.map((i) => {
              const up = i.deltaMinutes > 0;
              const Icon = up ? ArrowUp : ArrowDown;
              return (
                <li key={i.categoryId} className="flex items-center gap-2 text-sm">
                  <span
                    className="h-2 w-2 shrink-0 rounded-full"
                    style={{ backgroundColor: i.color }}
                  />
                  <span className="font-medium">{i.code}</span>
                  <span className="text-xs text-muted-foreground">
                    {hrs(i.prevMinutes)}h → {hrs(i.curMinutes)}h
                  </span>
                  <span
                    className={`ml-auto flex items-center gap-0.5 text-xs font-medium ${
                      up ? "text-emerald-600 dark:text-emerald-500" : "text-red-600 dark:text-red-500"
                    }`}
                  >
                    <Icon className="h-3 w-3" />
                    {up ? "+" : "-"}
                    {Math.abs(hrs(i.deltaMinutes))}h
                  </span>
                </li>
              );
            })}
          </ul>
        )}
      </CardContent>
    </Card>
  );
}
