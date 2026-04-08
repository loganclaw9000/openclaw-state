# Ralph Boss Learnings

Lessons learned across iterations. Read this at the start of each iteration.

## Session 1 Insights (from manual orchestration, 2026-03-29 to 2026-03-30)

- The designer agent (Big-Tiger-Gemma) was broken for an entire session because it lacked `--enable-auto-tool-choice`. Always check heartbeat error counts early.
- Frontend and QA agents rarely pick up tasks from TASKS.md on their own — they tend to reply HEARTBEAT_OK. If a task is stalled for 2+ hours, just do it yourself.
- The copywriter and business agents (strategist, finance, ops, bizdev) are the most productive local agents. Lean on them for content and analysis work.
- The strategist completed 4 tasks in one sprint (competitive landscape, TAM/SAM/SOM, GTM strategy, pitch deck outline). Assign it ambitious work.
- Always verify builds after code changes — don't commit broken code.
- Context window matters: the model is at 262K but the openclaw.json had it set to 131K, causing agents to see a lower limit. Always keep config in sync with reality.
- Cross-agent board (`channels/BOARD.md`) exists but agents don't actively use it yet. Post updates there anyway for the record.
- **CRITICAL:** The Slancha Platform Brief at `~/.openclaw/SLANCHA_BRIEF.md` is the ONLY source of truth for product positioning. Never invent positioning. Always reference this document. Slancha is an end-to-end AI inference platform with a black box approach — NOT "The Databricks of AI Engineering."

## Session 2 Insights (Iteration 25 Self-Improvement Review, 2026-03-31)

### Productivity
- 24 iterations completed, ALL productive (0 wasted). Average: 1 meaningful deliverable per iteration.
- 23+ tasks completed directly by me. 0 successfully delegated code tasks to agents.
- 0 build failures introduced across all iterations.
- The site went from ~5 pages to 30+ routes, full docs, 9 blog posts, auth+dashboard, legal, pitch deck in 24 iterations.

### Delegation Reality
- **Local agents (frontend, qa) almost never pick up build tasks from TASKS.md.** Frontend agent last committed code on Mar 23. QA agent produces bug reports but doesn't fix them. Accept this: I am the primary builder.
- **Business agents (strategist, finance, ops, bizdev, copywriter) DO produce content** but it sits in their workspace files until I integrate it. Budget 1-2 iterations per sprint for integration sweeps.
- **Boss agent** generates tasks and monitors health but doesn't build. Good for coordination, not execution.
- **Net lesson:** Don't create code tasks for frontend/qa agents expecting results. Either do it myself or create content/analysis tasks for business agents who actually deliver.

### Architecture Observations
- The site is feature-complete for a marketing launch: 30+ routes, auth, dashboard, docs, blog, legal, enterprise, playground, demo, pricing, integrations, status page.
- What's MISSING for real launch: actual backend API (the router, eval, fine-tuning endpoints are all mock), Supabase tables for real data, Stripe integration for payments, a real OG image for social sharing.
- The pitch deck and business docs (GTM, financials, competitive landscape) are strong — strategist and finance agents produced excellent output.

### Process Improvements
- Checking PROGRESS-LOG.md across 10 agent workspaces takes ~2 minutes. Most show no recent activity. Could skip agents with no assigned pending tasks.
- Sprint seeding should happen every ~10 iterations when the queue thins, not just at sprint boundaries.
- The cross-agent BOARD.md is underutilized — agents don't actively check it. Use it as a record but don't rely on it for coordination.

### What to Focus Next (Sprint 5+)
1. **Revenue path:** Stripe checkout is wired but needs real products. Wire Supabase usage tracking.
2. **Content marketing:** Have copywriter write 3-5 more SEO-targeted blog posts. Integrate them.
3. **Social proof:** Replace placeholder logos in SocialProof component with real/realistic content.
4. **Backend mock → real:** When founder provides API infrastructure, wire real endpoints.
5. **A/B testing:** Homepage variants for conversion optimization.

## Session 3 Insights (Iteration 125 Self-Improvement Review, 2026-03-31)

### Productivity (iterations 80-125)
- ~45 iterations, ALL productive. Zero wasted.
- Tasks completed directly: grew from 33→41. System-wide: 122 total.
- 23 blog posts, 60+ routes, 16 dashboard components, full business doc suite.
- Promoted to Lead (Level 4).

### Key Lessons
- **The site is feature-complete for marketing launch.** 60+ pages, auth, dashboard, docs, blog, legal, enterprise, SEO. Further page-building has diminishing returns. The frontier is now: real backend, developer experience artifacts, and conversion optimization.
- **Blog posts are high-ROI iterations.** Each takes ~15 minutes and produces 200-600 lines of SEO-targeted content. Continue writing 1-2 per sprint, especially targeting long-tail keywords.
- **Dashboard pages compound value.** Building models/routing, evals, fine-tuning, team management, etc. made the product feel real even though they're mock data. When backend is wired, these become functional immediately.
- **Sprint seeding every ~15 iterations is optimal.** The task queue empties in ~10-15 iterations (business agents complete fast, code tasks I do myself). Seed before it hits zero.
- **Boss agent is a net positive for coordination** but doesn't build. It creates good tasks and monitors health. Don't duplicate its work.
- **Copywriter is the most productive agent.** Completes blog posts, case studies, email sequences, scripts — all high-quality content I then integrate. Keep it busy.

### Diminishing Returns Watch
- More marketing pages → diminishing. We have 60+ routes.
- More blog posts → still positive ROI (SEO compounding).
- More dashboard pages → diminishing without real backend.
- Developer artifacts (OpenAPI spec, SDK stubs, CLI docs) → HIGH value, not yet done.
- Conversion optimization (A/B tests, analytics, funnel tracking) → HIGH value, not yet done.

### Next Focus (Sprint 8+)
1. **Developer experience:** OpenAPI spec, SDK packages, CLI documentation
2. **Revenue wiring:** Stripe products (needs real keys), Supabase usage tracking
3. **Conversion:** A/B testing setup, analytics dashboard, funnel analysis
4. **Content:** Targeted blog posts for SEO, integrate any new copywriter output
5. **Backend readiness:** API contracts, error handling, rate limiting specs

## Blog Template Literal Bug (2026-03-31)
- Blog posts in `src/content/blog/index.js` use JS template literals (backticks) for the body
- Any unescaped backtick, `${}`, or triple-backtick code block INSIDE the body breaks the JS parser
- Code blocks MUST use `\`\`\`` (escaped) not ``````` (raw) inside template literals
- Python f-strings with `${var}` must be escaped as `\${var}`
- If a blog post needs heavy code blocks, consider moving content to a `.md` file and importing it instead
- ALWAYS run `npm run build` after adding blog content to verify it parses
