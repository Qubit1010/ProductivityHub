---
project: ProductivityHub
complexity: standard
tech_stack:
  frontend: Next.js 14 (App Router) + TypeScript + Tailwind CSS + shadcn/ui
  backend: Next.js API Routes (Route Handlers)
  database: PostgreSQL + Drizzle ORM
  auth: NextAuth.js (Credentials + JWT)
created: 2026-03-21T10:05:00Z
---

## 1. Overview

ProductivityHub is a personal productivity tracking web app that replaces a daily task tracking Google Sheet. It allows users to plan daily tasks with category codes, time blocks, and priority ratings, track sprint utilization, manage category-grouped backlogs, import historical data from CSV, and view rich analytics dashboards showing time utilization patterns across days, weeks, and months.

## 2. Complexity Assessment

| Dimension | Score (1-5) | Rationale |
|-----------|-------------|-----------|
| Data | 4 | 7 related tables, time-series analytics queries, CSV import parsing with complex column mapping |
| Auth | 2 | Single-user MVP with NextAuth.js Credentials provider, JWT sessions |
| UI | 4 | Interactive dashboard with multiple chart types (Recharts), drag-and-drop daily planner, import wizard, calendar heatmap |
| Integrations | 3 | CSV file upload + parsing with auto-detection, export functionality |
| Scale | 2 | Single-user, moderate data volume (hundreds of tasks per month) |
| **Total** | **15** | **Tier: Standard** (top end, with rich analytics) |

## 3. Tech Stack

| Layer | Choice | Rationale |
|-------|--------|-----------|
| Fullstack Framework | Next.js 14 (App Router) + TypeScript | SSR/SSG for dashboard, API Routes for backend, single deployment |
| Styling | Tailwind CSS | Utility-first, consistent with shadcn/ui |
| UI Components | shadcn/ui | High-quality, customizable, accessible components |
| API Style | REST (Route Handlers) | Simple CRUD + analytics endpoints, no need for GraphQL |
| Database | PostgreSQL | Relational data with time-series analytics queries |
| ORM | Drizzle ORM | Type-safe, lightweight, excellent PostgreSQL support |
| Authentication | NextAuth.js (Credentials + JWT) | Built-in Next.js integration, JWT for stateless sessions |
| Charts | Recharts | Lightweight, declarative, React-native charting |
| Drag & Drop | @dnd-kit/core + @dnd-kit/sortable | Accessible, performant, React 18 compatible |
| CSV Parsing | papaparse | Battle-tested CSV parser, works on client and server |
| File Upload | react-dropzone | Simple drag-and-drop file upload zone |
| Client State | Zustand | Lightweight global state (UI preferences, filters) |
| Server State | TanStack Query | Caching, refetching, optimistic updates for API data |
| Validation | zod | Shared schemas between API routes and forms |
| Dates | date-fns | Lightweight date manipulation and formatting |
| Forms | React Hook Form + zod | Type-safe form validation |
| Deployment | Vercel | Native Next.js support, edge functions, serverless |

## 4. Project Structure

