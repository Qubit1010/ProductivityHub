"use client";

import { GripVertical, Pencil, Trash2 } from "lucide-react";
import { useSortable } from "@dnd-kit/sortable";
import { CSS } from "@dnd-kit/utilities";
import { Button } from "@/components/ui/button";
import { Card, CardContent } from "@/components/ui/card";
import { StarRating } from "@/components/shared/StarRating";
import { cn } from "@/lib/utils";
import { useDeleteBacklogItem, useUpdateBacklogItem } from "@/hooks/useBacklogItems";
import type { BacklogItem } from "@/types";

interface BacklogItemCardProps {
  item: BacklogItem;
  onEdit: (item: BacklogItem) => void;
  isOverlay?: boolean;
}

export function BacklogItemCard({ item, onEdit, isOverlay }: BacklogItemCardProps) {
  const deleteItem = useDeleteBacklogItem();
  const updateItem = useUpdateBacklogItem();

  const {
    attributes,
    listeners,
    setNodeRef,
    transform,
    transition,
    isDragging,
  } = useSortable({ id: item.id });

  const style = {
    transform: CSS.Transform.toString(transform),
    transition,
  };

  return (
    <Card
      ref={setNodeRef}
      style={isOverlay ? undefined : style}
      className={cn(
        "group",
        isDragging && "opacity-50",
        isOverlay && "shadow-lg ring-2 ring-primary/20"
      )}
    >
      <CardContent className="flex items-center gap-2 p-3">
        <button
          className="cursor-grab touch-none text-muted-foreground hover:text-foreground"
          {...attributes}
          {...listeners}
        >
          <GripVertical className="h-4 w-4" />
        </button>
        <div className="flex-1 min-w-0">
          <p className="text-sm font-medium break-words">{item.title}</p>
          <StarRating
            value={item.starRating}
            size={12}
            editable
            onChange={(value) =>
              updateItem.mutate({ id: item.id, starRating: value })
            }
          />
        </div>
        <div className="flex items-center gap-1 opacity-0 group-hover:opacity-100 transition-opacity">
          <Button
            variant="ghost"
            size="icon"
            className="h-7 w-7"
            onClick={() => onEdit(item)}
          >
            <Pencil className="h-3.5 w-3.5" />
          </Button>
          <Button
            variant="ghost"
            size="icon"
            className="h-7 w-7 text-destructive hover:text-destructive"
            onClick={() => deleteItem.mutate(item.id)}
          >
            <Trash2 className="h-3.5 w-3.5" />
          </Button>
        </div>
      </CardContent>
    </Card>
  );
}
