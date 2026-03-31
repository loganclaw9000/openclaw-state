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

### Sprint 3: Content Depth & Conversion Optimization (2026-03-31)

- [x] [TASK-060] Write blog post: "5 Signs Your ML Team Needs an Evaluation Platform" · priority:high · owner:copywriter · project:slancha · created:2026-03-31 · done:2026-03-30
- [x] [TASK-061] Write blog post: "How Eval Data Should Drive Fine-Tuning (Technical Deep Dive)" · priority:high · owner:claude-code · project:slancha · created:2026-03-31 · done:2026-03-31
- [x] [TASK-062] Write developer quickstart guide for docs: install SDK, run first eval, deploy model · priority:high · owner:claude-code · project:slancha · created:2026-03-31 · done:2026-03-30
- [x] [TASK-070] Add Post-Training Guide docs page (eval-driven training, fine-tuning, auto-promote pipeline) · priority:high · owner:claude-code · project:slancha · done:2026-03-30
- [x] [TASK-071] Add SDKs & Libraries docs page (Python, TypeScript, OpenAI compat, cURL) · priority:high · owner:claude-code · project:slancha · done:2026-03-30
- [x] [TASK-073] Expand API Reference: full docs for evaluations, deployments, fine-tuning, datasets, router, webhooks (6 new API sections, 549 lines) · priority:high · owner:claude-code · project:slancha · done:2026-03-30
- [ ] [TASK-063] Design Use Cases page visual polish: segment icons, metric animations, testimonial slots · priority:med · owner:designer · project:slancha · created:2026-03-31
- [ ] [TASK-064] QA full site: test all pages, nav links, auth flow, responsive breakpoints, lighthouse scores · priority:high · owner:qa · project:slancha · created:2026-03-31
- [x] [TASK-065] Build case study template page component · priority:med · owner:frontend · project:slancha · created:2026-03-31 · done:2026-03-30 (already built with 3 case studies)
- [x] [TASK-074] Build Changelog page: 7 releases from v0.8 to v1.4, timeline UI, version tags, footer link · priority:high · owner:claude-code · project:slancha · done:2026-03-30
- [x] [TASK-067] Create investor FAQ document: top 20 questions VCs will ask, with data-backed answers · priority:high · owner:finance · project:slancha · created:2026-03-31 · started:2026-03-31 · done:2026-03-31
- [ ] [TASK-068] Write SOC 2 readiness checklist and security whitepaper outline · priority:med · owner:ops · project:slancha · created:2026-03-31
- [ ] [TASK-069] Draft 3 LinkedIn posts for founder launch sequence · priority:med · owner:bizdev · project:slancha · created:2026-03-31
- [x] [TASK-072] Build Integrations page: 31 integrations across 6 categories with badges, wired into nav/router · priority:high · owner:claude-code · project:slancha · done:2026-03-30
- [x] [TASK-075] Build API Playground: interactive demo page with 5 endpoints (route, eval, deploy, fine-tune, dataset), animated response typing, nav/router · priority:high · owner:claude-code · project:slancha · done:2026-03-30
- [x] [TASK-076] Build Enterprise page: deployment options (cloud/VPC/on-prem), security & compliance (SOC2/HIPAA/GDPR), SLA guarantees, team mgmt, nav/router/footer · priority:high · owner:claude-code · project:slancha · done:2026-03-30

### Previous sprint (completed)

- [x] [TASK-058] Build FAQ page with accordion component · priority:low · owner:frontend · project:slancha · created:2026-03-31 · started:2026-03-31 · done:2026-03-31
- [x] [TASK-059] Build Vs. Competitors comparison page with feature table · priority:low · owner:frontend · project:slancha · created:2026-03-31 · started:2026-03-31 · done:2026-03-31

### Phase 2: Dashboard (HIGH PRIORITY — auth foundation is shipped)

- [x] [TASK-030] Design dashboard layout specs · priority:high · owner:claude-code · project:slancha · done:2026-03-29
- [x] [TASK-031] Write all dashboard copy · priority:high · owner:copywriter · project:slancha · started:2026-03-29 · started:2026-03-30 · done:2026-03-30
- [x] [TASK-032] Build Dashboard shell (DashboardNav + Sidebar + Outlet) · priority:high · owner:claude-code · project:slancha · done:2026-03-29
- [x] [TASK-033] Build EmptyState component (inline in Overview/Usage) · priority:med · owner:claude-code · project:slancha · done:2026-03-29
- [x] [TASK-034] Build ApiKeys dashboard component · priority:high · owner:claude-code · project:slancha · done:2026-03-29
- [x] [TASK-035] Build UsageStats dashboard component · priority:med · owner:claude-code · project:slancha · done:2026-03-29
- [x] [TASK-036] Build Overview dashboard component · priority:med · owner:claude-code · project:slancha · done:2026-03-29
- [x] [TASK-037] Build AccountSettings dashboard component · priority:med · owner:claude-code · project:slancha · done:2026-03-29