```
ProductivityHub/
├── .nexus/                          # Pipeline artifacts
├── src/
│   ├── app/
│   │   ├── layout.tsx               # Root layout with providers
│   │   ├── page.tsx                 # Dashboard (home)
│   │   ├── globals.css              # Tailwind + shadcn theme
│   │   ├── (auth)/
│   │   │   ├── login/
│   │   │   │   └── page.tsx         # Login page
│   │   │   └── register/
│   │   │       └── page.tsx         # Register page
│   │   ├── today/
│   │   │   └── page.tsx             # Daily planner (today)
│   │   ├── day/
│   │   │   └── [date]/
│   │   │       └── page.tsx         # Daily planner (any date)
│   │   ├── week/
│   │   │   └── page.tsx             # Weekly view
│   │   ├── analytics/
│   │   │   └── page.tsx             # Analytics dashboard
│   │   ├── backlog/
│   │   │   └── page.tsx             # Category backlogs
│   │   ├── categories/
│   │   │   └── page.tsx             # Category management
│   │   ├── import/
│   │   │   └── page.tsx             # CSV import wizard
│   │   ├── settings/
│   │   │   └── page.tsx             # User settings
│   │   └── api/
│   │       ├── auth/
│   │       │   └── [...nextauth]/
│   │       │       └── route.ts     # NextAuth handler
│   │       ├── categories/
│   │       │   ├── route.ts         # GET all, POST create
│   │       │   ├── [id]/
│   │       │   │   └── route.ts     # GET, PUT, DELETE one
│   │       │   └── reorder/
│   │       │       └── route.ts     # PUT reorder
│   │       ├── daily-logs/
│   │       │   ├── route.ts         # GET (query), POST create
│   │       │   └── [id]/
│   │       │       └── route.ts     # GET, PUT one
│   │       ├── task-entries/
│   │       │   ├── route.ts         # GET (query), POST create
│   │       │   ├── [id]/
│   │       │   │   └── route.ts     # GET, PUT, DELETE one
│   │       │   ├── [id]/complete/
│   │       │   │   └── route.ts     # PATCH toggle
│   │       │   └── reorder/
│   │       │       └── route.ts     # PUT reorder
│   │       ├── backlog-items/
│   │       │   ├── route.ts         # GET (query), POST create
│   │       │   └── [id]/
│   │       │       └── route.ts     # GET, PUT, DELETE one
│   │       ├── weekly-goals/
│   │       │   ├── route.ts         # GET (query), POST create
│   │       │   └── [id]/
│   │       │       └── route.ts     # PUT, DELETE one
│   │       ├── analytics/
│   │       │   ├── summary/
│   │       │   │   └── route.ts     # GET aggregated summary
│   │       │   ├── daily-breakdown/
│   │       │   │   └── route.ts     # GET per-day data
│   │       │   ├── category-trends/
│   │       │   │   └── route.ts     # GET category time series
│   │       │   ├── hourly-distribution/
│   │       │   │   └── route.ts     # GET hour histogram
│   │       │   ├── streaks/
│   │       │   │   └── route.ts     # GET streak data
│   │       │   └── sprint-adherence/
│   │       │       └── route.ts     # GET sprint stats
│   │       ├── import/
│   │       │   └── csv/
│   │       │       └── route.ts     # POST CSV upload + parse
│   │       └── export/
│   │           └── csv/
│   │               └── route.ts     # GET CSV export
│   ├── components/
│   │   ├── ui/                      # shadcn/ui components
│   │   ├── layout/
│   │   │   ├── AppSidebar.tsx       # Navigation sidebar
│   │   │   ├── AppHeader.tsx        # Top header with date/user
│   │   │   └── AppShell.tsx         # Layout wrapper
│   │   ├── dashboard/
│   │   │   ├── TodaySummaryCard.tsx
│   │   │   ├── WeeklyHoursChart.tsx
│   │   │   ├── CategoryDonutChart.tsx
│   │   │   ├── StreakBadge.tsx
│   │   │   └── RecentCompletions.tsx
│   │   ├── planner/
│   │   │   ├── TaskEntryRow.tsx
│   │   │   ├── TaskEntryList.tsx
│   │   │   ├── SprintTimeBar.tsx
│   │   │   ├── AddTaskDialog.tsx
│   │   │   ├── BacklogSidebar.tsx
│   │   │   └── DayCompletionSummary.tsx
│   │   ├── analytics/
│   │   │   ├── TimeHeatmap.tsx
│   │   │   ├── CategoryTrendChart.tsx
│   │   │   ├── HourlyHistogram.tsx
│   │   │   ├── CompletionRateChart.tsx
│   │   │   ├── SprintAdherenceGauge.tsx
│   │   │   ├── WeeklyGoalProgress.tsx
│   │   │   └── DateRangeSelector.tsx
│   │   ├── backlog/
│   │   │   ├── CategoryColumn.tsx
│   │   │   ├── BacklogItemCard.tsx
│   │   │   └── AddBacklogItemDialog.tsx
│   │   ├── import/
│   │   │   ├── FileUploadZone.tsx
│   │   │   ├── ColumnMappingStep.tsx
│   │   │   ├── DataPreviewTable.tsx
│   │   │   └── ImportProgressBar.tsx
│   │   └── shared/
│   │       ├── CategoryBadge.tsx
│   │       ├── StarRating.tsx
│   │       ├── TimeRangeInput.tsx
│   │       └── DatePicker.tsx
│   ├── lib/
│   │   ├── db/
│   │   │   ├── index.ts             # Drizzle client
│   │   │   ├── schema.ts            # All table schemas
│   │   │   └── seed.ts              # Default categories seed
│   │   ├── auth/
│   │   │   ├── config.ts            # NextAuth configuration
│   │   │   └── helpers.ts           # Auth utility functions
│   │   ├── api/
│   │   │   └── client.ts            # Typed API client (fetch wrapper)
│   │   ├── validators/
│   │   │   ├── category.ts          # Zod schemas for categories
│   │   │   ├── daily-log.ts         # Zod schemas for daily logs
│   │   │   ├── task-entry.ts        # Zod schemas for task entries
│   │   │   ├── backlog-item.ts      # Zod schemas for backlog items
│   │   │   ├── weekly-goal.ts       # Zod schemas for weekly goals
│   │   │   └── import.ts            # Zod schemas for import
│   │   ├── utils/
│   │   │   ├── date.ts              # Date formatting helpers
│   │   │   ├── time.ts              # Time parsing/formatting
│   │   │   └── csv-parser.ts        # CSV import logic
│   │   └── constants.ts             # Default categories, colors
│   ├── hooks/
│   │   ├── useCategories.ts         # TanStack Query hook
│   │   ├── useDailyLog.ts           # TanStack Query hook
│   │   ├── useTaskEntries.ts        # TanStack Query hook
│   │   ├── useBacklogItems.ts       # TanStack Query hook
│   │   ├── useWeeklyGoals.ts        # TanStack Query hook
│   │   ├── useAnalytics.ts          # TanStack Query hook
│   │   └── useImport.ts             # Import wizard state
│   ├── stores/
│   │   ├── ui-store.ts              # Sidebar state, theme, filters
│   │   └── planner-store.ts         # Daily planner UI state
│   └── types/
│       └── index.ts                 # Shared TypeScript types
├── drizzle/
│   └── migrations/                  # Auto-generated migrations
├── drizzle.config.ts
├── next.config.js
├── tailwind.config.ts
├── tsconfig.json
├── package.json
├── .env.example
├── .env.local                       # Local env (gitignored)
└── components.json                  # shadcn/ui config
```

