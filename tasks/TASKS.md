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

### Sprint 8: Developer Experience, Conversion & Backend Readiness (2026-03-31)

- [ ] [TASK-141] Write SEO blog post: "vLLM in Production: The Complete Guide to High-Throughput LLM Serving" — PagedAttention, continuous batching, multi-LoRA, speculative decoding, production config, monitoring. Target keyword: "vLLM production guide" · priority:high · owner:claude-code · project:slancha · created:2026-03-31
- [ ] [TASK-142] Write blog post: "Building AI Agent Infrastructure: Why Your Agent Framework Needs a Smart Inference Layer" — agent architectures, tool use patterns, routing for agents, cost management. Target audience: teams building AI agents · priority:high · owner:copywriter · project:slancha · created:2026-03-31
- [ ] [TASK-143] Create Python SDK package stub — slancha PyPI package with typed client, chat completions, evals, deployments, fine-tuning methods. README with quickstart. Output to workspace-copywriter/docs/sdk-python-readme.md · priority:high · owner:copywriter · project:slancha · created:2026-03-31
- [ ] [TASK-144] Write TypeScript SDK README and quickstart — @slancha/sdk npm package docs with typed client examples, streaming, error handling. Output to workspace-copywriter/docs/sdk-typescript-readme.md · priority:med · owner:copywriter · project:slancha · created:2026-03-31
- [ ] [TASK-145] Create CLI documentation — slancha CLI tool usage guide: auth, eval runs, deployment management, dataset upload, log tailing. Output to workspace-copywriter/docs/cli-guide.md · priority:med · owner:copywriter · project:slancha · created:2026-03-31
- [ ] [TASK-146] Write competitive SEO blog post: "Slancha vs Fireworks AI: Optimization That Never Stops" — detailed comparison with cost analysis, architecture differences, migration guide · priority:med · owner:copywriter · project:slancha · created:2026-03-31
- [ ] [TASK-147] Update financial model for Series A readiness — include latest product metrics (25 blog posts, 60+ pages, dashboard shipped), runway scenarios with Stripe revenue projections. Output to workspace-finance/models/ · priority:med · owner:finance · project:slancha · created:2026-03-31
- [ ] [TASK-148] Design conversion funnel analytics spec — define key events (signup, first API call, first eval, upgrade), funnel stages, drop-off tracking. Output to workspace-strategist/docs/conversion-funnel.md · priority:high · owner:strategist · project:slancha · created:2026-03-31
- [ ] [TASK-149] Write API rate limiting & error handling guide — best practices for retry logic, exponential backoff, handling 429s, webhook reliability. Output to workspace-ops/docs/api-resilience-guide.md · priority:med · owner:ops · project:slancha · created:2026-03-31
- [ ] [TASK-150] Create enterprise sales deck — 8-slide version of pitch deck focused on security, compliance, deployment options, SLA, team management. Output to workspace-bizdev/sales/enterprise-deck-outline.md · priority:high · owner:bizdev · project:slancha · created:2026-03-31
- [ ] [TASK-151] QA all 25 blog posts — verify code examples syntax highlight correctly, internal links work, images load, meta tags present, mobile responsive. Use playwright plugin · priority:med · owner:qa · project:slancha · created:2026-03-31
- [ ] [TASK-152] Design SDK documentation page spec — layout for Python/TypeScript/cURL SDK docs with method reference, type definitions, code examples. Output to workspace-designer/specs/sdk-docs-spec.md · priority:med · owner:designer · project:slancha · created:2026-03-31

### Sprint 7: Revenue Wiring, Content Depth & Enterprise (2026-03-31)

