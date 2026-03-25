---
source: user-input
received: 2026-03-21T10:00:00Z
---

# Project Requirements: ProductivityHub

## Overview

Build a productivity tracking web app that replaces a daily task tracking Google Sheet. The user currently tracks tasks with category codes, star ratings, time blocks, and daily sprint windows in Google Sheets. The app should provide a superior experience with interactive task management and rich analytics/insights on time utilization.

## Current Workflow (Google Sheets)

The user's Google Sheet tracks:
- **Daily task entries** with: task name, category tag (color-coded), 1-3 star priority rating, time block (start/end times)
- **Daily sprint windows** (e.g., "Sp 08:00AM - 04:00PM") defining the planned work period
- **Category-grouped backlogs** as vertical lists under category headers (columns J-T in the sheet)
- **Completion tracking** — tasks moved to "Done" column
- **Dates** per day block

### Category Codes (must be pre-seeded)
| Code | Full Name | Color Type |
|------|-----------|------------|
| IM | Important | Priority |
| Projs | Projects | Work |
| UN | University | Education |
| CR | Code Review | Work |
| SM | Social Media | Marketing |
| UP | Upwork | Freelance |
| FR | Freelance | Freelance |
| AGN | Agency | Business |
| RD | Research & Development | Learning |
| ATs | Automations | Tech |
| TIs | Tools | Tech |
| WK | Work | General (green) |
| PR | Personal | Personal (red/orange) |
| LR | Learning | Education (yellow) |

### Category Task Backlogs (example items from the sheet)
- **Projs**: Project Moji, PR Productivity MVP, Hunter Trading, Project GSA, Testing Claude Fullstack Skills
- **UN**: DOA, DV, ML, AC, RB
- **SM**: SM Content Management, AntiGravity NotebookLm, LinkedIn & Insta Outreach, Manychat, SM Content Posting
- **UP**: Upwork Bidding, Upwork Consultations, AL/ML Projects Case Studies
- **FR**: Finding Fiverr Expert, nSave Payment app
- **AGN**: Agency Website, CAC LTV Gross Profit, how to pick markets, Creating Grand Slam Offer, Sales Script, Claude Code Course, Meme Generator
- **RD**: How AI Works From Sorcery, Daily Brief
- **ATs**: OpenClaw Setup, ClawGravity Setup, 100M Offer At, SOP Generation At, Website Audit At, Website Design At, Website Development
- **TIs**: Auto IGDM, HeyReach, Expedite, App Sumo, Trigger.Dev, many chats

## Core Features

### 1. User Authentication
- Single-user with potential for multi-user
- Login/Register with email and password
- Use NextAuth.js with Credentials provider

### 2. Daily Task Planner
- Create tasks with: title, category code, 1-3 star priority rating, start time, end time
- Set daily sprint window (planned work period start/end)
- View tasks as a time-blocked list for any date
- Mark tasks as completed (with timestamp)
- Drag-and-drop to reorder tasks within a day
- Pull tasks from category backlogs into the daily plan
- Navigate between days with a date picker

### 3. Category Backlogs
- Persistent task pools organized by category (mirrors spreadsheet columns J-T)
- Each category has its own list of backlog items
- Add/edit/remove backlog items
- Star rating on backlog items
- Drag backlog items into the daily planner

### 4. Category Management
- View all categories with their color codes
- Add/edit/delete categories
- Reorder categories
- Color picker for category colors

### 5. CSV Import Wizard (Google Sheets Data)
- Upload Google Sheets CSV export via drag-and-drop
- Auto-detect columns: task names, time ranges, dates, star ratings, category codes
- Column mapping UI with preview of parsed data
- Handle two data layouts:
  - Daily task rows → task_entries (with time blocks)
  - Category columns (J-T style) → backlog_items
- Special handling for sprint rows (starting with "Sp") to extract sprint times
- Handle midnight-crossing time ranges (e.g., "11:30PM - 01:30AM")
- Batch insert in database transaction
- Import results summary: rows imported, skipped, errors

### 6. Analytics Dashboard
The primary value-add over spreadsheets. Must include:

- **Today Summary Card**: tasks done/total, hours logged, sprint utilization percentage
- **Weekly Stacked Bar Chart**: hours per category per day for the current week
- **Category Distribution Donut Chart**: where time goes this week vs. last week
- **Time Heatmap Calendar**: GitHub contribution graph style, colored by hours logged per day
- **Category Trend Lines**: hours per category over time (line chart)
- **Productivity by Hour Histogram**: which hours of the day have the most task activity
- **Completion Rate Chart**: tasks planned vs tasks completed per day/week
- **Sprint Adherence Gauge**: planned sprint hours vs actual task hours as percentage
- **Streak Tracking**: consecutive days with completed tasks / met sprint targets
- **Weekly Goals**: set target hours per category for the week, track progress with progress bars

### 7. Weekly View
- 7-day grid showing tasks per day at a glance
- Weekly goal progress indicators
- Quick navigation to any day's planner

### 8. Export
- Export task data as CSV with date range filter

## Tech Stack Requirements

- **Framework**: Next.js 14 (App Router) + TypeScript
- **Styling**: Tailwind CSS + shadcn/ui components
- **Charts**: Recharts
- **Drag & Drop**: @dnd-kit/core + @dnd-kit/sortable
- **CSV Parsing**: papaparse
- **File Upload**: react-dropzone
- **Database**: PostgreSQL + Drizzle ORM
- **Auth**: NextAuth.js (Credentials provider + JWT sessions)
- **State Management**: Zustand (client state) + TanStack Query (server state)
- **Validation**: zod (shared between frontend and backend)
- **Dates**: date-fns
- **Deployment**: Vercel-ready

## UI Requirements

- Clean, modern dashboard layout with sidebar navigation
- Responsive/mobile-friendly design
- Color-coded categories throughout (badges, charts, borders)
- Dark mode support via shadcn/ui theming
- Drag-and-drop task ordering in daily planner
- Date picker for navigating between days
- Date range selector for analytics views

## Project Structure

Since Next.js is fullstack, use a single project directory:
```
ProductivityHub/
├── src/
│   ├── app/              # App Router pages + API routes
│   │   ├── api/          # Route Handlers (backend)
│   │   ├── (auth)/       # Auth pages (login, register)
│   │   ├── (dashboard)/  # Main app pages
│   │   └── layout.tsx    # Root layout
│   ├── components/       # Shared UI components
│   ├── lib/              # Utilities, DB config, auth config
│   └── types/            # Shared TypeScript types
├── drizzle/              # Migrations
└── .nexus/               # Pipeline artifacts
```