## 5. Database Schema

### Tables

#### users

| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| id | uuid | PK, default gen_random_uuid() | User identifier |
| email | varchar(255) | UNIQUE, NOT NULL | User email |
| password_hash | varchar(255) | NOT NULL | bcrypt hashed password |
| name | varchar(100) | NOT NULL | Display name |
| created_at | timestamp | NOT NULL, default now() | Account creation |
| updated_at | timestamp | NOT NULL, default now() | Last update |

#### categories

| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| id | uuid | PK, default gen_random_uuid() | Category identifier |
| user_id | uuid | FK → users(id), NOT NULL | Owner |
| code | varchar(10) | NOT NULL | Short code (e.g., "UN", "ATs") |
| name | varchar(100) | NOT NULL | Full name (e.g., "University") |
| color | varchar(7) | NOT NULL, default '#6B7280' | Hex color |
| type | varchar(20) | NOT NULL, default 'general' | Grouping: work, education, personal, etc. |
| sort_order | integer | NOT NULL, default 0 | Display order |
| created_at | timestamp | NOT NULL, default now() | Creation time |

Unique constraint: (user_id, code)

#### daily_logs

| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| id | uuid | PK, default gen_random_uuid() | Log identifier |
| user_id | uuid | FK → users(id), NOT NULL | Owner |
| log_date | date | NOT NULL | Calendar day |
| sprint_start | time | | Planned sprint start (e.g., 08:00) |
| sprint_end | time | | Planned sprint end (e.g., 16:00) |
| notes | text | | Optional daily notes |
| created_at | timestamp | NOT NULL, default now() | Creation time |
| updated_at | timestamp | NOT NULL, default now() | Last update |

Unique constraint: (user_id, log_date)

#### task_entries

| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| id | uuid | PK, default gen_random_uuid() | Entry identifier |
| daily_log_id | uuid | FK → daily_logs(id), NOT NULL | Parent day |
| user_id | uuid | FK → users(id), NOT NULL | Owner (denormalized for queries) |
| category_id | uuid | FK → categories(id), NOT NULL | Task category |
| backlog_item_id | uuid | FK → backlog_items(id), nullable | Source backlog item if pulled |
| title | varchar(255) | NOT NULL | Task name |
| star_rating | smallint | NOT NULL, default 1, check 1-3 | Priority (1-3 stars) |
| tag | varchar(10) | | Status tag: WK, PR, LR, SM |
| time_start | time | | Block start time |
| time_end | time | | Block end time |
| duration_minutes | integer | | Computed duration for analytics |
| is_completed | boolean | NOT NULL, default false | Completion status |
| completed_at | timestamp | nullable | When completed |
| sort_order | integer | NOT NULL, default 0 | Display order within day |
| created_at | timestamp | NOT NULL, default now() | Creation time |
| updated_at | timestamp | NOT NULL, default now() | Last update |

#### backlog_items

| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| id | uuid | PK, default gen_random_uuid() | Item identifier |
| user_id | uuid | FK → users(id), NOT NULL | Owner |
| category_id | uuid | FK → categories(id), NOT NULL | Category this belongs to |
| title | varchar(255) | NOT NULL | Task name |
| star_rating | smallint | NOT NULL, default 1, check 1-3 | Priority |
| is_active | boolean | NOT NULL, default true | Still in backlog |
| created_at | timestamp | NOT NULL, default now() | Creation time |
| updated_at | timestamp | NOT NULL, default now() | Last update |

#### weekly_goals

| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| id | uuid | PK, default gen_random_uuid() | Goal identifier |
| user_id | uuid | FK → users(id), NOT NULL | Owner |
| category_id | uuid | FK → categories(id), NOT NULL | Target category |
| week_start | date | NOT NULL | Monday of target week |
| target_minutes | integer | NOT NULL | Goal in minutes |
| created_at | timestamp | NOT NULL, default now() | Creation time |

Unique constraint: (user_id, category_id, week_start)

#### imports

| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| id | uuid | PK, default gen_random_uuid() | Import identifier |
| user_id | uuid | FK → users(id), NOT NULL | Owner |
| filename | varchar(255) | NOT NULL | Original filename |
| row_count | integer | NOT NULL, default 0 | Rows processed |
| rows_imported | integer | NOT NULL, default 0 | Rows successfully imported |
| rows_skipped | integer | NOT NULL, default 0 | Rows skipped |
| status | varchar(20) | NOT NULL, default 'pending' | pending/processing/complete/failed |
| error_log | text | nullable | Error details |
| created_at | timestamp | NOT NULL, default now() | Import time |

### Relationships

```
users 1──* categories
users 1──* daily_logs
users 1──* backlog_items
users 1──* weekly_goals
users 1──* imports
daily_logs 1──* task_entries
categories 1──* task_entries
categories 1──* backlog_items
categories 1──* weekly_goals
backlog_items 1──* task_entries (optional link)
```

### Key Indexes