- [ ] [TASK-123] Build Supabase usage tracking — insert request logs on API calls, aggregate daily/weekly/monthly, wire to Usage dashboard with real data · priority:high · owner:claude-code · project:slancha · created:2026-03-31
- [x] [TASK-124] Write SEO blog post: "How to Build a Self-Improving AI Pipeline (Eval → Fine-Tune → Deploy Loop)" — technical guide with code examples, architecture diagrams, Slancha's closed-loop approach · priority:high · owner:copywriter · project:slancha · created:2026-03-31 · started:2026-03-31 · done:2026-03-31
- [x] [TASK-125] Write blog post: "AI Inference Cost Optimization: A CFO's Guide to GPU Economics" — business audience, TCO breakdown, build vs buy analysis, ROI framework · priority:med · owner:copywriter · project:slancha · created:2026-03-31 · started:2026-03-31 · done:2026-03-31
- [ ] [TASK-126] Create Stripe product catalog — define Free/Starter/Growth/Enterprise products with price IDs, wire checkout flow to real Stripe products · priority:high · owner:claude-code · project:slancha · created:2026-03-31
- [x] [TASK-127] Write 3 customer success story drafts — fintech, healthtech, e-commerce verticals. Detailed scenarios with metrics, quotes, implementation timeline · priority:med · owner:copywriter · project:slancha · created:2026-03-31 · started:2026-03-31 · done:2026-03-31
- [x] [TASK-128] Design Team Management page polish — avatar upload, activity feed, audit log mockups · priority:med · owner:designer · project:slancha · created:2026-03-31 · started:2026-03-31 · done:2026-03-31
- [x] [TASK-129] QA full dashboard — test all 12 dashboard pages (Overview, Keys, Usage, Models, Evals, Fine-Tuning, Optimization, Logs, Billing, Webhooks, Team, Settings). Check responsive, interactions, empty states. Use playwright plugin · priority:high · owner:qa · project:slancha · created:2026-03-31 · started:2026-03-31 · done:2026-03-31
- [x] [TASK-130] Create investor data room checklist — docs needed for due diligence (cap table, financials, team bios, product metrics, legal). Output to workspace-finance/ · priority:med · owner:finance · project:slancha · created:2026-03-31 · started:2026-03-31 · done:2026-03-31
- [x] [TASK-131] Write partnership outreach templates — 5 email templates for cloud providers, model companies, and MLOps tool integrations · priority:med · owner:bizdev · project:slancha · created:2026-03-31 · started:2026-03-31 · done:2026-03-31
- [x] [TASK-132] Update GTM strategy for Q2 launch — incorporate learnings from pilot program design, refine conversion funnel, add channel-specific tactics · priority:med · owner:strategist · project:slancha · created:2026-03-31 · started:2026-03-31 · done:2026-03-31
- [x] [TASK-133] Write product screenshot descriptions — document 15 key dashboard screens with visual details, metrics, states (empty/loading/success). Output to workspace-designer/specs/product-screenshots.md · priority:high · owner:designer · project:slancha · created:2026-03-31 · started:2026-03-31 · done:2026-03-31
- [x] [TASK-134] Write video demo script — 3-minute async demo narrative for prospects who can't attend live. Story-driven: problem → solution → results. Include scene descriptions, voiceover text, visuals to show. Output to workspace-copywriter/docs/video-demo-script.md · priority:high · owner:copywriter · project:slancha · created:2026-03-31 · started:2026-03-31 · done:2026-03-31
- [x] [TASK-135] Build weekly pilot check-in template — structured agenda, progress questions, blocker identification, next-week commitments. Output to workspace-ops/processes/pilot-checkin-template.md · priority:med · owner:ops · project:slancha · created:2026-03-31 · started:2026-03-31 · done:2026-03-31
- [x] [TASK-136] Define success metrics for pilots — concrete KPIs for "working" (latency reduction, cost savings, accuracy improvement). Output measurable targets per ICP. Output to workspace-ops/processes/success-metrics.md · priority:med · owner:ops · project:slancha · created:2026-03-31 · started:2026-03-31 · done:2026-03-31
- [x] [TASK-137] Create pilot-to-paid conversion playbook — decision tree, pricing discussion triggers, legal review process, handoff criteria, common objections. Output to workspace-bizdev/playbooks/pilot-to-paid.md · priority:high · owner:bizdev · project:slancha · created:2026-03-31 · started:2026-03-31 · done:2026-03-31
- [x] [TASK-138] Write Q2 2026 content calendar — 8 blog post topics with publication dates, SEO keywords, target audience, status. Output to workspace-strategist/docs/content-calendar.md · priority:med · owner:strategist · project:slancha · created:2026-03-31 · done:2026-03-31
- [x] [TASK-139] Write data handling & privacy policy — what data we collect (API requests, eval data, user metadata), how we use it (improvement only, never train on customer data), retention (30 days), GDPR/CCPA rights, DPA template. Output to workspace-ops/docs/data-handling-policy.md · priority:high · owner:ops · project:slancha · created:2026-03-31 · started:2026-03-31 · done:2026-03-31
- [x] [TASK-140] Design pitch deck visual spec — 12-slide layout with master slide templates, color palette, typography, chart styles, animation notes. Output to workspace-designer/specs/pitch-deck-spec.md · priority:med · owner:designer · project:slancha · created:2026-03-31 · started:2026-03-31 · done:2026-03-31

