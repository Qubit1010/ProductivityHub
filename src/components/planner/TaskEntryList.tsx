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
} from "@dnd-kit/core";
import {
  SortableContext,
  sortableKeyboardCoordinates,
  verticalListSortingStrategy,
} from "@dnd-kit/sortable";
import { TaskEntryRow } from "@/components/planner/TaskEntryRow";
import { AddTaskDialog } from "@/components/planner/AddTaskDialog";
import { LoadingSpinner } from "@/components/shared/LoadingSpinner";
import { useReorderTaskEntries } from "@/hooks/useTaskEntries";
import type { TaskEntry } from "@/types";

interface TaskEntryListProps {
  tasks: TaskEntry[];
  dailyLogId: string;
  isLoading: boolean;
}

export function TaskEntryList({
  tasks,
  dailyLogId,
  isLoading,
}: TaskEntryListProps) {
  const [editingTask, setEditingTask] = useState<TaskEntry | null>(null);
  const reorderTasks = useReorderTaskEntries();

  const sensors = useSensors(
    useSensor(PointerSensor, { activationConstraint: { distance: 8 } }),
    useSensor(KeyboardSensor, {
      coordinateGetter: sortableKeyboardCoordinates,
    })
  );

  const handleDragEnd = useCallback(
    (event: DragEndEvent) => {
      const { active, over } = event;
      if (!over || active.id === over.id) return;

      const oldIndex = tasks.findIndex((t) => t.id === active.id);
      const newIndex = tasks.findIndex((t) => t.id === over.id);
      if (oldIndex === -1 || newIndex === -1) return;

      const reordered = [...tasks];
      const [moved] = reordered.splice(oldIndex, 1);
      reordered.splice(newIndex, 0, moved);

      const entries = reordered.map((t, i) => ({
        id: t.id,
        sortOrder: i,
      }));
      reorderTasks.mutate(entries);
    },
    [tasks, reorderTasks]
  );

  if (isLoading) {
    return <LoadingSpinner className="py-12" />;
  }

  if (tasks.length === 0) {
    return (
      <div className="flex flex-col items-center justify-center rounded-lg border border-dashed py-12">
        <p className="mb-2 text-sm text-muted-foreground">
          No tasks for this day yet
        </p>
        <AddTaskDialog dailyLogId={dailyLogId} />
      </div>
    );
  }

  return (
    <DndContext
      sensors={sensors}
      collisionDetection={closestCenter}
      onDragEnd={handleDragEnd}
    >
      <SortableContext
        items={tasks.map((t) => t.id)}
        strategy={verticalListSortingStrategy}
      >
        <div className="space-y-2">
          {tasks.map((task) => (
            <TaskEntryRow
              key={task.id}
              task={task}
              onEdit={setEditingTask}
            />
          ))}
        </div>
      </SortableContext>

      {editingTask && (
        <AddTaskDialog
          dailyLogId={dailyLogId}
          editTask={editingTask}
          open={true}
          onOpenChange={(open) => {
            if (!open) setEditingTask(null);
          }}
        />
      )}
    </DndContext>
  );
}
