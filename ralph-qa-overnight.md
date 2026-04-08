You are running an overnight QA stress test of the Slancha website using Playwright. Be methodical, thorough, and fix bugs as you find them.

Site: https://loganclaw9000.github.io/slancha-website/
Test credentials: loganclaw9000@gmail.com / password
Source code: ~/.openclaw/workspace/site/src/
QA logs: ~/.openclaw/workspace/site/qa-logs/
Supabase: tqbvmmhgiivyjjcctqcb.supabase.co (18 tables, all empty, all RLS-enabled)

## RULES
- ONE phase per iteration. Be exhaustive within each phase.
- Write a Node.js Playwright script for each phase, run it, capture results.
- Log results to qa-logs/ as JSON: `{ phase: N, tests: [{ name, status, error?, screenshot? }], summary: { pass, fail, skip } }`
- When you find a bug: fix it in source, rebuild (`GITHUB_PAGES=true npm run build` in the site dir), commit and push (`cd ~/.openclaw/workspace && git add site/ && git commit -m "[qa] description" && git push origin master`), then re-test.
- After fixing, wait ~40 seconds for GitHub Pages deploy before re-testing live.
- Take screenshots of every failure and save to qa-logs/screenshots/
- Read ~/.openclaw/ralph-boss-learnings.md at the start for lessons from past QA runs.

## PHASE 1: Page Load Smoke Test (every page)
Visit every page. For each:
- Verify HTTP response (not actual 404 — GitHub Pages SPA returns 200 via 404.html)
- Verify page has >100 chars of body text
- Verify page title is set and contains "Slancha"
- Capture all console errors (pageerror events)
- Capture all failed network requests (requestfailed events)
- Flag any CORS errors or references to placeholder.supabase.co or localhost
- Flag any JS/CSS 404s (asset loading failures)

Pages (public):
/, /pricing, /contact, /faq, /terms, /privacy, /docs, /docs/getting-started, /docs/api-reference, /docs/router, /docs/models, /docs/webhooks, /docs/architecture, /blog, /use-cases, /case-studies, /integrations, /playground, /changelog, /status, /enterprise, /roi-calculator, /vs-competitors, /login, /signup, /reset-password, /developers, /demo, /sdk-reference, /glossary, /solutions/fintech, /solutions/healthtech, /solutions/ecommerce, /benchmarks

Pages (dashboard — login first):
/dashboard, /dashboard/keys, /dashboard/usage, /dashboard/models, /dashboard/router, /dashboard/evals, /dashboard/fine-tuning, /dashboard/optimization, /dashboard/deployments, /dashboard/datasets, /dashboard/logs, /dashboard/team, /dashboard/billing, /dashboard/webhooks, /dashboard/settings

## PHASE 2: Auth Stress Test
Test all auth flows:
- Login with correct credentials → should reach /dashboard
- Login with wrong password → should show error, stay on /login
- Login with empty fields → should show validation
- Login with non-existent email → should show error
- Login with SQL injection in email field (e.g., `' OR 1=1 --`) → should not break
- Login with XSS in email field (e.g., `<script>alert(1)</script>`) → should not execute
- Signup form validation: empty fields, mismatched passwords, too-short password, invalid email
- Password reset with valid email → should show success message
- Password reset with invalid email → should show error
- After login, verify session persists across dashboard page navigations
- After login, verify Sign Out button works and redirects to homepage or login
- Test that /dashboard redirects to /login when not authenticated
- Test that direct dashboard URLs (/dashboard/keys etc) redirect to /login when not authenticated

## PHASE 3: Form Interactions (submit every form)
For each form, fill all fields and submit. Verify behavior.

### Public forms:
- **Contact form** (/contact): Fill name, email, subject, message → submit. Check for success/error message. Try with empty fields too.
- **Waitlist** (homepage footer): Enter email → click Join Waitlist. Check response.
- **Login form**: Already tested in Phase 2.
- **Signup form**: Try creating account (use a unique test email like qa-test-TIMESTAMP@test.com). Verify response from Supabase.
- **Reset password form**: Submit with test email.

### Dashboard forms (logged in):
- **Create API Key** (/dashboard/keys): Click "Create Key" button. If modal appears, fill name and submit. Verify key appears or error shown.
- **Settings profile** (/dashboard/settings): Fill "Your name" and "Your company" fields, click "Save Profile". Verify success/error.
- **Settings password** (/dashboard/settings): Fill both password fields, click "Update Password". Try with mismatched passwords too.
- **Settings toggles** (/dashboard/settings): Click each of the 4 notification toggles (Usage alerts, Billing updates, Incident reports, Product updates). Verify toggle state changes.
- **Invite Member** (/dashboard/team): Click "Invite Member". If modal, fill email and submit.
- **Add Webhook** (/dashboard/webhooks): Click "Add Endpoint" or "Add Your First Webhook". If modal, fill URL and submit.
- **New Deployment** (/dashboard/deployments): Click "New Deployment". Check modal/form behavior.
- **New Fine-Tune Job** (/dashboard/fine-tuning): Click "+ New Fine-Tune Job". Check modal/form behavior.
- **Upload Dataset** (/dashboard/datasets): Click "Upload Dataset". Check modal/form behavior.
- **Dataset search** (/dashboard/datasets): Type in search input, verify filtering behavior.
- **Request logs search** (/dashboard/logs): Type in search input, verify behavior.
- **Delete Account** (/dashboard/settings): Click "Delete Account" button. Verify confirmation dialog appears. DO NOT confirm deletion.
- **Revoke All** (/dashboard/settings): Click "Revoke All" button. Verify confirmation or behavior.
- **Export buttons** (/dashboard/settings): Click each of the 3 Export buttons. Verify behavior.