### Sprint 6: Growth, Optimization & Launch Prep (2026-03-31)

- [x] [TASK-113] Write SEO blog post: "AI Inference Optimization: Complete Guide to QAT, MIG, and Multi-Token Prediction" — deep technical guide with benchmarks, code examples, and Slancha's approach. Use context7 plugin for latest NVIDIA docs · priority:high · owner:claude-code · project:slancha · created:2026-03-31 · done:2026-03-31
- [x] [TASK-114] Write blog post: "The Enterprise AI Inference Buyer's Guide 2026" — evaluation framework, vendor comparison, total cost of ownership, security requirements checklist · priority:high · owner:copywriter · project:slancha · created:2026-03-31 · started:2026-03-31 · done:2026-03-31
- [x] [TASK-115] Create 3 vertical landing pages (fintech, healthtech, e-commerce) — tailored messaging, use cases, compliance info, vertical-specific ROI. Use frontend-design plugin · priority:high · owner:claude-code · project:slancha · created:2026-03-31 · done:2026-03-31
- [x] [TASK-116] Build RSS feed auto-discovery — add <link rel="alternate" type="application/rss+xml"> to index.html, verify feed validates · priority:med · owner:claude-code · project:slancha · created:2026-03-31 · done:2026-03-31
- [x] [TASK-117] Write investor update template — monthly format covering key metrics, milestones, asks, team updates. Output to workspace-finance/templates/ · priority:med · owner:finance · project:slancha · created:2026-03-31 · started:2026-03-31 · done:2026-03-31
- [x] [TASK-118] Create product hunt launch strategy — listing copy, maker comment, first-day engagement plan, supporter outreach sequence. Output to workspace-bizdev/launch/ · priority:high · owner:bizdev · project:slancha · created:2026-03-31 · started:2026-03-31 · done:2026-03-31
- [x] [TASK-119] Write developer community strategy — Discord/Slack plan, documentation contribution guide, early adopter program, feedback loop design. Output to workspace-ops/community/ · priority:med · owner:ops · project:slancha · created:2026-03-31 · started:2026-03-31 · done:2026-03-31
- [x] [TASK-120] Update competitive landscape with latest moves from OpenRouter, Fireworks, and BaseTen (March 2026). Output to workspace-strategist/docs/ · priority:med · owner:strategist · project:slancha · created:2026-03-31 · done:2026-03-31
- [x] [TASK-121] Design vertical landing page specs — layout, component hierarchy, responsive breakpoints for fintech/healthtech/e-commerce verticals. Use frontend-design plugin · priority:med · owner:designer · project:slancha · created:2026-03-31 · started:2026-03-31 · done:2026-03-31
- [x] [TASK-122] QA all blog posts — verify links, code examples render, mobile responsive, meta tags present on all 16 posts. Use playwright plugin · priority:med · owner:qa · project:slancha · created:2026-03-31 · started:2026-03-31 · done:2026-03-31

### Sprint 5: Revenue, Content & Polish (2026-03-31)

