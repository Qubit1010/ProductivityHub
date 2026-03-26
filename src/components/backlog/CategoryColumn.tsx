"use client";

import { useState, useCallback } from "react";
import {
  DndContext,
  closestCenter,
  KeyboardSensor,
  PointerSensor,
  useSensor,
  useSensors,
  type DragEndEvent,
  DragOverlay,
} from "@dnd-kit/core";
import {
  SortableContext,
  sortableKeyboardCoordinates,
  verticalListSortingStrategy,
} from "@dnd-kit/sortable";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { ScrollArea } from "@/components/ui/scroll-area";
import { Badge } from "@/components/ui/badge";
import { BacklogItemCard } from "@/components/backlog/BacklogItemCard";
import { AddBacklogItemDialog } from "@/components/backlog/AddBacklogItemDialog";
import { useReorderBacklogItems } from "@/hooks/useBacklogItems";
import type { BacklogItem, Category } from "@/types";

interface CategoryColumnProps {
  category: Category;
  items: BacklogItem[];
}

export function CategoryColumn({ category, items }: CategoryColumnProps) {
  const [editingItem, setEditingItem] = useState<BacklogItem | null>(null);
  const [activeId, setActiveId] = useState<string | null>(null);
  const reorderItems = useReorderBacklogItems();

  const sensors = useSensors(
    useSensor(PointerSensor, { activationConstraint: { distance: 8 } }),
    useSensor(KeyboardSensor, {
      coordinateGetter: sortableKeyboardCoordinates,
    })
  );

  const sortedItems = [...items].sort((a, b) => (a.sortOrder ?? 0) - (b.sortOrder ?? 0));
  const activeItem = activeId ? sortedItems.find((i) => i.id === activeId) : null;

  const handleDragStart = useCallback((event: { active: { id: string | number } }) => {
    setActiveId(String(event.active.id));
  }, []);

  const handleDragEnd = useCallback(
    (event: DragEndEvent) => {
      setActiveId(null);
      const { active, over } = event;
      if (!over || active.id === over.id) return;

      const oldIndex = sortedItems.findIndex((i) => i.id === active.id);
      const newIndex = sortedItems.findIndex((i) => i.id === over.id);
      if (oldIndex === -1 || newIndex === -1) return;

      const reordered = [...sortedItems];
      const [moved] = reordered.splice(oldIndex, 1);
      reordered.splice(newIndex, 0, moved);

      const entries = reordered.map((item, i) => ({
        id: item.id,
        sortOrder: i,
      }));
      reorderItems.mutate(entries);
    },
    [sortedItems, reorderItems]
  );

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
        <DndContext
          sensors={sensors}
          collisionDetection={closestCenter}
          onDragStart={handleDragStart}
          onDragEnd={handleDragEnd}
        >
          <SortableContext
            items={sortedItems.map((i) => i.id)}
            strategy={verticalListSortingStrategy}
          >
            <ScrollArea className="h-[calc(100vh-280px)]">
              <div className="space-y-2 pr-2">
                {sortedItems.length === 0 ? (
                  <p className="py-4 text-center text-xs text-muted-foreground">
                    No items
                  </p>
                ) : (
                  sortedItems.map((item) => (
                    <BacklogItemCard
                      key={item.id}
                      item={item}
                      onEdit={setEditingItem}
                    />
                  ))
                )}
              </div>
            </ScrollArea>
          </SortableContext>

          <DragOverlay>
            {activeItem ? (
              <BacklogItemCard item={activeItem} onEdit={() => {}} isOverlay />
            ) : null}
          </DragOverlay>
        </DndContext>

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
