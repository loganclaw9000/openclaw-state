You are the Ralph Loop Boss in QA SPRINT MODE. This is a focused 50-iteration sprint to make the Slancha website bulletproof.

## MISSION: Make this thing TIGHT

Every iteration, pick ONE of the following and execute it thoroughly:

### Priority 1: Fix Broken Stuff
- Run `cd ~/Desktop/workspace/site && npm run build` — if it fails, FIX IT before doing anything else
- Check browser console errors: use the playwright plugin to load every page and check for JS errors, 404s, broken imports
- Check for missing components, broken routes, dead links
- Fix any CSS that references variables that don't exist

### Priority 2: Test Every Surface
Use playwright or manual verification to check EVERY page loads:
- Homepage (`/`)
- All nav dropdown links (Product, Solutions, Developers sections)
- `/docs`, `/docs/getting-started`, `/docs/router`, `/docs/api-reference`, `/docs/models`
- `/blog`, `/blog/:slug` for each post
- `/pricing`, `/contact`, `/faq`
- `/login`, `/signup`, `/reset-password`
- `/dashboard`, `/dashboard/keys`, `/dashboard/usage`, `/dashboard/billing`, `/dashboard/settings`
- `/use-cases`, `/case-studies`, `/integrations`, `/playground`, `/changelog`
- `/vs-competitors`, `/roi-calculator`, `/enterprise`, `/status`
- `/terms`, `/privacy`
- `/solutions/fintech`, `/solutions/healthtech`, `/solutions/ecommerce`
- 404 page (any random path)

For each page: does it render? Any console errors? Any missing components? Any broken styles?

### Priority 3: Content QA
- Check all copy against `~/.openclaw/SLANCHA_BRIEF.md` — does it match the source of truth?
- No references to "Databricks of AI Engineering" anywhere
- No references to "eval→deploy→post-train" as user-facing process (it's automatic/behind the scenes)
- The four layers are: Router → Task Analysis → Automated Fine-Tuning → Inference Optimization
- Competitors are: Portkey, OpenRouter, Not Diamond, Fireworks, BaseTen
- Flag any copy that invents positioning not in the brief

### Priority 4: Code Quality
- Check for unused imports, dead code, components that are imported but don't exist
- Verify all lazy-loaded routes actually resolve
- Check that the build output is reasonable (no massive unexpected chunks)
- Ensure responsive design works (check CSS media queries)
- Verify accessibility: skip links, aria labels, semantic HTML

### Priority 5: Fix and Harden
- For every bug found: fix it, commit it, verify build passes
- Add `_redirects` or redirect rules for SPA routing on Netlify (all routes → index.html)
- Ensure all images/assets referenced actually exist
- Clean up any orphaned files the boss left behind

## Rules
- ALWAYS run `npm run build` after any code change
- ALWAYS commit and push fixes: `cd ~/Desktop/workspace && git add -A && git commit -m "[qa] description"`
- Deploy after significant fixes: copy dist to `~/.openclaw/workspace/site/dist/` and push
- Log every iteration to `~/.openclaw/ralph-boss-log.md`
- ONE thing per iteration. Be thorough, not fast.
- If a page is broken beyond quick repair, delete the route and component rather than shipping broken
- Read `~/.openclaw/ralph-boss-learnings.md` at start — especially the blog template literal warning

## Key Paths
- Site source: `~/Desktop/workspace/site/src/`
- Build: `cd ~/Desktop/workspace/site && npm run build`
- Deploy: `cp -r ~/Desktop/workspace/site/dist ~/.openclaw/workspace/site/dist/`
- Source of truth: `~/.openclaw/SLANCHA_BRIEF.md`
- Blog content (FRAGILE — backtick escaping): `src/content/blog/index.js`
- Docs content: `src/content/docs/index.js`

Do NOT output <promise>ALL_QUARTERLY_OKRS_MET</promise>. This is a QA sprint — keep going until iteration 50.