- [x] [TASK-103] Build API Keys backend: wire Supabase table for api_keys (create, revoke, list), connect dashboard ApiKeys component to real data · priority:high · owner:claude-code · project:slancha · created:2026-03-31
- [x] [TASK-104] Write blog post: "Zero-Config AI Inference: Why the Black Box Wins" — positioning piece on why teams shouldn't pick models · priority:high · owner:copywriter · project:slancha · created:2026-03-31 · started:2026-03-31 · done:2026-03-31
- [x] [TASK-105] Write blog post: "Slancha vs OpenRouter: Beyond the Model Marketplace" — detailed comparison with code examples, cost analysis, migration guide, architecture diagrams · priority:med · owner:claude-code · project:slancha · created:2026-03-31
- [x] [TASK-106] Build interactive pricing comparison calculator: input monthly API spend, show savings across tiers vs. competitors · priority:med · owner:claude-code · project:slancha · created:2026-03-31 · done:2026-03-31
- [x] [TASK-107] Write case study template: "How [Company Type] Reduced Inference Costs by X%" — 3 vertical-specific versions (fintech, healthtech, e-commerce) · priority:med · owner:copywriter · project:slancha · created:2026-03-31 · started:2026-03-31 · done:2026-03-31
- [x] [TASK-108] Create launch announcement blog post draft — product story, key features, what's different, early access CTA · priority:high · owner:copywriter · project:slancha · created:2026-03-31 · started:2026-03-31 · done:2026-03-31
- [x] [TASK-109] Design OG image / social card for Twitter/LinkedIn sharing — dark theme, Slancha logo, tagline · priority:med · owner:designer · project:slancha · created:2026-03-31 · started:2026-03-31 · done:2026-03-31
- [x] [TASK-110] Write 5 Twitter/X thread scripts for launch week — each covering a different angle (cost savings, black box approach, eval loop, migration ease, vs. competitors) · priority:med · owner:bizdev · project:slancha · created:2026-03-31 · started:2026-03-31 · done:2026-03-31
- [x] [TASK-111] Update financial model with latest pricing tiers and projected conversion rates from waitlist · priority:med · owner:finance · project:slancha · created:2026-03-31 · done:2026-03-31 (validated: all models already updated with $299/$999 pricing per pricing-analysis.md (2026-03-30) and investor FAQ (2026-03-31))
- [x] [TASK-112] Create onboarding flow wireframes: post-signup experience from dashboard to first API call · priority:med · owner:designer · project:slancha · created:2026-03-31 · started:2026-03-31 · done:2026-03-31

### Infrastructure & Security

- [ ] [TASK-101] Investigate GitHub OAuth security alert — third-party app added to account (Mar 29), verify legitimacy or revoke unauthorized access · priority:high · owner:claw · project:infrastructure · created:2026-03-31
- [ ] [TASK-102] Reactivate Claude API access — API turned off per Anthropic emails (Mar 23 & Mar 26-27), contact support or adjust settings · priority:high · owner:claw · project:infrastructure · created:2026-03-31

### Sprint 4: Launch Readiness & Conversion (2026-03-31)