- `task_entries(user_id, daily_log_id)` — daily view queries
- `task_entries(user_id, category_id)` — category analytics
- `daily_logs(user_id, log_date)` — unique + lookup
- `task_entries(user_id, created_at)` — time-range analytics
- `backlog_items(user_id, category_id)` — backlog by category
- `weekly_goals(user_id, week_start)` — weekly goals lookup

### Drizzle Schema Reference

```typescript
import { pgTable, uuid, varchar, text, integer, smallint, boolean, timestamp, date, time, uniqueIndex, index } from 'drizzle-orm/pg-core';

export const users = pgTable('users', {
  id: uuid('id').defaultRandom().primaryKey(),
  email: varchar('email', { length: 255 }).unique().notNull(),
  passwordHash: varchar('password_hash', { length: 255 }).notNull(),
  name: varchar('name', { length: 100 }).notNull(),
  createdAt: timestamp('created_at').defaultNow().notNull(),
  updatedAt: timestamp('updated_at').defaultNow().notNull(),
});

export const categories = pgTable('categories', {
  id: uuid('id').defaultRandom().primaryKey(),
  userId: uuid('user_id').references(() => users.id).notNull(),
  code: varchar('code', { length: 10 }).notNull(),
  name: varchar('name', { length: 100 }).notNull(),
  color: varchar('color', { length: 7 }).notNull().default('#6B7280'),
  type: varchar('type', { length: 20 }).notNull().default('general'),
  sortOrder: integer('sort_order').notNull().default(0),
  createdAt: timestamp('created_at').defaultNow().notNull(),
}, (table) => ({
  userCodeIdx: uniqueIndex('categories_user_code_idx').on(table.userId, table.code),
}));

export const dailyLogs = pgTable('daily_logs', {
  id: uuid('id').defaultRandom().primaryKey(),
  userId: uuid('user_id').references(() => users.id).notNull(),
  logDate: date('log_date').notNull(),
  sprintStart: time('sprint_start'),
  sprintEnd: time('sprint_end'),
  notes: text('notes'),
  createdAt: timestamp('created_at').defaultNow().notNull(),
  updatedAt: timestamp('updated_at').defaultNow().notNull(),
}, (table) => ({
  userDateIdx: uniqueIndex('daily_logs_user_date_idx').on(table.userId, table.logDate),
}));

export const taskEntries = pgTable('task_entries', {
  id: uuid('id').defaultRandom().primaryKey(),
  dailyLogId: uuid('daily_log_id').references(() => dailyLogs.id).notNull(),
  userId: uuid('user_id').references(() => users.id).notNull(),
  categoryId: uuid('category_id').references(() => categories.id).notNull(),
  backlogItemId: uuid('backlog_item_id').references(() => backlogItems.id),
  title: varchar('title', { length: 255 }).notNull(),
  starRating: smallint('star_rating').notNull().default(1),
  tag: varchar('tag', { length: 10 }),
  timeStart: time('time_start'),
  timeEnd: time('time_end'),
  durationMinutes: integer('duration_minutes'),
  isCompleted: boolean('is_completed').notNull().default(false),
  completedAt: timestamp('completed_at'),
  sortOrder: integer('sort_order').notNull().default(0),
  createdAt: timestamp('created_at').defaultNow().notNull(),
  updatedAt: timestamp('updated_at').defaultNow().notNull(),
}, (table) => ({
  userDailyLogIdx: index('task_entries_user_daily_log_idx').on(table.userId, table.dailyLogId),
  userCategoryIdx: index('task_entries_user_category_idx').on(table.userId, table.categoryId),
  userCreatedIdx: index('task_entries_user_created_idx').on(table.userId, table.createdAt),
}));

export const backlogItems = pgTable('backlog_items', {
  id: uuid('id').defaultRandom().primaryKey(),
  userId: uuid('user_id').references(() => users.id).notNull(),
  categoryId: uuid('category_id').references(() => categories.id).notNull(),
  title: varchar('title', { length: 255 }).notNull(),
  starRating: smallint('star_rating').notNull().default(1),
  isActive: boolean('is_active').notNull().default(true),
  createdAt: timestamp('created_at').defaultNow().notNull(),
  updatedAt: timestamp('updated_at').defaultNow().notNull(),
}, (table) => ({
  userCategoryIdx: index('backlog_items_user_category_idx').on(table.userId, table.categoryId),
}));

export const weeklyGoals = pgTable('weekly_goals', {
  id: uuid('id').defaultRandom().primaryKey(),
  userId: uuid('user_id').references(() => users.id).notNull(),
  categoryId: uuid('category_id').references(() => categories.id).notNull(),
  weekStart: date('week_start').notNull(),
  targetMinutes: integer('target_minutes').notNull(),
  createdAt: timestamp('created_at').defaultNow().notNull(),
}, (table) => ({
  userCategoryWeekIdx: uniqueIndex('weekly_goals_user_category_week_idx').on(table.userId, table.categoryId, table.weekStart),
}));

export const imports = pgTable('imports', {
  id: uuid('id').defaultRandom().primaryKey(),
  userId: uuid('user_id').references(() => users.id).notNull(),
  filename: varchar('filename', { length: 255 }).notNull(),
  rowCount: integer('row_count').notNull().default(0),
  rowsImported: integer('rows_imported').notNull().default(0),
  rowsSkipped: integer('rows_skipped').notNull().default(0),
  status: varchar('status', { length: 20 }).notNull().default('pending'),
  errorLog: text('error_log'),
  createdAt: timestamp('created_at').defaultNow().notNull(),
});
```

