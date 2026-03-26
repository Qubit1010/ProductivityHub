export type Category = {
  id: string;
  code: string;
  name: string;
  color: string;
  type: string;
  sortOrder: number;
  createdAt: string;
};

export type DailyLog = {
  id: string;
  logDate: string;
  sprintStart: string | null;
  sprintEnd: string | null;
  notes: string | null;
  sleepHours: number | null;
  createdAt: string;
  updatedAt: string;
};

export type TaskEntry = {
  id: string;
  dailyLogId: string;
  categoryId: string;
  backlogItemId: string | null;
  title: string;
  starRating: number;
  tag: string | null;
  timeStart: string | null;
  timeEnd: string | null;
  durationMinutes: number | null;
  isCompleted: boolean;
  completedAt: string | null;
  sortOrder: number;
  createdAt: string;
  updatedAt: string;
  category?: Category;
};

export type BacklogItem = {
  id: string;
  categoryId: string;
  title: string;
  starRating: number;
  sortOrder: number;
  isActive: boolean;
  createdAt: string;
  updatedAt: string;
  category?: Category;
};

export type WeeklyGoal = {
  id: string;
  categoryId: string;
  weekStart: string;
  targetMinutes: number;
  createdAt: string;
  category?: Category;
};

export type Import = {
  id: string;
  filename: string;
  rowCount: number;
  rowsImported: number;
  rowsSkipped: number;
  status: "pending" | "processing" | "complete" | "failed";
  errorLog: string | null;
  createdAt: string;
};

export type ColumnMapping = {
  taskName: number;
  category: number;
  timeRange: number;
  date: number;
  starRating?: number;
  tag?: number;
  backlogColumns?: { columnIndex: number; categoryCode: string }[];
};

export type AnalyticsSummary = {
  totalMinutes: number;
  tasksCompleted: number;
  tasksTotal: number;
  completionRate: number;
  sprintUtilization: number;
  categoryBreakdown: {
    categoryId: string;
    code: string;
    color: string;
    minutes: number;
  }[];
};

export type DailyBreakdown = {
  days: {
    date: string;
    totalMinutes: number;
    tasksCompleted: number;
    tasksTotal: number;
    categories: {
      categoryId: string;
      code: string;
      color: string;
      minutes: number;
    }[];
  }[];
};

export type CategoryTrend = {
  categoryId: string;
  code: string;
  color: string;
  dataPoints: { date: string; minutes: number }[];
};

export type HourlyDistribution = {
  hours: { hour: number; totalMinutes: number; taskCount: number }[];
};

export type StreakData = {
  currentStreak: number;
  bestStreak: number;
  lastActiveDate: string | null;
};

export type SprintAdherence = {
  days: {
    date: string;
    sprintMinutes: number;
    actualMinutes: number;
    adherencePercent: number;
  }[];
};

export type ApiError = {
  error: string;
  code?: string;
  details?: unknown;
};
