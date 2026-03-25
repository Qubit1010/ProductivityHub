import {
  pgTable,
  uuid,
  varchar,
  text,
  integer,
  smallint,
  boolean,
  timestamp,
  date,
  time,
  uniqueIndex,
  index,
} from "drizzle-orm/pg-core";
import { relations } from "drizzle-orm";

export const users = pgTable("users", {
  id: uuid("id").defaultRandom().primaryKey(),
  email: varchar("email", { length: 255 }).unique().notNull(),
  passwordHash: varchar("password_hash", { length: 255 }).notNull(),
  name: varchar("name", { length: 100 }).notNull(),
  createdAt: timestamp("created_at").defaultNow().notNull(),
  updatedAt: timestamp("updated_at").defaultNow().notNull(),
});

export const categories = pgTable(
  "categories",
  {
    id: uuid("id").defaultRandom().primaryKey(),
    userId: uuid("user_id")
      .references(() => users.id)
      .notNull(),
    code: varchar("code", { length: 10 }).notNull(),
    name: varchar("name", { length: 100 }).notNull(),
    color: varchar("color", { length: 7 }).notNull().default("#6B7280"),
    type: varchar("type", { length: 20 }).notNull().default("general"),
    sortOrder: integer("sort_order").notNull().default(0),
    createdAt: timestamp("created_at").defaultNow().notNull(),
  },
  (table) => ({
    userCodeIdx: uniqueIndex("categories_user_code_idx").on(
      table.userId,
      table.code
    ),
  })
);

export const dailyLogs = pgTable(
  "daily_logs",
  {
    id: uuid("id").defaultRandom().primaryKey(),
    userId: uuid("user_id")
      .references(() => users.id)
      .notNull(),
    logDate: date("log_date").notNull(),
    sprintStart: time("sprint_start"),
    sprintEnd: time("sprint_end"),
    notes: text("notes"),
    createdAt: timestamp("created_at").defaultNow().notNull(),
    updatedAt: timestamp("updated_at").defaultNow().notNull(),
  },
  (table) => ({
    userDateIdx: uniqueIndex("daily_logs_user_date_idx").on(
      table.userId,
      table.logDate
    ),
  })
);

export const taskEntries = pgTable(
  "task_entries",
  {
    id: uuid("id").defaultRandom().primaryKey(),
    dailyLogId: uuid("daily_log_id")
      .references(() => dailyLogs.id)
      .notNull(),
    userId: uuid("user_id")
      .references(() => users.id)
      .notNull(),
    categoryId: uuid("category_id")
      .references(() => categories.id)
      .notNull(),
    backlogItemId: uuid("backlog_item_id").references(() => backlogItems.id),
    title: varchar("title", { length: 255 }).notNull(),
    starRating: smallint("star_rating").notNull().default(1),
    tag: varchar("tag", { length: 10 }),
    timeStart: time("time_start"),
    timeEnd: time("time_end"),
    durationMinutes: integer("duration_minutes"),
    isCompleted: boolean("is_completed").notNull().default(false),
    completedAt: timestamp("completed_at"),
    sortOrder: integer("sort_order").notNull().default(0),
    createdAt: timestamp("created_at").defaultNow().notNull(),
    updatedAt: timestamp("updated_at").defaultNow().notNull(),
  },
  (table) => ({
    userDailyLogIdx: index("task_entries_user_daily_log_idx").on(
      table.userId,
      table.dailyLogId
    ),
    userCategoryIdx: index("task_entries_user_category_idx").on(
      table.userId,
      table.categoryId
    ),
    userCreatedIdx: index("task_entries_user_created_idx").on(
      table.userId,
      table.createdAt
    ),
  })
);