## 6. API Contract

> This section is the critical handshake between frontend and backend. Both skills build against it independently.

### Authentication Endpoints

NextAuth.js handles auth automatically at `/api/auth/[...nextauth]`. Custom endpoints:

| Method | Path | Request Body | Response | Auth |
|--------|------|-------------|----------|------|
| POST | /api/auth/register | `{ email: string, password: string, name: string }` | `{ user: { id, email, name } }` | No |
| GET | /api/auth/session | — | NextAuth session object | No |

NextAuth built-in routes (handled automatically):
- `POST /api/auth/signin` — Sign in
- `POST /api/auth/signout` — Sign out
- `GET /api/auth/session` — Get session

### Categories

| Method | Path | Request Body | Response | Auth |
|--------|------|-------------|----------|------|
| GET | /api/categories | — | `{ categories: Category[] }` | Yes |
| POST | /api/categories | `{ code: string, name: string, color: string, type: string }` | `{ category: Category }` | Yes |
| PUT | /api/categories/[id] | `{ code?: string, name?: string, color?: string, type?: string }` | `{ category: Category }` | Yes |
| DELETE | /api/categories/[id] | — | `{ success: true }` | Yes |
| PUT | /api/categories/reorder | `{ ids: string[] }` | `{ success: true }` | Yes |

**Category type:**
```typescript
type Category = {
  id: string;
  code: string;
  name: string;
  color: string;
  type: string;
  sortOrder: number;
  createdAt: string;
}
```

### Daily Logs

| Method | Path | Request Body | Response | Auth |
|--------|------|-------------|----------|------|
| GET | /api/daily-logs?date=YYYY-MM-DD | — | `{ dailyLog: DailyLog \| null }` | Yes |
| GET | /api/daily-logs?from=YYYY-MM-DD&to=YYYY-MM-DD | — | `{ dailyLogs: DailyLog[] }` | Yes |
| POST | /api/daily-logs | `{ logDate: string, sprintStart?: string, sprintEnd?: string, notes?: string }` | `{ dailyLog: DailyLog }` | Yes |
| PUT | /api/daily-logs/[id] | `{ sprintStart?: string, sprintEnd?: string, notes?: string }` | `{ dailyLog: DailyLog }` | Yes |

**DailyLog type:**
```typescript
type DailyLog = {
  id: string;
  logDate: string;
  sprintStart: string | null;
  sprintEnd: string | null;
  notes: string | null;
  createdAt: string;
  updatedAt: string;
}
```

### Task Entries

| Method | Path | Request Body | Response | Auth |
|--------|------|-------------|----------|------|
| GET | /api/task-entries?dailyLogId=uuid | — | `{ taskEntries: TaskEntry[] }` | Yes |
| GET | /api/task-entries?from=YYYY-MM-DD&to=YYYY-MM-DD | — | `{ taskEntries: TaskEntry[] }` | Yes |
| POST | /api/task-entries | `{ dailyLogId: string, categoryId: string, title: string, starRating: number, tag?: string, timeStart?: string, timeEnd?: string, backlogItemId?: string }` | `{ taskEntry: TaskEntry }` | Yes |
| PUT | /api/task-entries/[id] | `{ categoryId?: string, title?: string, starRating?: number, tag?: string, timeStart?: string, timeEnd?: string }` | `{ taskEntry: TaskEntry }` | Yes |
| DELETE | /api/task-entries/[id] | — | `{ success: true }` | Yes |
| PATCH | /api/task-entries/[id]/complete | `{ isCompleted: boolean }` | `{ taskEntry: TaskEntry }` | Yes |
| PUT | /api/task-entries/reorder | `{ entries: { id: string, sortOrder: number }[] }` | `{ success: true }` | Yes |

**TaskEntry type:**
```typescript
type TaskEntry = {
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
}
```

### Backlog Items

| Method | Path | Request Body | Response | Auth |
|--------|------|-------------|----------|------|
| GET | /api/backlog-items | — | `{ backlogItems: BacklogItem[] }` | Yes |
| GET | /api/backlog-items?categoryId=uuid | — | `{ backlogItems: BacklogItem[] }` | Yes |
| POST | /api/backlog-items | `{ categoryId: string, title: string, starRating?: number }` | `{ backlogItem: BacklogItem }` | Yes |
| PUT | /api/backlog-items/[id] | `{ title?: string, starRating?: number, categoryId?: string, isActive?: boolean }` | `{ backlogItem: BacklogItem }` | Yes |
| DELETE | /api/backlog-items/[id] | — | `{ success: true }` | Yes |

**BacklogItem type:**
```typescript
type BacklogItem = {
  id: string;
  categoryId: string;
  title: string;
  starRating: number;
  isActive: boolean;
  createdAt: string;
  updatedAt: string;
  category?: Category;
}
```

### Weekly Goals

