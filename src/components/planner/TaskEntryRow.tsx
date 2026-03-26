"use client";

import { GripVertical, Pencil, Trash2 } from "lucide-react";
import { useSortable } from "@dnd-kit/sortable";
import { CSS } from "@dnd-kit/utilities";
import { Checkbox } from "@/components/ui/checkbox";
import { Button } from "@/components/ui/button";
import { CategoryBadge } from "@/components/shared/CategoryBadge";
import { StarRating } from "@/components/shared/StarRating";
import { cn } from "@/lib/utils";
import { formatTime12h, computeDurationMinutes, formatDuration } from "@/lib/utils/time";
import {
  useToggleTaskComplete,
  useUpdateTaskEntry,
  useDeleteTaskEntry,
} from "@/hooks/useTaskEntries";
import type { TaskEntry } from "@/types";

interface TaskEntryRowProps {
  task: TaskEntry;
  onEdit: (task: TaskEntry) => void;
  isOverlay?: boolean;
}

export function TaskEntryRow({ task, onEdit, isOverlay }: TaskEntryRowProps) {
  const toggleComplete = useToggleTaskComplete();
  const updateTask = useUpdateTaskEntry();
  const deleteTask = useDeleteTaskEntry();

  const {
    attributes,
    listeners,
    setNodeRef,
    transform,
    transition,
    isDragging,
  } = useSortable({ id: task.id });

  const style = {
    transform: CSS.Transform.toString(transform),
    transition,
  };

  const duration =
    task.timeStart && task.timeEnd
      ? computeDurationMinutes(task.timeStart, task.timeEnd)
      : task.durationMinutes;

  return (
    <div
      ref={setNodeRef}
      style={isOverlay ? undefined : style}
      className={cn(
        "flex items-center gap-2 rounded-lg border bg-card p-3 transition-colors",
        isDragging && "opacity-50",
        task.isCompleted && "bg-muted/50",
        isOverlay && "shadow-lg ring-2 ring-primary/20"
      )}
    >
      <button
        className="cursor-grab touch-none text-muted-foreground hover:text-foreground"
        {...attributes}
        {...listeners}
      >
        <GripVertical className="h-4 w-4" />
      </button>

      <Checkbox
        checked={task.isCompleted}
        onCheckedChange={(checked) =>
          toggleComplete.mutate({
            id: task.id,
            isCompleted: checked === true,
          })
        }
      />

      {task.category && <CategoryBadge category={task.category} />}

      <span
        className={cn(
          "flex-1 truncate text-sm",
          task.isCompleted && "text-muted-foreground line-through"
        )}
      >
        {task.title}
      </span>

      <StarRating
        value={task.starRating}
        editable
        size={14}
        onChange={(value) =>
          updateTask.mutate({ id: task.id, starRating: value })
        }
      />

      {task.timeStart && (
        <span className="hidden text-xs text-muted-foreground sm:inline">
          {formatTime12h(task.timeStart)}
          {task.timeEnd && ` - ${formatTime12h(task.timeEnd)}`}
        </span>
      )}

      {duration !== null && duration !== undefined && (
        <span className="text-xs font-medium text-muted-foreground">
          {formatDuration(duration)}
        </span>
      )}

      <div className="flex items-center gap-1">
        <Button
          variant="ghost"
          size="icon"
          className="h-7 w-7"
          onClick={() => onEdit(task)}
        >
          <Pencil className="h-3.5 w-3.5" />
        </Button>
        <Button
          variant="ghost"
          size="icon"
          className="h-7 w-7 text-destructive hover:text-destructive"
          onClick={() => deleteTask.mutate(task.id)}
        >
          <Trash2 className="h-3.5 w-3.5" />
        </Button>
      </div>
    </div>
  );
}