## PHASE 4: Click Everything (buttons, tabs, dropdowns, filters)
### Homepage:
- Click each nav dropdown trigger (Product, Solutions, Developers) → verify dropdown panel appears
- Click Search button → verify search modal opens
- Click "Get Your API Endpoint" CTA → verify navigation to /signup
- Click "See How It Works" → verify smooth scroll to #how-it-works
- Click each pipeline viz node (Route, Analyze, Fine-tune, Optimize) → verify detail card updates
- Click through pricing tier CTAs at bottom

### Blog:
- Click each filter tag (All, Inference, Fine-Tuning, Architecture, Engineering, Strategy, Platform, Comparisons, Router, Cost Optimization, Tutorials)
- Verify blog cards filter correctly
- Click into a blog post, verify it loads

### Playground:
- Click each tab (POST Route, POST Create Eval, POST Deploy Model, POST Fine-Tune, POST Upload Dataset)
- Verify code example updates per tab
- Click "Run" button, verify response behavior

### Demo:
- Click through all 5 demo steps using "Next Step →" button
- Click "← Previous" to go back
- Click each numbered step button directly (1-5)

### ROI Calculator:
- Drag each of the 5 range sliders to different values
- Change the model select dropdown to each option
- Verify calculated values update

### Dashboard:
- Onboarding checklist: Click each "Mark complete" button (1-4) on /dashboard
- Usage period buttons: Click 7d, 30d, 90d on /dashboard/usage
- Logs filters: Click each time filter, type filter, status filter
- Logs refresh button
- Fine-tuning tabs: All Jobs, Promoted Models, Auto-Promote Config
- Deployments tabs: Active, History
- Deployments selects: Change region and status dropdowns
- Billing tabs: Overview, Usage, Invoices, Payment
- Notifications bell: Click, verify dropdown/panel

### Pricing:
- Click each tier CTA button (Get Started, Start Free Trial, Contact Sales, Join Waitlist)
- Verify correct navigation

## PHASE 5: Dashboard CRUD via Supabase
Test that dashboard operations actually write/read Supabase:
- Create an API key → verify it appears in the list and in Supabase `api_keys` table (use mcp__supabase__execute_sql to check)
- Update profile in Settings → verify `profiles` table updated
- Toggle notification settings → verify state persists on page reload
- Invite a team member → verify `team_invites` table
- Add a webhook → verify UI updates
- Test that usage stats show correctly (even if zero)

Note: Many tables are empty and the UI may use hardcoded mock data. Document which features use real Supabase data vs mock data.

## PHASE 6: Edge Cases & Security
- **XSS testing**: Enter `<script>alert('xss')</script>` in every text input. Verify it's sanitized (not executed).
- **SQL injection**: Enter `'; DROP TABLE users; --` in form fields. Verify no errors.
- **Long input**: Enter a 10,000-character string in text fields. Verify graceful handling.
- **Special characters**: Enter `<>&"'{}[]|\/` in all inputs. Verify proper rendering.
- **Rapid double-click**: Double-click submit buttons on forms. Verify no duplicate submissions.
- **Empty form submission**: Submit every form with all fields empty. Verify validation messages.
- **Navigate away mid-form**: Start filling a form, navigate away, come back. Check behavior.
- **Browser back/forward**: Navigate through several pages, use back button, verify state.
- **Mobile viewport**: Run key interactions at 375px width to verify mobile works.
- **Concurrent sessions**: Open two tabs, login in both, verify no conflicts.

## PHASE 7: Link Audit
- Crawl every page and extract all `<a href>` links
- For internal links: verify each resolves (GET request returns non-error content)
- Flag any links missing the /slancha-website/ base path prefix
- Flag any links to pages that render 404/NotFound content
- For external links: verify they're reachable (HEAD request, check for non-error status)
- Check for mailto: and tel: links being properly formatted
- Check all anchor links (#section) actually have a matching element on the page

## AFTER ALL PHASES
Write a final summary to qa-logs/summary.json:
```json
{
  "date": "YYYY-MM-DD",
  "totalTests": N,
  "passed": N,
  "failed": N,
  "bugsFound": N,
  "bugsFixed": N,
  "remainingIssues": ["description", ...],
  "phaseSummaries": [{ "phase": 1, "pass": N, "fail": N }, ...]
}
```

Also append to ~/.openclaw/ralph-boss-log.md with a summary line per phase completed.

Send a WhatsApp message when all phases are done:
```bash
openclaw message send --channel whatsapp --target +13177098416 -m "🔍 [qa] Overnight QA complete. X tests run, Y passed, Z failed. N bugs found, M fixed. See qa-logs/ for details."
```
