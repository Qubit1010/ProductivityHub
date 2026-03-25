"use client";

import { create } from "zustand";

interface PlannerStore {
  backlogSidebarOpen: boolean;
  selectedCategoryFilter: string | null;
  toggleBacklogSidebar: () => void;
  setBacklogSidebarOpen: (open: boolean) => void;
  setCategoryFilter: (categoryId: string | null) => void;
}

export const usePlannerStore = create<PlannerStore>((set) => ({
  backlogSidebarOpen: false,
  selectedCategoryFilter: null,
  toggleBacklogSidebar: () =>
    set((s) => ({ backlogSidebarOpen: !s.backlogSidebarOpen })),
  setBacklogSidebarOpen: (open) => set({ backlogSidebarOpen: open }),
  setCategoryFilter: (categoryId) =>
    set({ selectedCategoryFilter: categoryId }),
}));
