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

- [ ] [TASK-014] Full QA pass on rebuilt site — verify all sections match new "Databricks of AI Engineering" positioning, no stale "latency-first" copy anywhere · priority:high · owner:qa · project:slancha · created:2026-03-29
- [ ] [TASK-015] Sync copy markdown files to match updated JSX (hero.md still has old eyebrow/subtitle) · priority:high · owner:copywriter · project:slancha · created:2026-03-29
- [ ] [TASK-016] Update design specs: 4-step How It Works, 4-tier offerings, new ValueProps section · priority:med · owner:designer · project:slancha · created:2026-03-29
- [ ] [TASK-008] Write copy for "How Slancha Compares" competitive positioning section · priority:med · owner:copywriter · project:slancha · created:2026-03-29
- [ ] [TASK-017] Create /pilot landing page — dedicated page for pilot program with qualification form · priority:med · owner:frontend · project:slancha · created:2026-03-29
- [ ] [TASK-018] Add structured data (JSON-LD) for Organization and Product to index.html · priority:med · owner:frontend · project:slancha · created:2026-03-29
- [ ] [TASK-019] Add analytics tracking (Plausible or GA4) to site · priority:med · owner:frontend · project:slancha · created:2026-03-29
- [ ] [TASK-012] Add Playwright smoke tests for homepage, nav, and CTA buttons · priority:med · owner:qa · project:slancha · created:2026-03-29
- [ ] [TASK-020] Performance audit — Lighthouse score, bundle size, image lazy loading · priority:low · owner:qa · project:slancha · created:2026-03-29
- [ ] [TASK-021] Add social proof section — testimonial placeholders or "trusted by" logos · priority:low · owner:designer · project:slancha · created:2026-03-29
- [ ] [TASK-009] QA audit all site copy — consistency, typos, broken links · priority:med · owner:qa · project:slancha · created:2026-03-29
- [ ] [TASK-011] Review and sharpen pilot-cta.md — make CTA more urgent and specific · priority:low · owner:copywriter · project:slancha · created:2026-03-29
- [ ] [TASK-022] Write blog-style content: "Why eval data should drive fine-tuning" · priority:low · owner:copywriter · project:slancha · created:2026-03-29
- [ ] [TASK-005] Add token count and session duration tracking to observability collector · priority:low · owner:frontend · project:observability · created:2026-03-29

## Completed Tasks

- [x] [TASK-001] Install and configure Gastown multi-agent workspace manager · priority:high · owner:main · project:gastown · done:2026-03-29
- [x] [TASK-002] Build About page component · priority:high · owner:frontend · project:slancha · done:2026-03-29
- [x] [TASK-003] Build Features page component · priority:high · owner:frontend · project:slancha · done:2026-03-29
- [x] [TASK-004] Build Contact page with form · priority:high · owner:frontend · project:slancha · done:2026-03-29
- [x] [TASK-010] Design component specs for About, Features, Contact pages · priority:med · owner:designer · project:slancha · done:2026-03-29
- [x] [TASK-013] Positioning overhaul: update all components to eval→deploy→post-train messaging · priority:high · owner:claude-code · project:slancha · done:2026-03-29
