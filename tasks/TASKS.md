# OpenClaw Central Task List

Tasks here are visible to all agents. Each heartbeat, agents check for unclaimed tasks
assigned to them and pick up the highest-priority pending item.

## Format
```
- [ ] [TASK-NNN] Title · priority:high|med|low · owner:agent · project:name · created:YYYY-MM-DD
- [>] [TASK-NNN] Title · priority:high · owner:agent · project:name · started:YYYY-MM-DD
- [x] [TASK-NNN] Title · priority:high · owner:agent · project:name · done:YYYY-MM-DD
- [-] [TASK-NNN] Title · priority:med · owner:agent · project:name · blocked:reason
```

Statuses: `[ ]` pending · `[>]` in progress · `[x]` done · `[-]` blocked

## Active Tasks

### Phase 2: Dashboard (HIGH PRIORITY — auth foundation is shipped)

- [ ] [TASK-030] Design dashboard layout specs: sidebar (240px), content grid, API key table, stats cards, responsive breakpoints. Output to site/design/dashboard.md · priority:high · owner:designer · project:slancha · created:2026-03-29
- [x] [TASK-031] Write all dashboard copy: sidebar labels (Overview, API Keys, Usage, Settings), empty states, tooltips, confirmation dialogs, API key creation flow text. Output to site/copy/dashboard.md · priority:high · owner:copywriter · project:slancha · created:2026-03-29 · started:2026-03-29 · done:2026-03-29
- [ ] [TASK-032] Build Dashboard shell page (src/pages/Dashboard.jsx + .css) with DashboardNav top bar and Sidebar left nav using Outlet for content area. Use existing dark design tokens. · priority:high · owner:frontend · project:slancha · created:2026-03-29
- [ ] [TASK-033] Build EmptyState reusable component (src/components/dashboard/EmptyState.jsx + .css) — icon + heading + description + CTA button · priority:med · owner:frontend · project:slancha · created:2026-03-29
- [ ] [TASK-034] Build ApiKeys dashboard component (src/components/dashboard/ApiKeys.jsx + .css) — table with name, key prefix, created date, status, copy/revoke actions · priority:high · owner:frontend · project:slancha · created:2026-03-29
- [ ] [TASK-035] Build UsageStats dashboard component (src/components/dashboard/UsageStats.jsx + .css) — summary cards for total requests, unique models, avg latency; CSS-only bar chart · priority:med · owner:frontend · project:slancha · created:2026-03-29
- [ ] [TASK-036] Build Overview dashboard component (src/components/dashboard/Overview.jsx + .css) — summary cards, recent activity, "Create your first API key" CTA · priority:med · owner:frontend · project:slancha · created:2026-03-29
- [ ] [TASK-037] Build AccountSettings dashboard component (src/components/dashboard/AccountSettings.jsx + .css) — profile edit (display name, company), password change · priority:med · owner:frontend · project:slancha · created:2026-03-29

### Marketing site improvements

- [ ] [TASK-014] Full QA pass on rebuilt site — verify new positioning, auth pages render, /login and /signup routes work, nav shows Sign in/Get Started · priority:high · owner:qa · project:slancha · created:2026-03-29
- [x] [TASK-015] Sync copy markdown files to match updated JSX (hero.md still has old eyebrow/subtitle) · priority:high · owner:copywriter · project:slancha · created:2026-03-29 · started:2026-03-29 · done:2026-03-29
- [ ] [TASK-016] Update design specs: 4-step How It Works, 4-tier offerings, new ValueProps section · priority:med · owner:designer · project:slancha · created:2026-03-29
- [ ] [TASK-009] QA audit all site copy — consistency, typos, broken links · priority:med · owner:qa · project:slancha · created:2026-03-29
- [ ] [TASK-012] Add Playwright smoke tests for homepage, nav, auth pages, and CTA buttons · priority:med · owner:qa · project:slancha · created:2026-03-29

### Lower priority

- [ ] [TASK-018] Add structured data (JSON-LD) for Organization and Product to index.html · priority:low · owner:frontend · project:slancha · created:2026-03-29
- [ ] [TASK-019] Add analytics tracking (Plausible or GA4) to site · priority:low · owner:frontend · project:slancha · created:2026-03-29
- [ ] [TASK-021] Add social proof section — testimonial placeholders or "trusted by" logos · priority:low · owner:designer · project:slancha · created:2026-03-29
- [ ] [TASK-022] Write blog-style content: "Why eval data should drive fine-tuning" · priority:low · owner:copywriter · project:slancha · created:2026-03-29

## Completed Tasks

- [x] [TASK-001] Install and configure Gastown multi-agent workspace manager · priority:high · owner:main · project:gastown · done:2026-03-29
- [x] [TASK-002] Build About page component · priority:high · owner:frontend · project:slancha · done:2026-03-29
- [x] [TASK-003] Build Features page component · priority:high · owner:frontend · project:slancha · done:2026-03-29
- [x] [TASK-004] Build Contact page with form · priority:high · owner:frontend · project:slancha · done:2026-03-29
- [x] [TASK-010] Design component specs for About, Features, Contact pages · priority:med · owner:designer · project:slancha · done:2026-03-29
- [x] [TASK-013] Positioning overhaul: update all components to eval→deploy→post-train messaging · priority:high · owner:claude-code · project:slancha · done:2026-03-29
- [x] [TASK-023] Phase 1 Auth: Supabase client, AuthContext, ProtectedRoute, all auth pages, App.jsx wiring, Nav auth · priority:high · owner:claude-code · project:slancha · done:2026-03-29
