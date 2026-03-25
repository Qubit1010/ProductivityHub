---
project: ProductivityHub
created: 2026-03-21T10:05:00Z
---

# Decision Log

[2026-03-21] DECISION: Use Next.js 14 App Router instead of React+Vite+Express | REASONING: User explicitly requested Next.js; fullstack framework eliminates separate client/server setup, simplifies deployment to Vercel | CONTEXT: Default pipeline stack is React+Vite+Express but user override takes priority

[2026-03-21] DECISION: Use NextAuth.js instead of manual JWT | REASONING: NextAuth integrates natively with Next.js, handles session management, CSRF protection, and has Credentials provider for email/password auth | CONTEXT: Pipeline default is JWT+bcrypt; NextAuth uses JWT under the hood but adds session management layer

[2026-03-21] DECISION: CSV file upload for Google Sheets import instead of Google Sheets API | REASONING: Avoids OAuth complexity and Google Cloud project setup; user can export CSV with one click; API integration can be added later | CONTEXT: User needs to import existing Google Sheets data with complex column structure

[2026-03-21] DECISION: Recharts over Chart.js for data visualization | REASONING: Better React integration with declarative API, lighter bundle, component-based approach matches React patterns | CONTEXT: Need stacked bar, line, donut, area charts + calendar heatmap

[2026-03-21] DECISION: Denormalize duration_minutes on task_entries | REASONING: Avoids computing time differences in every analytics query; computed on insert/update from time_start/time_end | CONTEXT: Analytics endpoints need fast aggregation across potentially thousands of task entries

[2026-03-21] DECISION: Separate backlog_items from task_entries | REASONING: Backlogs are persistent pools of work; task_entries are daily instances that may reference a backlog item via backlog_item_id | CONTEXT: User's sheet has both daily task rows (B-I) and category backlog columns (J-T) as distinct data structures

[2026-03-21] DECISION: Complexity tier = Standard (score 15) | REASONING: Rich analytics UI and multi-table DB push toward complex, but single-user scope and no real-time features keep it in standard range | CONTEXT: 5-dimension scoring: Data(4) + Auth(2) + UI(4) + Integrations(3) + Scale(2) = 15
