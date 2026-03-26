import type {
  Category,
  DailyLog,
  TaskEntry,
  BacklogItem,
  WeeklyGoal,
  Import,
  AnalyticsSummary,
  DailyBreakdown,
  CategoryTrend,
  HourlyDistribution,
  StreakData,
  SprintAdherence,
} from "@/types";

async function fetchApi<T>(url: string, options?: RequestInit): Promise<T> {
  const res = await fetch(url, {
    headers: { "Content-Type": "application/json", ...options?.headers },
    ...options,
  });
  if (!res.ok) {
    const error = await res.json().catch(() => ({ error: "Request failed" }));
    throw new Error(error.error || `HTTP ${res.status}`);
  }
  return res.json();
}

// Auth
export const api = {
  auth: {
    register: (data: { email: string; password: string; name: string }) =>
      fetchApi<{ user: { id: string; email: string; name: string } }>(
        "/api/auth/register",
        { method: "POST", body: JSON.stringify(data) }
      ),
  },

  categories: {
    list: () => fetchApi<{ categories: Category[] }>("/api/categories"),
    create: (data: { code: string; name: string; color: string; type: string }) =>
      fetchApi<{ category: Category }>("/api/categories", {
        method: "POST",
        body: JSON.stringify(data),
      }),
    update: (id: string, data: Partial<Category>) =>
      fetchApi<{ category: Category }>(`/api/categories/${id}`, {
        method: "PUT",
        body: JSON.stringify(data),
      }),
    delete: (id: string) =>
      fetchApi<{ success: true }>(`/api/categories/${id}`, { method: "DELETE" }),
    reorder: (ids: string[]) =>
      fetchApi<{ success: true }>("/api/categories/reorder", {
        method: "PUT",
        body: JSON.stringify({ ids }),
      }),
  },

  dailyLogs: {
    getByDate: (date: string) =>
      fetchApi<{ dailyLog: DailyLog | null }>(`/api/daily-logs?date=${date}`),
    getByRange: (from: string, to: string) =>
      fetchApi<{ dailyLogs: DailyLog[] }>(`/api/daily-logs?from=${from}&to=${to}`),
    create: (data: { logDate: string; sprintStart?: string; sprintEnd?: string; notes?: string }) =>
      fetchApi<{ dailyLog: DailyLog }>("/api/daily-logs", {
        method: "POST",
        body: JSON.stringify(data),
      }),
    update: (id: string, data: { sprintStart?: string; sprintEnd?: string; notes?: string; sleepHours?: number | null }) =>
      fetchApi<{ dailyLog: DailyLog }>(`/api/daily-logs/${id}`, {
        method: "PUT",
        body: JSON.stringify(data),
      }),
  },

  taskEntries: {
    listByDailyLog: (dailyLogId: string) =>
      fetchApi<{ taskEntries: TaskEntry[] }>(`/api/task-entries?dailyLogId=${dailyLogId}`),
    listByRange: (from: string, to: string) =>
      fetchApi<{ taskEntries: TaskEntry[] }>(`/api/task-entries?from=${from}&to=${to}`),
    create: (data: {
      dailyLogId: string;
      categoryId: string;
      title: string;
      starRating?: number;
      tag?: string;
      timeStart?: string;
      timeEnd?: string;
      backlogItemId?: string;
    }) =>
      fetchApi<{ taskEntry: TaskEntry }>("/api/task-entries", {
        method: "POST",
        body: JSON.stringify(data),
      }),
    update: (id: string, data: Partial<TaskEntry>) =>
      fetchApi<{ taskEntry: TaskEntry }>(`/api/task-entries/${id}`, {
        method: "PUT",
        body: JSON.stringify(data),
      }),
    delete: (id: string) =>
      fetchApi<{ success: true }>(`/api/task-entries/${id}`, { method: "DELETE" }),
    toggleComplete: (id: string, isCompleted: boolean) =>
      fetchApi<{ taskEntry: TaskEntry }>(`/api/task-entries/${id}/complete`, {
        method: "PATCH",
        body: JSON.stringify({ isCompleted }),
      }),
    reorder: (entries: { id: string; sortOrder: number }[]) =>
      fetchApi<{ success: true }>("/api/task-entries/reorder", {
        method: "PUT",
        body: JSON.stringify({ entries }),
      }),
  },

  backlogItems: {
    list: (categoryId?: string) =>
      fetchApi<{ backlogItems: BacklogItem[] }>(
        `/api/backlog-items${categoryId ? `?categoryId=${categoryId}` : ""}`
      ),
    create: (data: { categoryId: string; title: string; starRating?: number }) =>
      fetchApi<{ backlogItem: BacklogItem }>("/api/backlog-items", {
        method: "POST",
        body: JSON.stringify(data),
      }),
    update: (id: string, data: Partial<BacklogItem>) =>
      fetchApi<{ backlogItem: BacklogItem }>(`/api/backlog-items/${id}`, {
        method: "PUT",
        body: JSON.stringify(data),
      }),
    delete: (id: string) =>
      fetchApi<{ success: true }>(`/api/backlog-items/${id}`, { method: "DELETE" }),
    reorder: (entries: { id: string; sortOrder: number }[]) =>
      fetchApi<{ success: true }>("/api/backlog-items/reorder", {
        method: "PUT",
        body: JSON.stringify({ entries }),
      }),
  },

  weeklyGoals: {
    list: (weekStart: string) =>
      fetchApi<{ weeklyGoals: WeeklyGoal[] }>(`/api/weekly-goals?weekStart=${weekStart}`),
    create: (data: { categoryId: string; weekStart: string; targetMinutes: number }) =>
      fetchApi<{ weeklyGoal: WeeklyGoal }>("/api/weekly-goals", {
        method: "POST",
        body: JSON.stringify(data),
      }),
    update: (id: string, data: { targetMinutes: number }) =>
      fetchApi<{ weeklyGoal: WeeklyGoal }>(`/api/weekly-goals/${id}`, {
        method: "PUT",
        body: JSON.stringify(data),
      }),
    delete: (id: string) =>
      fetchApi<{ success: true }>(`/api/weekly-goals/${id}`, { method: "DELETE" }),
  },

  analytics: {
    summary: (from: string, to: string) =>
      fetchApi<AnalyticsSummary>(`/api/analytics/summary?from=${from}&to=${to}`),
    dailyBreakdown: (from: string, to: string) =>
      fetchApi<DailyBreakdown>(`/api/analytics/daily-breakdown?from=${from}&to=${to}`),
    categoryTrends: (from: string, to: string) =>
      fetchApi<{ trends: CategoryTrend[] }>(`/api/analytics/category-trends?from=${from}&to=${to}`),
    hourlyDistribution: (from: string, to: string) =>
      fetchApi<HourlyDistribution>(`/api/analytics/hourly-distribution?from=${from}&to=${to}`),
    streaks: () => fetchApi<StreakData>("/api/analytics/streaks"),
    sprintAdherence: (from: string, to: string) =>
      fetchApi<SprintAdherence>(`/api/analytics/sprint-adherence?from=${from}&to=${to}`),
  },

  import: {
    processFile: (file: File) => {
      const formData = new FormData();
      formData.append("file", file);
      return fetch("/api/import/csv", { method: "POST", body: formData }).then(
        async (res) => {
          if (!res.ok) {
            const error = await res.json().catch(() => ({ error: "Import failed" }));
            throw new Error(error.error || `HTTP ${res.status}`);
          }
          return res.json() as Promise<{ import: Import }>;
        }
      );
    },
  },

  export: {
    csv: (from: string, to: string) =>
      fetch(`/api/export/csv?from=${from}&to=${to}`).then((res) => {
        if (!res.ok) throw new Error("Export failed");
        return res.blob();
      }),
  },
};
