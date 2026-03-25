"use client";

import { useState, useEffect } from "react";
import { Plus } from "lucide-react";
import { Button } from "@/components/ui/button";
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
  DialogTrigger,
} from "@/components/ui/dialog";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select";
import { StarRating } from "@/components/shared/StarRating";
import { useCategories } from "@/hooks/useCategories";
import {
  useCreateBacklogItem,
  useUpdateBacklogItem,
} from "@/hooks/useBacklogItems";
import type { BacklogItem } from "@/types";

interface AddBacklogItemDialogProps {
  defaultCategoryId?: string;
  editItem?: BacklogItem | null;
  open?: boolean;
  onOpenChange?: (open: boolean) => void;
}

export function AddBacklogItemDialog({
  defaultCategoryId,
  editItem,
  open: controlledOpen,
  onOpenChange: controlledOnOpenChange,
}: AddBacklogItemDialogProps) {
  const [internalOpen, setInternalOpen] = useState(false);
  const open = controlledOpen ?? internalOpen;
  const setOpen = controlledOnOpenChange ?? setInternalOpen;

  const { data: categories } = useCategories();
  const createItem = useCreateBacklogItem();
  const updateItem = useUpdateBacklogItem();

  const [title, setTitle] = useState("");
  const [categoryId, setCategoryId] = useState(defaultCategoryId ?? "");
  const [starRating, setStarRating] = useState(1);

  useEffect(() => {
    if (editItem) {
      setTitle(editItem.title);
      setCategoryId(editItem.categoryId);
      setStarRating(editItem.starRating);
    } else {
      setTitle("");
      setCategoryId(defaultCategoryId ?? categories?.[0]?.id ?? "");
      setStarRating(1);
    }
  }, [editItem, defaultCategoryId, categories, open]);

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    if (!title.trim() || !categoryId) return;

    if (editItem) {
      updateItem.mutate(
        { id: editItem.id, title: title.trim(), categoryId, starRating },
        { onSuccess: () => setOpen(false) }
      );
    } else {
      createItem.mutate(
        { categoryId, title: title.trim(), starRating },
        {
          onSuccess: () => {
            setOpen(false);
            setTitle("");
            setStarRating(1);
          },
        }
      );
    }
  };

  const trigger = !editItem ? (
    <DialogTrigger asChild>
      <Button size="sm" variant="outline">
        <Plus className="mr-1 h-4 w-4" />
        Add Item
      </Button>
    </DialogTrigger>
  ) : null;

  return (
    <Dialog open={open} onOpenChange={setOpen}>
      {trigger}
      <DialogContent className="sm:max-w-md">
        <DialogHeader>
          <DialogTitle>
            {editItem ? "Edit Backlog Item" : "Add Backlog Item"}
          </DialogTitle>
        </DialogHeader>
        <form onSubmit={handleSubmit} className="space-y-4">
          <div className="space-y-2">
            <Label htmlFor="backlog-title">Title</Label>
            <Input
              id="backlog-title"
              value={title}
              onChange={(e) => setTitle(e.target.value)}
              placeholder="Item description..."
              autoFocus
            />
          </div>

          <div className="space-y-2">
            <Label>Category</Label>
            <Select value={categoryId} onValueChange={setCategoryId}>
              <SelectTrigger>
                <SelectValue placeholder="Select category" />
              </SelectTrigger>
              <SelectContent>
                {(categories ?? []).map((cat) => (
                  <SelectItem key={cat.id} value={cat.id}>
                    <div className="flex items-center gap-2">
                      <div
                        className="h-2.5 w-2.5 rounded-full"
                        style={{ backgroundColor: cat.color }}
                      />
                      {cat.code} - {cat.name}
                    </div>
                  </SelectItem>
                ))}
              </SelectContent>
            </Select>
          </div>

          <div className="space-y-2">
            <Label>Priority</Label>
            <StarRating
              value={starRating}
              editable
              onChange={setStarRating}
              size={20}
            />
          </div>

          <div className="flex justify-end gap-2">
            <Button
              type="button"
              variant="outline"
              onClick={() => setOpen(false)}
            >
              Cancel
            </Button>
            <Button
              type="submit"
              disabled={
                createItem.isPending ||
                updateItem.isPending ||
                !title.trim()
              }
            >
              {editItem ? "Update" : "Add Item"}
            </Button>
          </div>
        </form>
      </DialogContent>
    </Dialog>
  );
}