| Method | Path | Request Body | Response | Auth |
|--------|------|-------------|----------|------|
| GET | /api/weekly-goals?weekStart=YYYY-MM-DD | — | `{ weeklyGoals: WeeklyGoal[] }` | Yes |
| POST | /api/weekly-goals | `{ categoryId: string, weekStart: string, targetMinutes: number }` | `{ weeklyGoal: WeeklyGoal }` | Yes |
| PUT | /api/weekly-goals/[id] | `{ targetMinutes: number }` | `{ weeklyGoal: WeeklyGoal }` | Yes |
| DELETE | /api/weekly-goals/[id] | — | `{ success: true }` | Yes |

**WeeklyGoal type:**
```typescript
type WeeklyGoal = {
  id: string;
  categoryId: string;
  weekStart: string;
  targetMinutes: number;
  createdAt: string;
  category?: Category;
}
```

### Analytics

| Method | Path | Query Params | Response | Auth |
|--------|------|-------------|----------|------|
| GET | /api/analytics/summary | `from`, `to` | `{ totalMinutes, tasksCompleted, tasksTotal, completionRate, sprintUtilization, categoryBreakdown: { categoryId, code, color, minutes }[] }` | Yes |
| GET | /api/analytics/daily-breakdown | `from`, `to` | `{ days: { date, totalMinutes, tasksCompleted, tasksTotal, categories: { categoryId, code, color, minutes }[] }[] }` | Yes |
| GET | /api/analytics/category-trends | `from`, `to` | `{ trends: { categoryId, code, color, dataPoints: { date, minutes }[] }[] }` | Yes |
| GET | /api/analytics/hourly-distribution | `from`, `to` | `{ hours: { hour: number, totalMinutes: number, taskCount: number }[] }` | Yes |
| GET | /api/analytics/streaks | — | `{ currentStreak, bestStreak, lastActiveDate }` | Yes |
| GET | /api/analytics/sprint-adherence | `from`, `to` | `{ days: { date, sprintMinutes, actualMinutes, adherencePercent }[] }` | Yes |

### Import / Export

| Method | Path | Request Body | Response | Auth |
|--------|------|-------------|----------|------|
| POST | /api/import/csv | FormData with `file` field | `{ importId, preview: { headers, rows: first20rows, detectedMapping } }` | Yes |
| POST | /api/import/csv/confirm | `{ importId: string, mapping: ColumnMapping }` | `{ import: Import }` | Yes |
| GET | /api/export/csv?from=YYYY-MM-DD&to=YYYY-MM-DD | — | CSV file download | Yes |

**ColumnMapping type:**
```typescript
type ColumnMapping = {
  taskName: number;       // column index
  category: number;       // column index
  timeRange: number;      // column index
  date: number;           // column index
  starRating?: number;    // column index
  tag?: number;           // column index
  backlogColumns?: { columnIndex: number, categoryCode: string }[];
}
```

### Error Response Shape

```json
{
  "error": "Human-readable error message",
  "code": "VALIDATION_ERROR",
  "details": {}
}
```

### HTTP Status Codes

| Code | Usage |
|------|-------|
| 200 | Success |
| 201 | Created |
| 400 | Validation error |
| 401 | Unauthorized |
| 404 | Not found |
| 500 | Server error |

## 7. Frontend Breakdown

### Pages / Routes

| Route | Page Component | Purpose |
|-------|---------------|---------|
| /login | LoginPage | Email/password login form |
| /register | RegisterPage | Account creation form |
| / | DashboardPage | Analytics overview: today summary, weekly chart, streaks, category donut |
| /today | DailyPlannerPage | Today's task list with time blocks, backlog sidebar, sprint bar |
| /day/[date] | DailyPlannerPage | Same planner for any date (param-driven) |
| /week | WeeklyViewPage | 7-day grid, weekly goal progress bars |
| /analytics | AnalyticsPage | Full analytics: heatmap, trends, histograms, completion rate, sprint adherence |
| /backlog | BacklogPage | Category-grouped task backlogs, add/edit items |
| /categories | CategoriesPage | Manage categories: add, edit, reorder, color picker |
| /import | ImportPage | CSV upload wizard: upload, map columns, preview, import |
| /settings | SettingsPage | Profile, default sprint times, export |

### Component Hierarchy