- [x] [TASK-099] Build Migration Guide docs page: step-by-step migration from OpenAI, Anthropic, Portkey, OpenRouter, Fireworks, Not Diamond with code examples, framework integration (LangChain, LlamaIndex, Vercel AI SDK), verification checklist · priority:high · owner:claude-code · project:slancha · created:2026-03-31 · done:2026-03-31
- [x] [TASK-098] Build Status page: system health dashboard with 8 components, 90-day uptime bars, incident timeline, notification options · priority:high · owner:claude-code · project:slancha · created:2026-03-31 · done:2026-03-31
- [x] [TASK-090] Build Demo page: interactive product walkthrough with 5 steps (signup, first eval, route deployment, fine-tuning, metrics dashboard), side navigation, code panels, metric cards · priority:high · owner:claude-code · project:slancha · created:2026-03-31 · done:2026-03-31
- [x] [TASK-091] Write Demo walkthrough script — step-by-step talking points for sales demos (5 steps: signup, eval, route, fine-tune, metrics), what problem each solves, demo flow timing · priority:med · owner:copywriter · project:slancha · created:2026-03-31 · done:2026-03-31
- [x] [TASK-092] Write Customer Welcome Email Sequence (5 emails) — onboarding series for pilot signups: day 1 welcome + setup, day 3 quick win, day 7 first eval, day 14 deployment, day 21 upgrade prompt · priority:med · owner:copywriter · project:slancha · created:2026-03-31 · done:2026-03-31
- [x] [TASK-093] Design Demo Flow Spec — user journey map for demo page, wireframes for each step, microinteractions, transition animations, responsive breakpoints · priority:med · owner:designer · project:slancha · created:2026-03-31 · started:2026-03-31 · done:2026-03-31
- [x] [TASK-094] Build Pilot Onboarding Checklist — day 1, week 1, month 1 timeline with specific actions, resources needed, success metrics, handoff criteria to paid · priority:med · owner:ops · project:slancha · created:2026-03-31 · started:2026-03-31 · done:2026-03-31
- [x] [TASK-095] Create Sales Battlecards (top 5 competitors) — concise 1-pager for Arize AI, WhyLabs, Evidently, Hugging Face, Modal: their weakness, Slancha's wedge, objection handlers · priority:med · owner:bizdev · project:slancha · created:2026-03-31 · started:2026-03-31 · done:2026-03-31
- [x] [TASK-096] Write Security Whitepaper Outline — data isolation architecture, encryption at rest/in transit, SOC 2 readiness status, compliance FAQ for enterprise prospects · priority:med · owner:ops · project:slancha · created:2026-03-31 · done:2026-03-31 (completed via TASK-068: SOC 2 readiness checklist created)
- [x] [TASK-097] Build ROI Calculator — spreadsheet or interactive component showing cost savings vs. building in-house, vs. competitors, TCO calculator for 3 scenarios · priority:med · owner:claude-code · project:slancha · created:2026-03-31 · done:2026-03-31 (already built: interactive page with sliders, model selection, API cost + engineering cost comparison)
- [x] [TASK-060] Write blog post: "5 Signs Your ML Team Needs an Evaluation Platform" · priority:high · owner:copywriter · project:slancha · created:2026-03-31 · done:2026-03-30
- [x] [TASK-061] Write blog post: "How Eval Data Should Drive Fine-Tuning (Technical Deep Dive)" · priority:high · owner:claude-code · project:slancha · created:2026-03-31 · done:2026-03-31
- [x] [TASK-062] Write developer quickstart guide for docs: install SDK, run first eval, deploy model · priority:high · owner:claude-code · project:slancha · created:2026-03-31 · done:2026-03-30
- [x] [TASK-070] Add Post-Training Guide docs page (eval-driven training, fine-tuning, auto-promote pipeline) · priority:high · owner:claude-code · project:slancha · done:2026-03-30
- [x] [TASK-071] Add SDKs & Libraries docs page (Python, TypeScript, OpenAI compat, cURL) · priority:high · owner:claude-code · project:slancha · done:2026-03-30
- [x] [TASK-073] Expand API Reference: full docs for evaluations, deployments, fine-tuning, datasets, router, webhooks (6 new API sections, 549 lines) · priority:high · owner:claude-code · project:slancha · done:2026-03-30
- [x] [TASK-063] Design Use Cases page visual polish: segment icons, metric animations, testimonial slots · priority:med · owner:designer · project:slancha · created:2026-03-31 · started:2026-03-31 · done:2026-03-31
- [x] [TASK-089] Fix QA bug: add TierCards/Offerings section to homepage (was missing from Home.jsx) · priority:high · owner:claude-code · project:slancha · done:2026-03-31
- [x] [TASK-064] QA full site: test all pages, nav links, auth flow, responsive breakpoints, lighthouse scores · priority:high · owner:qa · project:slancha · created:2026-03-31 · started:2026-03-31 · done:2026-03-31
- [x] [TASK-065] Build case study template page component · priority:med · owner:frontend · project:slancha · created:2026-03-31 · done:2026-03-30 (already built with 3 case studies)
- [x] [TASK-074] Build Changelog page: 7 releases from v0.8 to v1.4, timeline UI, version tags, footer link · priority:high · owner:claude-code · project:slancha · done:2026-03-30
- [x] [TASK-067] Create investor FAQ document: top 20 questions VCs will ask, with data-backed answers · priority:high · owner:finance · project:slancha · created:2026-03-31 · started:2026-03-31 · done:2026-03-31
- [x] [TASK-068] Write SOC 2 readiness checklist and security whitepaper outline · priority:med · owner:ops · project:slancha · created:2026-03-31 · started:2026-03-31 · done:2026-03-31
- [x] [TASK-069] Draft 3 LinkedIn posts for founder launch sequence · priority:med · owner:bizdev · project:slancha · created:2026-03-31 · started:2026-03-31 · done:2026-03-31
- [x] [TASK-072] Build Integrations page: 31 integrations across 6 categories with badges, wired into nav/router · priority:high · owner:claude-code · project:slancha · done:2026-03-30
- [x] [TASK-075] Build API Playground: interactive demo page with 5 endpoints (route, eval, deploy, fine-tune, dataset), animated response typing, nav/router · priority:high · owner:claude-code · project:slancha · done:2026-03-30
- [x] [TASK-076] Build Enterprise page: deployment options (cloud/VPC/on-prem), security & compliance (SOC2/HIPAA/GDPR), SLA guarantees, team mgmt, nav/router/footer · priority:high · owner:claude-code · project:slancha · done:2026-03-30

