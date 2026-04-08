You are running a QA session against the LIVE Slancha website on GitHub Pages.

Site URL: https://loganclaw9000.github.io/slancha-website/
Working directory: ~/.openclaw/workspace/site

## What happened
The site had CORS errors because it was hitting placeholder.supabase.co instead of the real Supabase instance. We fixed:
1. Replaced placeholder Supabase URL with real one (tqbvmmhgiivyjjcctqcb.supabase.co)
2. Set correct JWT anon key
3. Rebuilt with GITHUB_PAGES=true for correct /slancha-website/ base path
4. Pushed to origin/main

## Your Job
Run Playwright tests against the LIVE site to verify everything works. On each iteration:

### Iteration 1: Run existing E2E tests against live site
```bash
cd ~/.openclaw/workspace/site
VITE_BASE_URL=https://loganclaw9000.github.io/slancha-website npx playwright test --project=chromium 2>&1 | tail -50
```
Review failures. Fix what you can (test expectations, not the live site).

### Iteration 2+: Write and run targeted tests
For any failures or untested areas, write focused test scripts and run them:
```bash
VITE_BASE_URL=https://loganclaw9000.github.io/slancha-website npx playwright test e2e/SPECIFIC_FILE.spec.js --project=chromium
```

### Key areas to verify:
1. **Homepage loads** — no blank page, assets load
2. **Login page** — renders form, no CORS errors in console
3. **Signup page** — renders form, no CORS errors
4. **Dashboard** — redirects to login if not authenticated (expected behavior)
5. **All nav links** — Product, Solutions, Developers dropdowns work
6. **Docs pages** — /docs, /docs/getting-started, etc.
7. **Blog** — /blog, individual posts
8. **Static pages** — /pricing, /contact, /faq, /terms, /privacy
9. **Console errors** — capture and report any JS errors on each page
10. **Asset loading** — no 404s for JS/CSS/images

### If tests fail due to the site being broken:
- Fix the source code in ~/.openclaw/workspace/site/src/
- Rebuild: `GITHUB_PAGES=true npm run build`
- Commit and push: `git add -f dist/ src/ && git commit -m "[qa] fix description" && git push origin master:main`
- Re-run the failing test to verify

### Logging
After each iteration, append to ~/.openclaw/ralph-boss-log.md:
```
[ISO-timestamp] QA-playwright iteration N — what you tested, results, fixes applied
```

### Output
At the end, provide a summary of:
- Total pages tested
- Pages working correctly
- Pages with issues (and what the issues are)
- Fixes applied
- Remaining issues that need manual attention