```
App (layout.tsx)
├── Providers (QueryClientProvider, SessionProvider, ThemeProvider)
├── AuthLayout (for /login, /register)
│   ├── LoginForm
│   └── RegisterForm
├── AppShell (for authenticated routes)
│   ├── AppSidebar
│   │   ├── Logo
│   │   ├── NavLinks (Dashboard, Today, Week, Analytics, Backlog, Categories, Import, Settings)
│   │   └── UserMenu
│   ├── AppHeader
│   │   ├── PageTitle
│   │   ├── DatePicker (for planner pages)
│   │   └── TodayButton
│   └── Main Content (page routes)
├── DashboardPage
│   ├── TodaySummaryCard (tasks done/total, hours, sprint %)
│   ├── WeeklyHoursChart (stacked bar, Recharts)
│   ├── CategoryDonutChart (donut, Recharts)
│   ├── StreakBadge (current streak count)
│   └── RecentCompletions (latest completed tasks)
├── DailyPlannerPage
│   ├── SprintTimeBar (visual bar showing sprint window + task coverage)
│   ├── TaskEntryList (@dnd-kit sortable)
│   │   └── TaskEntryRow (CategoryBadge, StarRating, time display, checkbox, edit/delete)
│   ├── AddTaskDialog (form: title, category, stars, time start/end, tag)
│   ├── BacklogSidebar (collapsible, grouped by category, drag items to planner)
│   └── DayCompletionSummary (bottom stats: completed, total, hours)
├── WeeklyViewPage
│   ├── WeekNavigator (prev/next week arrows)
│   ├── WeekGrid (7 DayColumn components)
│   │   └── DayColumn (date header, task count, category breakdown mini-bars)
│   └── WeeklyGoalProgress (progress bars per category vs target)
├── AnalyticsPage
│   ├── DateRangeSelector (from/to date pickers, preset: this week, this month, last 30 days)
│   ├── TimeHeatmap (calendar grid, colored by hours — like GitHub contributions)
│   ├── CategoryTrendChart (multi-line chart, Recharts)
│   ├── HourlyHistogram (bar chart, hours 0-23 on x-axis)
│   ├── CompletionRateChart (line chart, planned vs completed)
│   ├── SprintAdherenceGauge (radial gauge or progress bar)
│   └── WeeklyGoalProgress (reused from WeeklyViewPage)
├── BacklogPage
│   ├── CategoryColumn (one per category, scrollable list)
│   │   └── BacklogItemCard (title, stars, drag handle, edit/delete actions)
│   ├── AddBacklogItemDialog (form: title, category, stars)
│   └── CategoryFilter (filter which categories to show)
├── CategoriesPage
│   ├── CategoryList (@dnd-kit sortable for reorder)
│   │   └── CategoryRow (color swatch, code, name, edit/delete)
│   └── AddCategoryDialog (form: code, name, color picker, type)
├── ImportPage
│   ├── FileUploadZone (react-dropzone, accepts .csv)
│   ├── ColumnMappingStep (auto-detected + manual override, with column preview)
│   ├── DataPreviewTable (first 20 rows mapped to app format)
│   ├── ImportProgressBar (during import)
│   └── ImportResultsSummary (imported/skipped/errors)
├── SettingsPage
│   ├── ProfileForm (name, email)
│   ├── DefaultSprintSettings (default start/end times)
│   └── ExportSection (date range + download button)
└── Shared Components
    ├── CategoryBadge (colored badge with category code)
    ├── StarRating (1-3 stars, clickable)
    ├── TimeRangeInput (start time + end time pickers)
    ├── DatePicker (shadcn/ui calendar)
    └── LoadingSpinner
```

### State Management

- **Zustand stores:**
  - `ui-store.ts` — sidebar collapsed state, selected date for planner, theme preference
  - `planner-store.ts` — drag-and-drop UI state, backlog sidebar visibility, selected category filter

- **TanStack Query** — all server data (categories, daily logs, task entries, backlog items, weekly goals, analytics). Provides caching, background refetch, optimistic updates for task completion/reorder.

### Key Frontend Libraries

| Library | Purpose |
|---------|---------|
| next | Fullstack framework (App Router) |
| next-auth | Authentication (Credentials + JWT) |
| @tanstack/react-query | Server state management, caching |
| zustand | Client UI state |
| react-hook-form | Form handling |
| zod | Validation (shared with API routes) |
| @hookform/resolvers | Zod resolver for react-hook-form |
| recharts | Charts (bar, line, pie, area) |
| @dnd-kit/core | Drag and drop core |
| @dnd-kit/sortable | Sortable lists |
| @dnd-kit/utilities | DnD utilities |
| papaparse | CSV parsing (preview on client) |
| react-dropzone | File upload drag zone |
| date-fns | Date utilities |
| lucide-react | Icons (consistent with shadcn/ui) |
| tailwindcss | Styling |
| class-variance-authority | shadcn/ui dependency |
| clsx + tailwind-merge | Class merging utility |

## 8. Backend Breakdown

### Endpoint Groups

#### Auth Group
- `POST /api/auth/register` — Create user, hash password, seed default categories, return user
- `POST /api/auth/[...nextauth]` — NextAuth handles signin/signout/session
- Key logic: Password hashing with bcrypt, default category seeding on registration

#### Categories Group
- CRUD for categories
- Reorder: batch update sort_order values
- Key logic: Validate unique code per user, cascade considerations on delete

#### Daily Logs Group
- Get by date or date range
- Upsert: create or return existing log for a date
- Key logic: Auto-create daily log when first task is added for a date

#### Task Entries Group
- CRUD within a daily log
- Complete/uncomplete toggle with timestamp
- Reorder: batch update sort_order
- Key logic: Compute `duration_minutes` from time_start/time_end on create/update. Handle midnight-crossing times.

#### Backlog Items Group
- CRUD by category
- Filter by category, active status
- Key logic: When pulled into daily planner, link via `backlog_item_id`

#### Weekly Goals Group
- CRUD by week
- Key logic: Prevent duplicate (user + category + week_start)

#### Analytics Group
- **Summary**: Aggregate total minutes, completion rate, category breakdown for date range
- **Daily breakdown**: Per-day aggregation with category sub-totals
- **Category trends**: Time series of minutes per category
- **Hourly distribution**: Histogram of task activity by hour of day
- **Streaks**: Count consecutive days with completed tasks
- **Sprint adherence**: Compare sprint window minutes vs actual task minutes per day
- Key logic: All analytics use SQL aggregation queries via Drizzle for performance. Date range filtering with `from`/`to` query params.