### Marketing site improvements

- [x] [TASK-014] Full QA pass on rebuilt site — build passes, no stale copy, all auth/dashboard routes wired, nav auth states correct · priority:high · owner:claude-code · project:slancha · done:2026-03-30
- [x] [TASK-015] Sync copy markdown files to match updated JSX (hero.md still has old eyebrow/subtitle) · priority:high · owner:copywriter · project:slancha · created:2026-03-29 · started:2026-03-29 · done:2026-03-29
- [x] [TASK-016] Update design specs: 4-step How It Works, 4-tier offerings, new ValueProps section · priority:med · owner:ops · project:slancha · created:2026-03-29 · started:2026-03-30 · done:2026-03-30
- [x] [TASK-009] QA audit all site copy — consistency, typos, broken links · priority:med · owner:bizdev · project:slancha · created:2026-03-29 · started:2026-03-30 · done:2026-03-30
- [x] [TASK-012] Add Playwright smoke tests for homepage, nav, auth pages, and CTA buttons · priority:med · owner:bizdev · project:slancha · started:2026-03-30 · done:2026-03-30

### Business Team — Sprint 1 (new agents: strategist, finance, ops, bizdev)

- [x] [TASK-040] Competitive landscape map: identify top 15 competitors, categorize by segment (inference platforms, MLOps, training platforms, full-stack). For each: funding, pricing, key differentiator, weakness Slancha exploits. Output to workspace-strategist/docs/competitive-landscape.md · priority:high · owner:strategist · project:slancha · created:2026-03-29 · completed:2026-03-29
- [x] [TASK-041] TAM/SAM/SOM analysis: size the AI inference market, the eval+deploy segment, and Slancha's serviceable market. Include methodology and data sources. Output to workspace-strategist/docs/market-sizing.md · priority:high · owner:strategist · project:slancha · created:2026-03-29 · completed:2026-03-29
- [x] [TASK-042] GTM strategy brief: define the PLG-to-sales-led motion. Who signs up for the free router? What triggers upgrade? What's the enterprise entry point? Include conversion funnel assumptions. Output to workspace-strategist/docs/gtm-strategy.md · priority:high · owner:strategist · project:slancha · created:2026-03-29 · completed:2026-03-29
- [x] [TASK-043] Unit economics model: model CAC, LTV, payback period for each tier. Include infrastructure cost assumptions (GPU compute per request, Supabase costs, bandwidth). Output to workspace-finance/models/unit-economics.md · priority:high · owner:finance · project:slancha · created:2026-03-29 · done:2026-03-29
- [x] [TASK-044] 18-month financial projection: revenue ramp, headcount plan, burn rate, runway. Bull/base/bear scenarios. Output to workspace-finance/models/financial-projection.md · priority:high · owner:finance · project:slancha · created:2026-03-29 · done:2026-03-29
- [x] [TASK-045] Pricing strategy analysis: benchmark Slancha's tiers against competitors (Databricks, Together, Anyscale, Modal pricing pages). Recommend pricing adjustments. Output to workspace-finance/analysis/pricing-analysis.md · priority:med · owner:finance · project:slancha · created:2026-03-29 · started:2026-03-30 · done:2026-03-30
- [x] [TASK-046] First 10 hires plan: role sequencing, JD outlines, compensation benchmarks, timeline. What do you hire before product-market fit vs after? Output to workspace-ops/hiring/first-10-hires.md · priority:high · owner:ops · project:slancha · created:2026-03-29 · started:2026-03-29 · done:2026-03-29
- [x] [TASK-047] Pilot program operations design: what's included in a pilot, how long, success metrics, handoff to paid, support model. Output to workspace-ops/processes/pilot-program.md · priority:high · owner:ops · project:slancha · created:2026-03-29 · started:2026-03-29 · done:2026-03-29
- [x] [TASK-048] OKRs for Q2 2026: company-level objectives and key results for launch quarter. Include metrics, owners, targets. Output to workspace-ops/plans/q2-2026-okrs.md · priority:med · owner:ops · project:slancha · created:2026-03-29 · started:2026-03-29 · done:2026-03-29
- [x] [TASK-049] ICP definition and target account list: define 3 ideal customer profiles with firmographic + technographic criteria. List 20 specific target companies per ICP. Output to workspace-bizdev/playbooks/icp-target-accounts.md · priority:high · owner:bizdev · project:slancha · created:2026-03-29 · started:2026-03-29 · done:2026-03-29
- [x] [TASK-050] Outbound email sequence: 3-email cold outreach sequence for each ICP. Include subject lines, body copy, CTAs, follow-up timing. Output to workspace-bizdev/outbound/cold-sequences.md · priority:high · owner:bizdev · project:slancha · created:2026-03-29 · started:2026-03-29 · done:2026-03-29
- [x] [TASK-051] Partnership target brief: identify top 10 strategic partnership opportunities (cloud providers, model companies, MLOps tools). For each: partnership type, mutual value, contact strategy. Output to workspace-bizdev/partnerships/partnership-targets.md · priority:med · owner:bizdev · project:slancha · created:2026-03-29 · started:2026-03-29 · done:2026-03-29
- [x] [TASK-052] Pitch deck outline: 12-slide structure for seed/Series A deck. Include slide titles, key message per slide, data points needed. Output to workspace-strategist/docs/pitch-deck-outline.md · priority:med · owner:strategist · project:slancha · created:2026-03-29 · completed:2026-03-29

