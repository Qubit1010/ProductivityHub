"use client";

import { useMemo, useState } from "react";
import { format, startOfWeek } from "date-fns";
import { RotateCcw } from "lucide-react";
import { Button } from "@/components/ui/button";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { LoadingSpinner } from "@/components/shared/LoadingSpinner";
import { StarRating } from "@/components/shared/StarRating";
import { useCategories } from "@/hooks/useCategories";
import { useCompletedBacklogItems, useUpdateBacklogItem } from "@/hooks/useBacklogItems";
import type { BacklogItem } from "@/types";

type Period = "day" | "week" | "month";

function bucketOf(item: BacklogItem, period: Period) {
  const d = new Date(item.completedAt!);
  if (period === "day") return { key: format(d, "yyyy-MM-dd"), label: format(d, "EEEE, MMM d") };
  if (period === "week") {
    const start = startOfWeek(d, { weekStartsOn: 1 });
    return { key: format(start, "yyyy-MM-dd"), label: `Week of ${format(start, "MMM d")}` };
  }
  return { key: format(d, "yyyy-MM"), label: format(d, "MMMM yyyy") };
}

export function CompletedBacklogPanel() {
  const { data: items, isLoading } = useCompletedBacklogItems();
  const { data: categories } = useCategories();
  const updateItem = useUpdateBacklogItem();
  const [period, setPeriod] = useState<Period>("day");

  const colorOf = (categoryId: string) =>
    categories?.find((c) => c.id === categoryId)?.color ?? "#888";

  const groups = useMemo(() => {
    const map = new Map<string, { label: string; items: BacklogItem[] }>();
    for (const item of items ?? []) {
      const { key, label } = bucketOf(item, period);
      const g = map.get(key) ?? { label, items: [] };
      g.items.push(item);
      map.set(key, g);
    }
    return Array.from(map.entries())
      .sort(([a], [b]) => (a < b ? 1 : -1))
      .map(([, g]) => g);
  }, [items, period]);

  if (isLoading) {
    return (
      <div className="flex h-32 items-center justify-center">
        <LoadingSpinner />
      </div>
    );
  }

  return (
    <div className="space-y-4">
      <div className="flex gap-1">
        {(["day", "week", "month"] as const).map((p) => (
          <Button
            key={p}
            size="sm"
            variant={period === p ? "default" : "outline"}
            onClick={() => setPeriod(p)}
          >
            {p === "day" ? "Daily" : p === "week" ? "Weekly" : "Monthly"}
          </Button>
        ))}
      </div>

      {groups.length === 0 ? (
        <p className="text-sm text-muted-foreground">
          No completed tasks yet — check items off in the Active tab.
        </p>
      ) : (
        groups.map((g) => (
          <Card key={g.label}>
            <CardHeader className="pb-2">
              <CardTitle className="text-sm font-medium">
                {g.label} <span className="text-muted-foreground font-normal">· {g.items.length}</span>
              </CardTitle>
            </CardHeader>
            <CardContent className="space-y-2">
              {g.items.map((item) => (
                <div key={item.id} className="flex items-center gap-2 text-sm">
                  <span
                    className="h-2 w-2 shrink-0 rounded-full"
                    style={{ backgroundColor: colorOf(item.categoryId) }}
                  />
                  <span className="flex-1 truncate">{item.title}</span>
                  <StarRating value={item.starRating} size={12} />
                  <span className="text-xs text-muted-foreground">
                    {format(new Date(item.completedAt!), "MMM d")}
                  </span>
                  <Button
                    variant="ghost"
                    size="icon"
                    className="h-6 w-6 text-muted-foreground"
                    aria-label={`Restore "${item.title}" to backlog`}
                    onClick={() => updateItem.mutate({ id: item.id, isActive: true })}
                  >
                    <RotateCcw className="h-3.5 w-3.5" />
                  </Button>
                </div>
              ))}
            </CardContent>
          </Card>
        ))
      )}
    </div>
  );
}