#### Import Group
- Parse CSV, auto-detect column types, return preview with suggested mapping
- Confirm import: apply mapping, batch insert daily logs + task entries + backlog items in transaction
- Key logic: Parse time ranges ("02:00PM - 03:00PM"), handle midnight crossing, detect sprint rows ("Sp 08:00AM - 04:00PM"), extract star ratings, match category codes

#### Export Group
- Generate CSV from task entries in date range
- Key logic: Join with categories, format times, stream response

### Middleware Stack

Since this is Next.js Route Handlers, middleware is handled differently than Express:

| Layer | Implementation | Purpose |
|-------|---------------|---------|
| 1 | `middleware.ts` (Next.js) | Auth check — redirect unauthenticated to /login |
| 2 | NextAuth session | Token verification on API routes |
| 3 | Zod validation | Request body/query validation per route |
| 4 | Error wrapper | Try/catch wrapper returning consistent error shape |

Each API route handler follows this pattern:
```typescript
export async function GET(req: NextRequest) {
  try {
    const session = await getServerSession(authConfig);
    if (!session) return NextResponse.json({ error: 'Unauthorized' }, { status: 401 });
    // ... business logic
  } catch (error) {
    return NextResponse.json({ error: 'Internal server error' }, { status: 500 });
  }
}
```

### Business Logic Modules

| Module | File | Responsibility |
|--------|------|---------------|
| Auth Service | `src/lib/auth/config.ts` | NextAuth config, credentials provider, JWT callbacks |
| DB Client | `src/lib/db/index.ts` | Drizzle client initialization |
| Seed | `src/lib/db/seed.ts` | Default categories with codes and colors |
| CSV Parser | `src/lib/utils/csv-parser.ts` | Parse CSV, detect columns, map to app entities |
| Time Utils | `src/lib/utils/time.ts` | Parse time strings, compute duration, handle midnight |
| Date Utils | `src/lib/utils/date.ts` | Format dates, week boundaries, date ranges |
| Analytics Queries | `src/lib/db/analytics.ts` | SQL aggregation functions for each analytics endpoint |

## 9. Environment Variables

| Variable | Description | Example | Required |
|----------|-------------|---------|----------|
| DATABASE_URL | PostgreSQL connection string | postgresql://user:pass@localhost:5432/productivityhub | Yes |
| NEXTAUTH_SECRET | NextAuth JWT signing secret | random-32-char-string | Yes |
| NEXTAUTH_URL | App URL for NextAuth | http://localhost:3000 | Yes |
| BCRYPT_SALT_ROUNDS | Password hashing rounds | 12 | No (default 12) |

`.env.example`:
```
DATABASE_URL=postgresql://postgres:postgres@localhost:5432/productivityhub
NEXTAUTH_SECRET=your-secret-key-change-in-production
NEXTAUTH_URL=http://localhost:3000
BCRYPT_SALT_ROUNDS=12
```

## 10. Implementation Order

1. **Project scaffold** — `npx create-next-app@14` with TypeScript, Tailwind, App Router
2. **shadcn/ui setup** — `npx shadcn-ui@latest init` + install needed components
3. **Database schema** — Drizzle schema, migrations, seed script
4. **Auth** — NextAuth config, login/register pages, middleware
5. **Categories** — CRUD API + management page (foundation for everything else)
6. **Daily logs + task entries** — CRUD API + daily planner page (core feature)
7. **Backlog items** — CRUD API + backlog page + drag to planner
8. **Weekly view** — Weekly goals API + page
9. **Dashboard** — Summary API + dashboard page with charts
10. **Analytics** — Analytics APIs + full analytics page with all chart types
11. **Import** — CSV parser + import wizard page
12. **Export** — CSV export endpoint + settings page
13. **Polish** — Responsive design, loading states, error boundaries

### Default Categories Seed Data

```typescript
const DEFAULT_CATEGORIES = [
  { code: 'IM', name: 'Important', color: '#EF4444', type: 'priority' },
  { code: 'Projs', name: 'Projects', color: '#3B82F6', type: 'work' },
  { code: 'UN', name: 'University', color: '#8B5CF6', type: 'education' },
  { code: 'CR', name: 'Code Review', color: '#06B6D4', type: 'work' },
  { code: 'SM', name: 'Social Media', color: '#F59E0B', type: 'marketing' },
  { code: 'UP', name: 'Upwork', color: '#10B981', type: 'freelance' },
  { code: 'FR', name: 'Freelance', color: '#14B8A6', type: 'freelance' },
  { code: 'AGN', name: 'Agency', color: '#EC4899', type: 'business' },
  { code: 'RD', name: 'Research & Development', color: '#6366F1', type: 'learning' },
  { code: 'ATs', name: 'Automations', color: '#F97316', type: 'tech' },
  { code: 'TIs', name: 'Tools', color: '#84CC16', type: 'tech' },
  { code: 'WK', name: 'Work', color: '#22C55E', type: 'general' },
  { code: 'PR', name: 'Personal', color: '#E11D48', type: 'personal' },
  { code: 'LR', name: 'Learning', color: '#EAB308', type: 'education' },
];
```
