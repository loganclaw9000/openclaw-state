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

### Sprint 12: vLLM Semantic Router Frontend (2026-03-31)

**CONTEXT:** Supabase schema is DONE (tables: llm_providers, router_models, model_backends, routing_decisions, router_config_snapshots — all with RLS + vault RPCs for API key encryption). DO NOT re-run migrations. Build the frontend.

**Reference docs:** https://docs.vllm.ai/projects/production-stack/en/latest/use_cases/semantic-router-integration.html
**Config schema reference:** https://github.com/vllm-project/semantic-router/blob/main/config/config.yaml
**Plan file:** ~/.claude/plans/dazzling-sprouting-snowflake.md

#### Phase 2: Provider Management UI
- [x] [TASK-174] Create `src/utils/providerPresets.js` — static presets for OpenAI (base_url: api.openai.com/v1), Anthropic (api.anthropic.com), vLLM Local (127.0.0.1:8000), Mistral (api.mistral.ai/v1), Google (generativelanguage.googleapis.com), Custom. Each preset has: name, provider_type, base_url, api_format, logo/icon suggestion, default models list. · priority:high · owner:claude-code · project:slancha · created:2026-03-31
- [x] [TASK-175] Create `src/hooks/useProviders.js` — CRUD hook for llm_providers table. Follow useApiKeys.js pattern exactly (Supabase + local fallback). Methods: fetchProviders, createProvider, updateProvider, deleteProvider, toggleEnabled. On createProvider: insert row first, then call `supabase.rpc('store_provider_api_key', {p_provider_id, p_api_key})` to vault the key. Never fetch/return the actual API key. Return api_key_last4 for display. · priority:high · owner:claude-code · project:slancha · created:2026-03-31
- [x] [TASK-176] Create `src/components/dashboard/ProviderCard.jsx` + `ProviderForm.jsx` — ProviderCard: displays provider name, type icon, enabled toggle, key status (masked ••••{last4} or "No key"), edit/delete buttons. Glass-morphism card style matching existing dashboard. ProviderForm: modal with preset selector dropdown (auto-fills base_url + api_format), name input, API key input (password field), base_url override. Use .dash-* CSS class naming. · priority:high · owner:claude-code · project:slancha · created:2026-03-31

#### Phase 3: Model Configuration UI
- [x] [TASK-177] Create `src/hooks/useRouterModels.js` — CRUD hook for router_models + model_backends tables. Follow useWebhooks.js pattern. Methods: fetchModels (join with model_backends), createModel, updateModel, deleteModel, addBackend, removeBackend, updateBackendWeight. · priority:high · owner:claude-code · project:slancha · created:2026-03-31
- [x] [TASK-178] Create `src/components/dashboard/ModelConfig.jsx` — model list with: name, provider_model_id, pricing display, capabilities tags, default badge. Each model expands to show backend assignments (dropdown of enabled providers), weight sliders (0-100). "+ Add Model" form. Follow ModelsRouting.jsx styling patterns. · priority:high · owner:claude-code · project:slancha · created:2026-03-31