### Lower priority

- [x] [TASK-056] Design FAQ page spec with accordion layout · priority:low · owner:designer · project:slancha · created:2026-03-31 · started:2026-03-31 · started:2026-03-30 · done:2026-03-31
- [x] [TASK-057] Design "Vs. Competitors" comparison page spec with feature table · priority:low · owner:designer · project:slancha · created:2026-03-31 · started:2026-03-31 · started:2026-03-30 · done:2026-03-31
- [x] [TASK-018] Add JSON-LD structured data (Organization + SoftwareApplication) to index.html · priority:low · owner:claude-code · project:slancha · done:2026-03-30
- [x] [TASK-019] Add Plausible analytics tracking to site · priority:low · owner:claude-code · project:slancha · done:2026-03-30
- [x] [TASK-021] Add social proof section — testimonial placeholders or "trusted by" logos · priority:low · owner:designer · project:slancha · created:2026-03-29 · started:2026-03-30 · done:2026-03-30
- [x] [TASK-054] Build SocialProof component with logo grid and testimonial carousel · priority:low · owner:frontend · project:slancha · created:2026-03-30 · started:2026-03-30 · done:2026-03-30
- [x] [TASK-022] Write blog-style content: "Why eval data should drive fine-tuning" · priority:low · owner:copywriter · project:slancha · created:2026-03-29 · started:2026-03-29 · done:2026-03-29

## Completed Tasks

- [x] [TASK-053] Update outbound sequences with new pricing model · priority:high · owner:bizdev · project:slancha · created:2026-03-30 · started:2026-03-30 · done:2026-03-30

### New Features to QA

- [x] [TASK-055] QA new pricing and checkout feature: test pricing page, checkout success/cancel, billing dashboard · priority:high · owner:qa · project:slancha · created:2026-03-31 · started:2026-03-31 · done:2026-03-31

## Completed Tasks
- [x] [TASK-066] Update competitive landscape with Q2 2026 funding rounds and product launches · priority:med · owner:strategist · project:slancha · created:2026-03-31 · started:2026-03-31 · done:2026-03-31
- [x] [TASK-001] Install and configure Gastown multi-agent workspace manager · priority:high · owner:main · project:gastown · done:2026-03-29
- [x] [TASK-002] Build About page component · priority:high · owner:frontend · project:slancha · done:2026-03-29
- [x] [TASK-003] Build Features page component · priority:high · owner:frontend · project:slancha · done:2026-03-29
- [x] [TASK-004] Build Contact page with form · priority:high · owner:frontend · project:slancha · done:2026-03-29
- [x] [TASK-010] Design component specs for About, Features, Contact pages · priority:med · owner:designer · project:slancha · done:2026-03-29
- [x] [TASK-013] Positioning overhaul: update all components to eval→deploy→post-train messaging · priority:high · owner:claude-code · project:slancha · done:2026-03-29
- [x] [TASK-023] Phase 1 Auth: Supabase client, AuthContext, ProtectedRoute, all auth pages, App.jsx wiring, Nav auth · priority:high · owner:claude-code · project:slancha · done:2026-03-29