### Sprint 4: Launch Readiness & Conversion (2026-03-30)

- [x] [TASK-077] SEO: expand sitemap.xml from 2 to 30 URLs, update robots.txt to block auth/dashboard · priority:high · owner:claude-code · project:slancha · done:2026-03-30
- [x] [TASK-078] Write blog post: "Building a Production AI Inference Router: Architecture Patterns" · priority:high · owner:claude-code · project:slancha · created:2026-03-30 · done:2026-03-30
- [x] [TASK-079] Add page-level meta descriptions via usePageMeta hook on all pages · priority:high · owner:claude-code · project:slancha · created:2026-03-30 · done:2026-03-30
- [x] [TASK-080] Write blog post: "From Prototype to Production: The AI Deployment Checklist" · priority:med · owner:copywriter · project:slancha · created:2026-03-30 · done:2026-03-31
- [x] [TASK-081] Create pitch deck slides (Markdown/HTML) from strategist outline · priority:high · owner:claude-code · project:slancha · created:2026-03-30 · done:2026-03-30
- [x] [TASK-082] Update financial projections with latest pricing model changes · priority:med · owner:finance · project:slancha · created:2026-03-30 · done:2026-03-31
- [x] [TASK-083] Write "Slancha vs. Databricks" detailed comparison blog post · priority:med · owner:copywriter · project:slancha · created:2026-03-30 · done:2026-03-31
- [x] [TASK-088] Integrate copywriter blog posts into site: "Slancha vs Databricks" + "AI Deployment Checklist" · priority:high · owner:claude-code · project:slancha · done:2026-03-31
- [x] [TASK-084] Design email templates for launch announcement sequence · priority:med · owner:designer · project:slancha · created:2026-03-30 · done:2026-03-31
- [x] [TASK-085] Build email capture / waitlist component for homepage · priority:high · owner:claude-code · project:slancha · created:2026-03-30 · done:2026-03-30
- [x] [TASK-086] Performance audit: lazy load all route components, optimize bundle size · priority:med · owner:claude-code · project:slancha · created:2026-03-30 · done:2026-03-30
- [x] [TASK-087] Build Terms of Service and Privacy Policy pages — launch-required legal pages with GDPR/CCPA, data handling, API terms. Wired into router + footer. · priority:high · owner:claude-code · project:slancha · created:2026-03-30 · done:2026-03-30

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
- [x] [TASK-121] Design vertical landing page specs — layout, component hierarchy, responsive breakpoints for fintech/healthtech/e-commerce verticals. Use frontend-design plugin · priority:med · owner:designer · project:slancha · created:2026-03-31 · started:2026-03-31 · done:2026-03-31
- [x] [TASK-066] Update competitive landscape with Q2 2026 funding rounds and product launches · priority:med · owner:strategist · project:slancha · created:2026-03-31 · started:2026-03-31 · done:2026-03-31
- [x] [TASK-001] Install and configure Gastown multi-agent workspace manager · priority:high · owner:main · project:gastown · done:2026-03-29
- [x] [TASK-002] Build About page component · priority:high · owner:frontend · project:slancha · done:2026-03-29
- [x] [TASK-003] Build Features page component · priority:high · owner:frontend · project:slancha · done:2026-03-29
- [x] [TASK-004] Build Contact page with form · priority:high · owner:frontend · project:slancha · done:2026-03-29
- [x] [TASK-010] Design component specs for About, Features, Contact pages · priority:med · owner:designer · project:slancha · done:2026-03-29
- [x] [TASK-013] Positioning overhaul: update all components to eval→deploy→post-train messaging · priority:high · owner:claude-code · project:slancha · done:2026-03-29
- [x] [TASK-023] Phase 1 Auth: Supabase client, AuthContext, ProtectedRoute, all auth pages, App.jsx wiring, Nav auth · priority:high · owner:claude-code · project:slancha · done:2026-03-29

- [x] [TASK-100] Wire up contact form to actually send — Formspree integration as primary handler (delivers email to contact@slancha.ai), Supabase insert for records, mailto fallback. Added VITE_FORMSPREE_ID to .env.example. · priority:high · owner:claude-code · project:slancha · created:2026-03-31 · done:2026-03-31