#### Phase 4: Routing Decisions UI
- [x] [TASK-179] Create `src/hooks/useRoutingDecisions.js` — CRUD hook for routing_decisions table. Methods: fetchDecisions, createDecision, updateDecision, deleteDecision, toggleEnabled, reorderPriority. · priority:high · owner:claude-code · project:slancha · created:2026-03-31
- [x] [TASK-180] Create `src/components/dashboard/RoutingRules.jsx` — decision card list ordered by priority. Each card shows: name, description, domain conditions (pills), assigned model refs, enabled toggle, system prompt preview. "+ Add Rule" form with: domain condition selector (math, code, business, law, creative, health, science, general), model ref dropdown (from user's configured models), optional system prompt textarea, reasoning toggle, priority input. · priority:high · owner:claude-code · project:slancha · created:2026-03-31

#### Phase 5: Config Generation & Minikube Export
- [x] [TASK-181] Create `src/utils/generateRouterYaml.js` — pure function: (providers, models, backends, decisions) → valid vLLM semantic router YAML string. Must match the config.yaml schema from vllm-project/semantic-router. Local providers → endpoint field. Remote providers → base_url + provider field. API keys referenced as env vars (SLANCHA_{PROVIDER_TYPE}_API_KEY), never embedded. Include listeners, providers.defaults, providers.models with backend_refs, routing.decisions with rules/modelRefs/plugins. Use js-yaml for serialization. · priority:high · owner:claude-code · project:slancha · created:2026-03-31
- [x] [TASK-182] Create `src/components/dashboard/ConfigPreview.jsx` — live YAML preview panel (read-only <pre> with syntax highlighting). "Copy YAML" button, "Save Snapshot" button (writes to router_config_snapshots table), snapshot history list. Also create `src/hooks/useRouterConfig.js` to orchestrate useProviders + useRouterModels + useRoutingDecisions → generateRouterYaml. · priority:high · owner:claude-code · project:slancha · created:2026-03-31
- [x] [TASK-183] Create `src/utils/generateMinikubeBundle.js` + `src/components/dashboard/MinikubeGuide.jsx` — generateMinikubeBundle: uses JSZip to create client-side ZIP containing config.yaml, .env.template (with SLANCHA_*_API_KEY placeholders), k8s/deployment.yaml, k8s/service.yaml, k8s/configmap.yaml, k8s/secret.yaml (referencing .env vars), and README.md with step-by-step: minikube start, helm install vllm-stack, helm install semantic-router, port-forward, curl test. MinikubeGuide: collapsible instructions + "Export Bundle" download button. · priority:high · owner:claude-code · project:slancha · created:2026-03-31

#### Phase 6: Main Page Integration
- [x] [TASK-184] Create `src/components/dashboard/SemanticRouter.jsx` + `SemanticRouter.css` — main tabbed page with 4 tabs: Providers, Models, Routing, Config & Deploy. Each tab renders the components from phases 2-5. Follow ModelsRouting.jsx tab pattern. Add page title "Semantic Router" with subtitle "Configure LLM providers, models, and intelligent routing". usePageMeta for SEO. Add to App.jsx as lazy import: `const SemanticRouter = lazy(() => import('./components/dashboard/SemanticRouter'))` with route path="router". Add "Semantic Router" NavLink to Sidebar.jsx after existing "Models & Routing" link. Install deps: `npm install js-yaml jszip file-saver`. · priority:high · owner:claude-code · project:slancha · created:2026-03-31

#### Phase 7: Polish
- [x] [TASK-185] Add demo data fallback to all Semantic Router hooks — when Supabase not configured, show 3 demo providers (OpenAI, Anthropic, Local vLLM), 4 demo models, 3 demo routing decisions. Match the isSupabaseConfigured() pattern from useApiKeys.js. Show banner: "Demo data — connect Supabase to configure real providers". Add empty states for each tab. Verify responsive layout, a11y (focus-visible, sr-only labels), and that build passes. · priority:med · owner:claude-code · project:slancha · created:2026-03-31

### Sprint 11: Supabase Dashboard Plumbing (2026-03-31)

**NOTE:** Use the Supabase MCP tools (mcp__supabase__*) for all schema/migration work. The MCP is configured in `~/.openclaw/.mcp.json`.

#### Phase 1: Schema & Migrations (do first — all other tasks depend on these tables)
- [x] [TASK-164] Create `request_logs` table via Supabase MCP — columns: id, user_id, endpoint, model, tokens_in, tokens_out, latency_ms, cost_cents, status_code, created_at. Add RLS policy for user isolation. Use `mcp__supabase__apply_migration`. Wire RequestLogs.jsx to query this table instead of DEMO_LOGS. · priority:high · owner:claude-code · project:slancha · created:2026-03-31
- [x] [TASK-165] Create `fine_tuning_jobs` table via Supabase MCP — columns: id, user_id, name, base_model, dataset_id, status (queued/training/completed/failed), progress_pct, training_loss, eval_accuracy, epochs, created_at, completed_at. RLS by user_id. Use `mcp__supabase__apply_migration`. Wire FineTuning.jsx to replace FT_JOBS hardcoded data. · priority:high · owner:claude-code · project:slancha · created:2026-03-31
- [x] [TASK-166] Create `deployments` table via Supabase MCP — columns: id, user_id, name, model, version, status (active/canary/rolling/stopped), region, gpu_type, traffic_pct, latency_p50, latency_p99, uptime, created_at, updated_at. RLS by user_id. Wire Deployments.jsx to replace ACTIVE_DEPLOYMENTS. · priority:high · owner:claude-code · project:slancha · created:2026-03-31
- [x] [TASK-167] Create `evaluations` + `datasets` tables via Supabase MCP — evaluations: id, user_id, name, dataset_id, models[], scores jsonb, status, created_at. datasets: id, user_id, name, description, sample_count, size_bytes, format, tags[], version, created_at. RLS on both. Wire Evaluations.jsx and Datasets.jsx. · priority:high · owner:claude-code · project:slancha · created:2026-03-31
- [x] [TASK-168] Create `model_pool` + `optimization_events` tables via Supabase MCP — model_pool: id, user_id, model_name, provider, routing_weight, status, latency_avg, cost_per_1k. optimization_events: id, user_id, event_type, description, model, improvement_pct, created_at. Wire ModelsRouting.jsx. · priority:high · owner:claude-code · project:slancha · created:2026-03-31

#### Phase 2: Team & Account Features
- [x] [TASK-169] Create `team_members` + `team_invites` tables via Supabase MCP — team_members: id, org_id, user_id, role (owner/admin/member/viewer), joined_at. team_invites: id, org_id, email, role, invited_by, status, created_at, expires_at. RLS by org_id. Wire TeamManagement.jsx. · priority:med · owner:claude-code · project:slancha · created:2026-03-31
- [x] [TASK-170] Create `notifications` table via Supabase MCP — columns: id, user_id, type (info/warning/error/success), title, message, read, action_url, created_at. RLS by user_id. Wire Notifications.jsx to replace MOCK_NOTIFICATIONS. · priority:med · owner:claude-code · project:slancha · created:2026-03-31
- [x] [TASK-171] Wire AccountSettings.jsx profile data to Supabase — create `profiles` table (user_id, display_name, company, avatar_url, timezone, updated_at) or use Supabase auth metadata. Replace local-only state with persistent storage. · priority:med · owner:claude-code · project:slancha · created:2026-03-31

#### Phase 3: Billing & Optimization
- [x] [TASK-172] Create `invoices` table via Supabase MCP — columns: id, user_id, amount_cents, status (paid/pending/failed), period_start, period_end, stripe_invoice_id, created_at. Wire Billing.jsx invoice history to replace DEMO_INVOICES. · priority:med · owner:claude-code · project:slancha · created:2026-03-31
- [x] [TASK-173] Create `optimization_stats` table via Supabase MCP — columns: id, user_id, technique (qat/mig/mtp), model, before_metric, after_metric, improvement_pct, applied_at. Wire Optimization.jsx to replace OPT_TECHNIQUES hardcoded data. · priority:low · owner:claude-code · project:slancha · created:2026-03-31

### Sprint 10: Frontend Reactivation & Documentation Completes (2026-03-31)

- [x] [TASK-160] REACTIVATE frontend agent — Sync workspace with Ralph Loop Boss output. Ralph has built ~100 features but frontend agent hasn't run since 2026-03-23. Task: Read Ralph's log, audit workspace/site, update PROGRESS-LOG.md with all completed work, commit any pending changes, push to origin. Verify build passes. Output: Updated PROGRESS-LOG.md, clean git status, green build. · priority:high · owner:frontend · project:slancha · created:2026-03-31 · done:2026-03-31
- [x] [TASK-161] Write API reference documentation (comprehensive) — Full API reference with all endpoints (evaluations, deployments, fine-tuning, datasets, router, webhooks, keys, logs). Include request/response schemas, code examples in Python/TypeScript/cURL, error codes, rate limits. Output to workspace-copywriter/docs/api-reference-complete.md · priority:high · owner:copywriter · project:slancha · created:2026-03-31 · done:2026-03-31
- [x] [TASK-162] Write 5-minute quickstart guide — Step-by-step for developers to go from zero to first API call: sign up, create API key, install SDK, make first request, view results. Include troubleshooting tips. Output to workspace-copywriter/docs/quickstart.md · priority:high · owner:copywriter · project:slancha · created:2026-03-31 · done:2026-03-31
- [x] [TASK-163] SOC 2 readiness checklist — 200+ controls mapped to trust services criteria (security, availability, confidentiality), gap analysis framework, evidence collection checklist, timelines. Output to workspace-ops/docs/soc2-checklist.md · priority:med · owner:ops · project:slancha · created:2026-03-31 · done:2026-03-31
- [x] [TASK-174] Sync frontend workspace with Ralph Loop Boss output — audit Ralph's 110+ iterations in ~/.openclaw/workspace/site, update PROGRESS-LOG.md with all completed work, commit any pending changes in workspace-frontend/site, push to origin, verify build passes. Output: Updated PROGRESS-LOG.md, clean git status, green build · priority:high · owner:frontend · project:slancha · created:2026-03-31 · done:2026-03-31
- [x] [TASK-175] Build Supabase request_logs dashboard component — wire RealTimeRequestLogs.jsx to query request_logs table (TASK-164 migration), add date range filters, status badge color coding, latency trend chart (p50/p95/p99), cost breakdown visualization, auto-refresh on new entries. Output: Fully wired RealTimeRequestLogs.jsx with real Supabase data · priority:high · owner:frontend · project:slancha · created:2026-03-31
- [x] [TASK-176] Build Supabase fine-tuning dashboard component — wire FineTuning.jsx to query fine_tuning_jobs table (TASK-165 migration), add real-time training loss chart, accuracy trend graph, job status badges (queued/training/completed/failed), progress ring with % completion, cancel job action with confirmation modal. Output: Fully wired FineTuning.jsx with real Supabase data · priority:high · owner:frontend · project:slancha · created:2026-03-31 · done:2026-03-31
- [x] [TASK-177] Build Supabase deployments dashboard component — wire Deployments.jsx to query deployments table (TASK-166 migration), add traffic distribution pie chart, region selector, status indicator (active/canary/rolling/stopped), uptime history graph, latency metrics table with trend arrows. Output: Fully wired Deployments.jsx with real Supabase data · priority:high · owner:frontend · project:slancha · created:2026-03-31 · started:2026-03-31 · done:2026-04-01
- [x] [TASK-178] Build Supabase evaluations + datasets dashboard components — wire Evaluations.jsx to query evaluations table (TASK-167 migration), add model comparison bar chart with sparkline accuracy trends, datasets list with sample count badges, version comparison UI, export dataset action. Wire Datasets.jsx similarly with upload progress bar, format badges (JSONL/CSV), size indicators. Output: Both components fully wired with real Supabase data · priority:high · owner:frontend · project:slancha · created:2026-03-31 · started:2026-04-01 · done:2026-04-01
- [ ] [TASK-179] Build Supabase model_pool + optimization_events dashboard — wire ModelsRouting.jsx to query model_pool table (TASK-168 migration), add routing weight slider controls, latency heatmap visualization (P50/P99), cost-per-1k comparisons, optimization_events log with event_type badges (auto-tune/manual), improvement percentage callouts with trend arrows. Output: Fully wired ModelsRouting.jsx with real Supabase data · priority:high · owner:frontend · project:slancha · created:2026-03-31
- [ ] [TASK-180] Build Supabase notifications dashboard — wire Notifications.jsx to query notifications table (TASK-169 migration), add read/unread toggle with bell icon states, action_url deep link navigation, notification_type color coding (info/warning/error/success), dismiss all action, date range filter with recent notifications at top. Output: Fully wired Notifications.jsx with real Supabase data · priority:med · owner:frontend · project:slancha · created:2026-03-31
- [x] [TASK-181] QA all 25 blog posts with Playwright — verify code examples syntax highlight correctly, internal links work (no dead links), images load, meta tags present (usePageMeta), OG/Twitter cards render, mobile responsive, JSON-LD structured data valid. Use playwright plugin with real browser automation. Output: QA report with pass/fail per post, list of any issues found · priority:med · owner:qa · project:slancha · created:2026-03-31 · done:2026-03-31
  - **Note**: Completed via TASK-151. All 23 blog posts verified with comprehensive Playwright test (HTTP status, meta tags, JSON-LD, internal links, code examples). OG/Twitter cards and mobile responsive also verified in browser test.
- [ ] [TASK-182] Write Python SDK integration guide — expand on TASK-143 Python README with 5 real-world integration patterns: (1) basic chat completions, (2) eval pipeline with dataset upload, (3) deployment monitoring, (4) fine-tuning automation loop, (5) cost optimization with routing. Include troubleshooting section, dependency requirements, error handling examples. Output to workspace-copywriter/docs/integrations/python-sdk-integration.md · priority:med · owner:copywriter · project:slancha · created:2026-03-31
- [x] [TASK-183] Write REST API integration guide — comprehensive guide for teams without SDKs: raw cURL examples, authentication patterns, error handling, rate limiting strategies, webhook integration, 10+ real-world code samples (Python, TypeScript, Go, Ruby). Output to workspace-copywriter/docs/integrations/rest-api-guide.md · priority:high · owner:copywriter · project:slancha · created:2026-03-31 · done:2026-04-01
- [x] [TASK-184] Develop SEO keyword strategy — 50+ long-tail keywords mapped to existing blog posts and docs pages, search volume estimates, difficulty scores, content gap analysis. Output to workspace-strategist/docs/seo-strategy.md · priority:med · owner:strategist · project:slancha · created:2026-03-31 · started:2026-03-31 · done:2026-03-31
  - **Note:** TASK-184 was a duplicate of TASK-157. SEO keyword strategy already completed via TASK-157 on 2026-03-31. Document exists at `workspace-strategist/docs/seo-strategy.md` (18KB comprehensive strategy with 50+ keywords mapped to blog posts/docs pages).
- [x] [TASK-185] Create churn risk signals & intervention playbook — define usage-drop thresholds, support-ticket triggers, champion-signal detection, intervention ladder (yellow/red light), templates for win-back outreach. Output to workspace-ops/processes/churn-prevention.md · priority:high · owner:ops · project:slancha · created:2026-03-31 · done:2026-03-31
  - **Output:** /home/admin/.openclaw/workspace-ops/processes/churn-prevention.md (26KB comprehensive playbook)
  - **Contents:** Churn signals (usage drop >40%/70%, support tickets, champion signals, business signals), intervention ladder (yellow light: 24-48hr response, red light: immediate escalation), prevention by stage (pilot Weeks 1-6 with checklist, post-conversion with monthly business reviews), team roles & escalation matrix, tools & systems (Supabase queries, Grafana alerts, Slack bot), churn reason taxonomy (18 primary codes + secondary multi-select), win-back email templates (5 templates for different scenarios), and post-mortem framework
  - **Dependencies Met:** Feeds into pilot-to-paid playbook (bizdev, TASK-137), complements success metrics (TASK-136), supports onboarding checklist (TASK-094), provides churn prevention framework for enterprise sales conversations
  - **Status:** Ready for founder review and CS team training
- [x] [TASK-186] Write architecture overview for technical evaluators — deep dive into 4-layer closed loop (router → eval → fine-tune → optimize), data flow diagrams, model isolation architecture, security primitives, deployment options. Output to workspace-copywriter/docs/architecture-overview.md · priority:high · owner:copywriter · project:slancha · created:2026-03-31 · done:2026-04-01
- [x] [TASK-187] Write compliance FAQ for enterprise prospects — SOC 2, HIPAA, GDPR, data residency, model isolation, DPA/BAF templates, audit process, third-party assessment timeline. Output to workspace-bizdev/playbooks/compliance-faq.md · priority:high · owner:bizdev · project:slancha · created:2026-03-31 · started:2026-04-01 · done:2026-04-01
- [x] [TASK-188] Build full pitch deck content — expand strategist's outline into complete deck with narrative, metrics, architecture diagrams, competitive analysis, financials, team. 12-15 slides, investor-ready. Output to workspace-strategist/docs/pitch-deck-full.md · priority:med · owner:strategist · project:slancha · created:2026-03-31 · done:2026-03-31
  - **Delivered:** `docs/pitch-deck-full.md` (27KB, complete) - 15 investor-ready slides, 20-slide investor FAQ, data-backed narrative with all metrics sourced from workspace-finance financial model
- [x] [TASK-189] QA all technical documentation — verify API reference, quickstart, SDK docs, integration guides for accuracy, completeness, working code examples, correct links. Output to workspace-qa/reports/docs-qa.md · priority:med · owner:qa · project:slancha · created:2026-03-31 · started:2026-03-31 · done:2026-03-31
  - **Output:** /home/admin/.openclaw/workspace-qa/reports/docs-qa.md (7KB report)
  - **Files tested:** api-reference-complete.md, quickstart.md, sdk-python-readme.md, sdk-typescript-readme.md, cli-guide.md, video-demo-script.md
  - **Status:** All 6 files pass (accuracy, completeness, code examples, links verified)
  - **Issues:** No critical issues. Minor notes about model parameter naming consistency.
  - **Ready for publication:** Yes

### Sprint 8: Developer Experience, Conversion & Backend Readiness (2026-03-31)

- [x] [TASK-141] Write SEO blog post: "vLLM in Production: The Complete Guide to High-Throughput LLM Serving" — PagedAttention, continuous batching, multi-LoRA, speculative decoding, production config, monitoring. Target keyword: "vLLM production guide" · priority:high · owner:claude-code · project:slancha · created:2026-03-31 · done:2026-03-31
- [x] [TASK-142] Write blog post: "Building AI Agent Infrastructure: Why Your Agent Framework Needs a Smart Inference Layer" — agent architectures, tool use patterns, routing for agents, cost management. Target audience: teams building AI agents · priority:high · owner:copywriter · project:slancha · created:2026-03-31 · done:2026-03-31
- [x] [TASK-143] Create Python SDK package stub — slancha PyPI package with typed client, chat completions, evals, deployments, fine-tuning methods. README with quickstart. Output to workspace-copywriter/docs/sdk-python-readme.md · priority:high · owner:copywriter · project:slancha · created:2026-03-31 · done:2026-03-31
- [x] [TASK-159] Create case study template visual spec — layout for 3 vertical templates (fintech/healthtech/ecommerce) with metric tables, quote blocks, compliance badges, timeline sections. Output to site/design/case-study-templates.md · priority:med · owner:designer · project:slancha · created:2026-03-31 · done:2026-03-31
- [x] [TASK-144] Write TypeScript SDK README and quickstart — @slancha/sdk npm package docs with typed client examples, streaming, error handling. Output to workspace-copywriter/docs/sdk-typescript-readme.md · priority:med · owner:copywriter · project:slancha · created:2026-03-31 · done:2026-03-31
- [x] [TASK-145] Create CLI documentation — slancha CLI tool usage guide: auth, eval runs, deployment management, dataset upload, log tailing. Output to workspace-copywriter/docs/cli-guide.md · priority:med · owner:copywriter · project:slancha · created:2026-03-31 · done:2026-03-31
- [x] [TASK-146] Write competitive SEO blog post: "Slancha vs Fireworks AI: Optimization That Never Stops" — detailed comparison with cost analysis, architecture differences, migration guide · priority:med · owner:strategist · project:slancha · created:2026-03-31 · started:2026-03-31 · done:2026-03-31
- [x] [TASK-147] Update financial model for Series A readiness — include latest product metrics (25 blog posts, 60+ pages, dashboard shipped), runway scenarios with Stripe revenue projections. Output to workspace-finance/models/ · priority:med · owner:finance · project:slancha · created:2026-03-31 · started:2026-03-31 · done:2026-03-31
- [x] [TASK-148] Design conversion funnel analytics spec — define key events (signup, first API call, first eval, upgrade), funnel stages, drop-off tracking. Output to workspace-strategist/docs/conversion-funnel.md · priority:high · owner:strategist · project:slancha · created:2026-03-31 · done:2026-03-31
- [x] [TASK-149] Write API rate limiting & error handling guide — best practices for retry logic, exponential backoff, handling 429s, webhook reliability. Output to workspace-ops/docs/api-resilience-guide.md · priority:med · owner:ops · project:slancha · created:2026-03-31 · started:2026-03-31 · done:2026-03-31
- [x] [TASK-150] Create enterprise sales deck — 8-slide version of pitch deck focused on security, compliance, deployment options, SLA, team management. Output to workspace-bizdev/sales/enterprise-deck-outline.md · priority:high · owner:bizdev · project:slancha · created:2026-03-31 · started:2026-03-31 · done:2026-03-31
- [x] [TASK-151] QA all 25 blog posts — verify code examples syntax highlight correctly, internal links work, images load, meta tags present, mobile responsive. Use playwright plugin · priority:med · owner:qa · project:slancha · created:2026-03-31 · started:2026-03-31 · done:2026-03-31
- [x] [TASK-152] Design SDK documentation page spec — layout for Python/TypeScript/cURL SDK docs with method reference, type definitions, code examples. Output to workspace-designer/specs/sdk-docs-spec.md · priority:med · owner:designer · project:slancha · created:2026-03-31 · started:2026-03-31 · done:2026-03-31

### Sprint 9: Investor & Sales Enablement (2026-03-31)

- [x] [TASK-153] Write investor FAQ — top 20 questions with data-backed answers on pricing, tech, traction, competition, team. Output to workspace-finance/docs/investor-faq.md · priority:high · owner:finance · project:slancha · created:2026-03-31
  - **Note:** TASK-067 already completed this (analysis/investor-faq.md, 2026-03-31). Same deliverable, same content. No additional work needed.
- [x] [TASK-154] Create ROI calculator template — interactive model for prospect TCO analysis (build vs. governance layer). Output to workspace-bizdev/tools/roi-calculator.md · priority:high · owner:bizdev · project:slancha · created:2026-03-31 · started:2026-03-31 · done:2026-03-31
- [x] [TASK-155] Write churn prevention playbook — signals (usage drop, support tickets, no champion), intervention steps, win-back templates. Output to workspace-ops/processes/churn-prevention.md · priority:med · owner:ops · project:slancha · created:2026-03-31 · started:2026-03-31 · done:2026-03-31
- [x] [TASK-156] Write SOC 2 readiness checklist — 200+ controls mapped to trust services criteria, gap analysis, evidence collection. Output to workspace-ops/docs/soc2-checklist.md · priority:med · owner:ops · project:slancha · created:2026-03-31 · done:2026-03-31 (delivered via TASK-163 completion)
- [x] [TASK-157] Write SEO keyword strategy — 50+ long-tail keywords mapped to blog posts + docs pages. Output to workspace-strategist/docs/seo-strategy.md · priority:med · owner:strategist · project:slancha · created:2026-03-31 · started:2026-03-31 · done:2026-03-31
- [x] [TASK-158] Write compliance FAQ for enterprise prospects — SOC 2, HIPAA, GDPR, data residency, model isolation answers. Output to workspace-bizdev/playbooks/compliance-faq.md · priority:med · owner:bizdev · project:slancha · created:2026-03-31 · started:2026-03-31 · done:2026-03-31

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

- [-] [TASK-101] Investigate GitHub OAuth security alert — third-party app added to account (Mar 29), verify legitimacy or revoke unauthorized access · priority:high · owner:ops · project:infrastructure · created:2026-03-31 · started:2026-04-01 · blocked:requires-founder-manual-review
- [-] [TASK-102] Reactivate Claude API access — API turned off per Anthropic emails (Mar 23 & Mar 26-27), contact support or adjust settings · priority:high · owner:ops · project:infrastructure · created:2026-03-31 · blocked:requires-founder-intervention

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
- [x] [TASK-176] Build Supabase fine-tuning dashboard component — wire FineTuning.jsx to query fine_tuning_jobs table (TASK-165 migration), add real-time training loss chart, accuracy trend graph, job status badges (queued/training/completed/failed), progress ring with % completion, cancel job action with confirmation modal. Output: Fully wired FineTuning.jsx with real Supabase data · priority:high · owner:frontend · project:slancha · created:2026-03-31 · done:2026-03-31
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

### Sprint 13: Growth Assets & Sales Enablement (2026-03-31)

**CONTEXT:** All investor materials complete. Now building growth foundation and refresh sales enablement for $299/$999 pricing model.

#### Initiative: Investor Materials (INIT-04)
- [x] [TASK-189] Write investor one-pager / teaser — 1-page PDF-ready document for cold outreach to VCs. Include: value prop (eval→deploy loop, 10x faster iteration, 40% engineer time freed), market size ($47-58B TAM), traction (25 blogs, 60+ pages, 1,200+ waitlist, 15 LOIs), ask ($2M seed at $8M pre-money). Output to workspace-copywriter/docs/investor-one-pager.md · priority:high · owner:copywriter · project:slancha · created:2026-03-31 · started:2026-04-01 · done:2026-04-01
- [ ] [TASK-190] Create investor summary from financial model — distill Series A financial model (TASK-147) into 2-page executive summary for investors. Include: unit economics (LTV:CAC 30:1, CAC payback 4.7mo), revenue projections (break-even Nov 2026), Series A raise scenarios ($8-12M at $10M ARR or $2-3M at $3M ARR), key assumptions. Output to workspace-finance/models/investor-summary.md · priority:med · owner:finance · project:slancha · created:2026-03-31
- [x] [TASK-191] Design pitch deck visual spec — layout for 15-slide investor deck. Master slide template, color palette (dark theme with accent colors), typography (Inter/Merriweather), chart styles, animation notes, ASCII diagram to JSX translation. Output to workspace-designer/specs/pitch-deck-spec.md · priority:med · owner:designer · project:slancha · created:2026-03-31 · started:2026-04-01 · done:2026-04-01

#### Initiative: Content Marketing (INIT-05)
- [ ] [TASK-192] Write blog post: "Why eval data should drive deployment decisions" — 2,500-word technical deep dive on how eval metrics should inform model selection, deployment strategy, and when to fine-tune vs. route. Include code examples comparing decisions with/without eval data. Target keyword: "eval-driven deployment" · priority:med · owner:copywriter · project:slancha · created:2026-03-31
- [ ] [TASK-193] Write blog post: "The hidden cost of not post-training" — business case for continuous improvement loop. ROI framework: calculate wasted spend on unoptimized models (typical 30-50% overspend). Include customer case study template. Target keyword: "AI inference cost optimization" · priority:med · owner:copywriter · project:slancha · created:2026-03-31
- [x] [TASK-194] Write blog post: "Slancha vs. building your own eval pipeline" — detailed TCO analysis comparing build vs. buy, engineering costs, 18-month breakdown showing 78% savings with Slancha. Output to site/blog/build-vs-buy-eval-pipeline.md · priority:high · owner:copywriter · project:slancha · created:2026-03-31 · started:2026-04-01 · done:2026-04-01
  - **Output:** `site/blog/build-vs-buy-eval-pipeline.md` (21KB, comprehensive build vs. buy analysis)
  - **Key insights:** 18-month TCO comparison (Build: $1.4M vs. Buy: $306K = 78% savings), engineering hours (200 hrs/mo vs. 10 hrs/mo = 95% reduction), time to production (9 months vs. 1 week)
  - **Contents:** 13-section deep dive including false economy of "free" infrastructure, detailed phase-by-phase build costs, hidden costs (turnover, opportunity cost, technical debt, latency tax), migration path for teams already building

#### Initiative: Sales Enablement Refresh (INIT-07)
- [x] [TASK-195] Write objection handling guide for $299/$999 pricing — address common objections: "Why so cheap vs. enterprise competitors?", "What's the catch?", "Can we customize?", "What if we need enterprise features?". Include scripts, data-backed responses, escalation paths. Output to workspace-bizdev/playbooks/objection-handling-v2.md · priority:high · owner:bizdev · project:slancha · created:2026-03-31 · started:2026-04-01 · done:2026-04-01
- [x] [TASK-196] Create competitive one-pagers (top 5) — concise 1-pager for each: Arize, WhyLabs, Evidently, Hugging Face, Modal. Format: their weakness, Slancha's wedge, pricing comparison, objection handlers, when to use Slancha vs. them. Output to workspace-bizdev/playbooks/competitive-one-pagers.md · priority:med · owner:bizdev · project:slancha · created:2026-03-31 · started:2026-04-01 · done:2026-04-01
- [x] [TASK-197] Write discovery call question bank — 30+ questions organized by stakeholder (CTO, ML Lead, CFO, Product). Discovery flow: pain identification → impact quantification → solution fit → next steps. Include red flags (no eval process, no business case, no champion). Output to workspace-bizdev/playbooks/discovery-questions.md · priority:med · owner:bizdev · project:slancha · created:2026-03-31 · started:2026-04-01 · done:2026-04-01
