"use client";

import { Pencil, Trash2 } from "lucide-react";
import { Button } from "@/components/ui/button";
import { Card, CardContent } from "@/components/ui/card";
import { StarRating } from "@/components/shared/StarRating";
import { useDeleteBacklogItem, useUpdateBacklogItem } from "@/hooks/useBacklogItems";
import type { BacklogItem } from "@/types";

interface BacklogItemCardProps {
  item: BacklogItem;
  onEdit: (item: BacklogItem) => void;
}

export function BacklogItemCard({ item, onEdit }: BacklogItemCardProps) {
  const deleteItem = useDeleteBacklogItem();
  const updateItem = useUpdateBacklogItem();

  return (
    <Card className="group">
      <CardContent className="flex items-center gap-3 p-3">
        <div className="flex-1 min-w-0">
          <p className="truncate text-sm font-medium">{item.title}</p>
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
