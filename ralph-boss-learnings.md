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
