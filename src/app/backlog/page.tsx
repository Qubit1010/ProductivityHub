"use client";

import { AppShell } from "@/components/layout/AppShell";
import { CategoryColumn } from "@/components/backlog/CategoryColumn";
import { AddBacklogItemDialog } from "@/components/backlog/AddBacklogItemDialog";
import { useCategories } from "@/hooks/useCategories";
import { useBacklogItems } from "@/hooks/useBacklogItems";
import { LoadingSpinner } from "@/components/shared/LoadingSpinner";
import type { Category, BacklogItem } from "@/types";

export default function BacklogPage() {
  const { data: categories, isLoading: catLoading } = useCategories();
  const { data: backlogItems, isLoading: itemsLoading } = useBacklogItems();

  if (catLoading || itemsLoading) return <AppShell><LoadingSpinner /></AppShell>;

  const itemsByCategory = (categories || []).map((cat: Category) => ({
    category: cat,
    items: (backlogItems || []).filter((item: BacklogItem) => item.categoryId === cat.id),
  }));

  return (
    <AppShell>
      <div className="space-y-6">
        <div className="flex items-center justify-between">
          <h1 className="text-3xl font-bold">Backlog</h1>
          <AddBacklogItemDialog />
        </div>
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-4">
          {itemsByCategory
            .filter((group: { category: Category; items: BacklogItem[] }) => group.items.length > 0)
            .map((group: { category: Category; items: BacklogItem[] }) => (
              <CategoryColumn
                key={group.category.id}
                category={group.category}
                items={group.items}
              />
            ))}
        </div>
      </div>
    </AppShell>
  );
}
