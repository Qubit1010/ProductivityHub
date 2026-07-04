# TODOS — deferred by the 2026-07-04 autoplan review round

## E6 — Default sprint window in Settings
- **What:** Settings field for default sprint start/end + prefill on new daily-log creation.
- **Why:** Sprints are a confirmed overnight pattern (9PM-6AM per Phase 0 diagnosis); re-entering the same times daily is friction.
- **Pros:** Removes daily re-entry, one-time setup.
- **Cons:** Touches Settings page + schema default + daily-log creation flow — none reviewed by the CEO/Eng passes that shipped the analytics round.
- **Depends on:** Nothing blocking; can start anytime.

## Other deferred (Decision Audit Trail #6 / #11)
- Quarterly goals (needs schema change).
- Assistant WRITE API (new attack surface — briefing endpoint is read-only by design).
- PWA / service-worker push notifications (new infra).
- Streak grace days.
- Migrate the daily digest from Windows Task Scheduler to Vercel Cron.
- `ASSISTANT_TOKEN` must be added in the Vercel dashboard before the Nexis assistant can call the production briefing endpoint (local `.env.local` already has it).
