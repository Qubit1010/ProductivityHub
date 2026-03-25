"use client";

import { create } from "zustand";
import { toDateString } from "@/lib/utils/date";

interface UIStore {
  sidebarCollapsed: boolean;
  selectedDate: string;
  theme: "light" | "dark" | "system";
  toggleSidebar: () => void;
  setSelectedDate: (date: string) => void;
  setTheme: (theme: "light" | "dark" | "system") => void;
}

export const useUIStore = create<UIStore>((set) => ({
  sidebarCollapsed: false,
  selectedDate: toDateString(),
  theme: "system",
  toggleSidebar: () => set((s) => ({ sidebarCollapsed: !s.sidebarCollapsed })),
  setSelectedDate: (date) => set({ selectedDate: date }),
  setTheme: (theme) => set({ theme }),
}));
