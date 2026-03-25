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
import { TimeRangeInput } from "@/components/shared/TimeRangeInput";
import { useCategories } from "@/hooks/useCategories";
import { useCreateTaskEntry, useUpdateTaskEntry } from "@/hooks/useTaskEntries";
import type { TaskEntry } from "@/types";

interface AddTaskDialogProps {
  dailyLogId: string;
  editTask?: TaskEntry | null;
  open?: boolean;
  onOpenChange?: (open: boolean) => void;
}

export function AddTaskDialog({
  dailyLogId,
  editTask,
  open: controlledOpen,
  onOpenChange: controlledOnOpenChange,
}: AddTaskDialogProps) {
  const [internalOpen, setInternalOpen] = useState(false);
  const open = controlledOpen ?? internalOpen;
  const setOpen = controlledOnOpenChange ?? setInternalOpen;

  const { data: categories } = useCategories();
  const createTask = useCreateTaskEntry();
  const updateTask = useUpdateTaskEntry();

  const [title, setTitle] = useState("");
  const [categoryId, setCategoryId] = useState("");
  const [starRating, setStarRating] = useState(1);
  const [timeStart, setTimeStart] = useState("");
  const [timeEnd, setTimeEnd] = useState("");

  useEffect(() => {
    if (editTask) {
      setTitle(editTask.title);
      setCategoryId(editTask.categoryId);
      setStarRating(editTask.starRating);
      setTimeStart(editTask.timeStart ?? "");
      setTimeEnd(editTask.timeEnd ?? "");
    } else {
      setTitle("");
      setCategoryId(categories?.[0]?.id ?? "");
      setStarRating(1);
      setTimeStart("");
      setTimeEnd("");
    }
  }, [editTask, categories, open]);

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    if (!title.trim() || !categoryId) return;

    if (editTask) {
      updateTask.mutate(
        {
          id: editTask.id,
          title: title.trim(),
          categoryId,
          starRating,
          timeStart: timeStart || undefined,
          timeEnd: timeEnd || undefined,
        },
        { onSuccess: () => setOpen(false) }
      );
    } else {
      createTask.mutate(
        {
          dailyLogId,
          title: title.trim(),
          categoryId,
          starRating,
          timeStart: timeStart || undefined,
          timeEnd: timeEnd || undefined,
        },
        {
          onSuccess: () => {
            setOpen(false);
            setTitle("");
            setStarRating(1);
            setTimeStart("");
            setTimeEnd("");
          },
        }
      );
    }
  };

  const isSubmitting = createTask.isPending || updateTask.isPending;

  const trigger = !editTask ? (
    <DialogTrigger asChild>
      <Button size="sm">
        <Plus className="mr-1 h-4 w-4" />
        Add Task
      </Button>
    </DialogTrigger>
  ) : null;

  return (
    <Dialog open={open} onOpenChange={setOpen}>
      {trigger}
      <DialogContent className="sm:max-w-md">
        <DialogHeader>
          <DialogTitle>{editTask ? "Edit Task" : "Add Task"}</DialogTitle>
        </DialogHeader>
        <form onSubmit={handleSubmit} className="space-y-4">
          <div className="space-y-2">
            <Label htmlFor="task-title">Title</Label>
            <Input
              id="task-title"
              value={title}
              onChange={(e) => setTitle(e.target.value)}
              placeholder="Task description..."
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

          <TimeRangeInput
            startValue={timeStart}
            endValue={timeEnd}
            onStartChange={setTimeStart}
            onEndChange={setTimeEnd}
          />

          <div className="flex justify-end gap-2">
            <Button
              type="button"
              variant="outline"
              onClick={() => setOpen(false)}
            >
              Cancel
            </Button>
            <Button type="submit" disabled={isSubmitting || !title.trim()}>
              {isSubmitting
                ? "Saving..."
                : editTask
                  ? "Update"
                  : "Add Task"}
            </Button>
          </div>
        </form>
      </DialogContent>
    </Dialog>
  );
}
