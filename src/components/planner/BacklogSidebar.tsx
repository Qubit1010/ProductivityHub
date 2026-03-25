"use client";

import { ListPlus } from "lucide-react";
import { Button } from "@/components/ui/button";
import {
  Sheet,
  SheetContent,
  SheetHeader,
  SheetTitle,
} from "@/components/ui/sheet";
import { ScrollArea } from "@/components/ui/scroll-area";
import { CategoryBadge } from "@/components/shared/CategoryBadge";
import { StarRating } from "@/components/shared/StarRating";
import { LoadingSpinner } from "@/components/shared/LoadingSpinner";
import { usePlannerStore } from "@/stores/planner-store";
import { useBacklogItems } from "@/hooks/useBacklogItems";
import { useCategories } from "@/hooks/useCategories";
import { useCreateTaskEntry } from "@/hooks/useTaskEntries";
import type { BacklogItem, Category } from "@/types";

interface BacklogSidebarProps {
  dailyLogId?: string;
}

export function BacklogSidebar({ dailyLogId }: BacklogSidebarProps) {
  const { backlogSidebarOpen, setBacklogSidebarOpen } = usePlannerStore();
  const { data: backlogItems, isLoading } = useBacklogItems();
  const { data: categories } = useCategories();
  const createTask = useCreateTaskEntry();

  const categoryMap = new Map<string, Category>();
  (categories ?? []).forEach((cat) => categoryMap.set(cat.id, cat));

  const grouped = new Map<string, BacklogItem[]>();
  (backlogItems ?? [])
    .filter((item) => item.isActive)
    .forEach((item) => {
      const list = grouped.get(item.categoryId) ?? [];
      list.push(item);
      grouped.set(item.categoryId, list);
    });

  const addToDay = (item: BacklogItem) => {
    if (!dailyLogId) return;
    createTask.mutate({
      dailyLogId,
      title: item.title,
      categoryId: item.categoryId,
      starRating: item.starRating,
      backlogItemId: item.id,
    });
  };

  return (
    <Sheet open={backlogSidebarOpen} onOpenChange={setBacklogSidebarOpen}>
      <SheetContent side="right" className="w-[340px] sm:w-[400px]">
        <SheetHeader>
          <SheetTitle>Backlog Items</SheetTitle>
        </SheetHeader>
        {isLoading ? (
          <LoadingSpinner className="py-12" />
        ) : grouped.size === 0 ? (
          <p className="py-8 text-center text-sm text-muted-foreground">
            No backlog items. Add some from the Backlog page.
          </p>
        ) : (
          <ScrollArea className="mt-4 h-[calc(100vh-8rem)]">
            <div className="space-y-6 pr-4">
              {Array.from(grouped.entries()).map(([catId, items]) => {
                const cat = categoryMap.get(catId);
                return (
                  <div key={catId}>
                    <div className="mb-2 flex items-center gap-2">
                      {cat && <CategoryBadge category={cat} />}
                      <span className="text-sm font-medium">
                        {cat?.name ?? "Unknown"}
                      </span>
                    </div>
                    <div className="space-y-1.5">
                      {items.map((item) => (
                        <div
                          key={item.id}
                          className="flex items-center gap-2 rounded-md border p-2"
                        >
                          <div className="flex-1 min-w-0">
                            <p className="truncate text-sm">{item.title}</p>
                            <StarRating value={item.starRating} size={12} />
                          </div>
                          <Button
                            size="icon"
                            variant="ghost"
                            className="h-7 w-7 shrink-0"
                            onClick={() => addToDay(item)}
                            disabled={createTask.isPending}
                          >
                            <ListPlus className="h-4 w-4" />
                          </Button>
                        </div>
                      ))}
                    </div>
                  </div>
                );
              })}
            </div>
          </ScrollArea>
        )}
      </SheetContent>
    </Sheet>
  );
}