export const backlogItems = pgTable(
  "backlog_items",
  {
    id: uuid("id").defaultRandom().primaryKey(),
    userId: uuid("user_id")
      .references(() => users.id)
      .notNull(),
    categoryId: uuid("category_id")
      .references(() => categories.id)
      .notNull(),
    title: varchar("title", { length: 255 }).notNull(),
    starRating: smallint("star_rating").notNull().default(1),
    isActive: boolean("is_active").notNull().default(true),
    createdAt: timestamp("created_at").defaultNow().notNull(),
    updatedAt: timestamp("updated_at").defaultNow().notNull(),
  },
  (table) => ({
    userCategoryIdx: index("backlog_items_user_category_idx").on(
      table.userId,
      table.categoryId
    ),
  })
);

export const weeklyGoals = pgTable(
  "weekly_goals",
  {
    id: uuid("id").defaultRandom().primaryKey(),
    userId: uuid("user_id")
      .references(() => users.id)
      .notNull(),
    categoryId: uuid("category_id")
      .references(() => categories.id)
      .notNull(),
    weekStart: date("week_start").notNull(),
    targetMinutes: integer("target_minutes").notNull(),
    createdAt: timestamp("created_at").defaultNow().notNull(),
  },
  (table) => ({
    userCategoryWeekIdx: uniqueIndex(
      "weekly_goals_user_category_week_idx"
    ).on(table.userId, table.categoryId, table.weekStart),
  })
);

export const imports = pgTable("imports", {
  id: uuid("id").defaultRandom().primaryKey(),
  userId: uuid("user_id")
    .references(() => users.id)
    .notNull(),
  filename: varchar("filename", { length: 255 }).notNull(),
  csvData: text("csv_data"),
  rowCount: integer("row_count").notNull().default(0),
  rowsImported: integer("rows_imported").notNull().default(0),
  rowsSkipped: integer("rows_skipped").notNull().default(0),
  status: varchar("status", { length: 20 }).notNull().default("pending"),
  errorLog: text("error_log"),
  createdAt: timestamp("created_at").defaultNow().notNull(),
});

// Relations
export const usersRelations = relations(users, ({ many }) => ({
  categories: many(categories),
  dailyLogs: many(dailyLogs),
  backlogItems: many(backlogItems),
  weeklyGoals: many(weeklyGoals),
  imports: many(imports),
}));

export const categoriesRelations = relations(categories, ({ one, many }) => ({
  user: one(users, { fields: [categories.userId], references: [users.id] }),
  taskEntries: many(taskEntries),
  backlogItems: many(backlogItems),
  weeklyGoals: many(weeklyGoals),
}));

export const dailyLogsRelations = relations(dailyLogs, ({ one, many }) => ({
  user: one(users, { fields: [dailyLogs.userId], references: [users.id] }),
  taskEntries: many(taskEntries),
}));

export const taskEntriesRelations = relations(taskEntries, ({ one }) => ({
  dailyLog: one(dailyLogs, {
    fields: [taskEntries.dailyLogId],
    references: [dailyLogs.id],
  }),
  user: one(users, { fields: [taskEntries.userId], references: [users.id] }),
  category: one(categories, {
    fields: [taskEntries.categoryId],
    references: [categories.id],
  }),
  backlogItem: one(backlogItems, {
    fields: [taskEntries.backlogItemId],
    references: [backlogItems.id],
  }),
}));

export const backlogItemsRelations = relations(
  backlogItems,
  ({ one, many }) => ({
    user: one(users, {
      fields: [backlogItems.userId],
      references: [users.id],
    }),
    category: one(categories, {
      fields: [backlogItems.categoryId],
      references: [categories.id],
    }),
    taskEntries: many(taskEntries),
  })
);

export const weeklyGoalsRelations = relations(weeklyGoals, ({ one }) => ({
  user: one(users, { fields: [weeklyGoals.userId], references: [users.id] }),
  category: one(categories, {
    fields: [weeklyGoals.categoryId],
    references: [categories.id],
  }),
}));

export const importsRelations = relations(imports, ({ one }) => ({
  user: one(users, { fields: [imports.userId], references: [users.id] }),
}));
