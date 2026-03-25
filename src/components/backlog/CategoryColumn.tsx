"use client";

import { useState } from "react";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { ScrollArea } from "@/components/ui/scroll-area";
import { Badge } from "@/components/ui/badge";
import { BacklogItemCard } from "@/components/backlog/BacklogItemCard";
import { AddBacklogItemDialog } from "@/components/backlog/AddBacklogItemDialog";
import type { BacklogItem, Category } from "@/types";

interface CategoryColumnProps {
  category: Category;
  items: BacklogItem[];
}

export function CategoryColumn({ category, items }: CategoryColumnProps) {
  const [editingItem, setEditingItem] = useState<BacklogItem | null>(null);

  return (
    <Card className="flex h-full flex-col">
      <CardHeader className="pb-3">
        <div className="flex items-center justify-between">
          <div className="flex items-center gap-2">
            <div
              className="h-3 w-3 rounded-full"
              style={{ backgroundColor: category.color }}
            />
            <CardTitle className="text-sm font-medium">
              {category.name}
            </CardTitle>
            <Badge variant="secondary" className="text-xs">
              {items.length}
            </Badge>
          </div>
          <AddBacklogItemDialog defaultCategoryId={category.id} />
        </div>
      </CardHeader>
      <CardContent className="flex-1 pt-0">
        <ScrollArea className="h-[calc(100vh-280px)]">
          <div className="space-y-2 pr-2">
            {items.length === 0 ? (
              <p className="py-4 text-center text-xs text-muted-foreground">
                No items
              </p>
            ) : (
              items.map((item) => (
                <BacklogItemCard
                  key={item.id}
                  item={item}
                  onEdit={setEditingItem}
                />
              ))
            )}
          </div>
        </ScrollArea>

        {editingItem && (
          <AddBacklogItemDialog
            editItem={editingItem}
            open={true}
            onOpenChange={(isOpen) => {
              if (!isOpen) setEditingItem(null);
            }}
          />
        )}
      </CardContent>
    </Card>
  );
}
