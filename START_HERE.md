# START HERE

**Written:** 2026-04-07 · **For:** the next machine / next operator taking over this OpenClaw brain.

This file is the fastest way to understand what this repo is, what state everything is in, and what you likely need to change for a new setup.

---

## TL;DR — current state (as of 2026-04-07 ~23:00 local)

Everything is **halted on purpose**. Slancha + OpenClaw work has been wound down. Before you start the system back up, read the "What to change" section below — the new machine almost certainly won't have the same GPU, paths, or model endpoints.

| Thing | State | How it was stopped |
|---|---|---|
| `crontab` (snapshot every 30m + model-health every 15m) | **cleared** | backup at `~/.openclaw/crontab.backup.20260407-230134.txt` |
| `openclaw-gateway.service` (systemd user unit) | **stopped + disabled** | `systemctl --user disable openclaw-gateway.service` |
| `start-openclaw.sh` launcher | **killed** | was running in a terminal on pts/2 |
| vLLM (Qwen3.5-35B on :8000) | **killed** | GPU is empty, confirmed via `nvidia-smi` |
| `gt` daemon / Ralph Loop / heartbeats | **not running** | nothing to stop |
| Brain repo (`~/.openclaw`) | **in sync with GitHub** | last snapshot `fc35725` at 06:00Z |

A recent bugfix is already committed + pushed: the `agents.defaults.cliBackends` key was removed from `openclaw.json` — OpenClaw 2026.4.5 dropped that config surface, so any config older than 2026-04 will fail validation until that key is gone.

---

## What this repo is

`~/.openclaw` is the **brain** — canonical state for the OpenClaw multi-agent system. It is a git repo, and `snapshot.sh` (in `~/openclaw-state/`) commits + pushes it to GitHub every 30 minutes via cron. When that cron is off, the brain stops syncing.

Key files at the root:
- `openclaw.json` — global config: providers, models, agents, gateway, plugins. **This is the file you'll need to edit most.**
- `SLANCHA_BRIEF.md` — product brief for the Slancha project (the main thing the agents have been building). Source of truth for positioning.
- `CLAUDE.md` (in `~/openclaw-state/`, not here) — instructions for Claude Code when it runs in this repo.
- `cron/jobs.json` — heartbeat schedules the OpenClaw gateway runs *internally* (different from system crontab).
- `tasks/TASKS.md` — cross-agent task queue.
- `agents/<name>/agent/` — per-agent config and prompts.
- `workspace*/` — each agent has its own workspace directory (see table below).
- `ralph-boss-*.md` — prompt/learnings/log/metrics for the Ralph Loop "boss" orchestrator role (the autonomous builder mode Claude Code runs in).

---

## The agents (6 active)

| Agent | Model (old setup) | Workspace | Role |
|---|---|---|---|
| `main` | `vllm/Qwen3.5-35B` | `workspace/` | Default / orchestrator |
| `copywriter` | `vllm/Qwen3.5-35B` | `workspace-copywriter/` | Copy & content |
| `designer` | `vllm-bigtiger/big-tiger-gemma-27b-v3` | `workspace-designer/` | Design specs & tokens |
| `frontend` | `vllm-coder/Qwen3-Coder-30B` | `workspace-frontend/` | React UI |
| `qa` | `vllm-coder/Qwen3-Coder-30B` | `workspace-qa/` | Testing |
| `claude` | `claude-cli/opus-4.6` | `workspace-claude/` | Tech lead, hard bugs (runs through Claude CLI — needs API access, not vLLM) |

There are also placeholder workspaces for `strategist`, `finance`, `ops`, `bizdev`, `boss` — directories exist but these agents weren't actively wired into model routing.

The gateway binds to **127.0.0.1:18789** and expects all the vLLM providers on loopback ports **8000 / 8001 / 8002 / 8003**.

---

## What to change for the new setup

**The old machine was an NVIDIA GB10 DIGITS system (hostname `promaxgb10-d325`) running 4 separate vLLM instances on loopback ports.** If the new machine is different — different GPU, different user, different model serving strategy — these are the things to fix, in order:

### 1. Fix the user / home paths if the user isn't `admin`
The config has `/home/admin/.openclaw/workspace*` hard-coded in several places inside `openclaw.json`:
- `agents.defaults.workspace`
- every entry under `agents.list[].workspace`
- every `agents.list[].agentDir`

Global find-replace `/home/admin` → `$NEW_HOME` is safe.

Also check:
- `cron/jobs.json` — hardcoded paths
- `snapshot.sh` in `~/openclaw-state/`
- Any `.sh` scripts in `~/bin/`

### 2. Fix the model providers to match the new GPU
`openclaw.json` → `models.providers` has six providers pointed at loopback vLLM/lm-studio endpoints. On the old machine these were:

| Provider key | Endpoint | Model | Why |
|---|---|---|---|
| `vllm` | `127.0.0.1:8000` | `Qwen3.5-35B` (FP8) | main + copywriter |
| `vllm-coder` | `127.0.0.1:8001` | `Qwen3-Coder-30B` | frontend + qa |
| `vllm-bigtiger` | `127.0.0.1:8002` | `big-tiger-gemma-27b-v3` | designer |
| `vllm-glm` | `127.0.0.1:8003` | `glm-4.5-air` | optional |
| `lmstudio` / `lmstudio-2` | LM Studio :1234 | gpt-oss 20B / 120B | optional |
| `anthropic` | api.anthropic.com | `claude-sonnet-4-6` | the `claude` agent uses Claude CLI, not this — kept for other routing |

**If the new machine has less GPU than a GB10 DIGITS**, you probably want to collapse to ONE vLLM endpoint serving one model and point all the agents at it. Edit `agents.list[*].model` and `agents.defaults.model.primary`. Cost fields can stay at `0` for local models.

**If the new machine uses a different runtime** (Ollama, llama.cpp, a remote API), change `baseUrl` and `api` on each provider. OpenClaw supports `openai-completions` and `anthropic-messages` out of the box.

### 3. Anthropic API key
The `claude` agent runs via Claude CLI, so it uses whatever credentials the CLI has on the new machine. Make sure `claude` is installed and logged in before starting the gateway.

### 4. WhatsApp + gateway
- `channels.whatsapp.allowFrom` lists two phone numbers — update these if the operator is different.
- `gateway.auth.token` is the gateway bearer token. Rotate it on the new machine (it's committed in git right now, which is sketchy).
- `env.vars.MATON_API_KEY` is also committed — rotate.

### 5. Systemd user service
The old machine had `~/.config/systemd/user/openclaw-gateway.service`. That unit file is **not in this repo** — you'll need to recreate it on the new machine (or just run the gateway in tmux). A minimal version:

```ini
[Unit]
Description=OpenClaw Gateway
After=network.target

[Service]
ExecStart=/home/admin/.npm-global/bin/openclaw gateway
Restart=on-failure

[Install]
WantedBy=default.target
```

### 6. Crontab
Backup of the old crontab is at `~/.openclaw/crontab.backup.20260407-230134.txt`. Contents were:
```
*/15 * * * * bash /home/admin/bin/model-health-check.sh
*/30 * * * * bash /home/admin/openclaw-state/snapshot.sh >> /home/admin/openclaw-state/snapshot.log 2>&1
```
Restore with `crontab ~/.openclaw/crontab.backup.20260407-230134.txt` **once you're sure the new setup works** — not before, or you'll start committing broken state every 30 minutes.

---

## How to resume (once the above is sorted)

1. Start vLLM (or whatever model server) and verify with `curl http://127.0.0.1:8000/v1/models`.
2. `openclaw doctor` — should report no config errors. If it complains about unknown keys, OpenClaw was upgraded; check `CHANGELOG.md` in the OpenClaw npm package (`/home/admin/.npm-global/lib/node_modules/openclaw/CHANGELOG.md`) for the breaking change.
3. `systemctl --user enable --now openclaw-gateway.service` (or start manually).
4. `openclaw dashboard` to confirm agents are reachable.
5. Restore crontab.
6. If Slancha work is resuming: `cd ~/.openclaw/workspace/site && npm install && npm run build` to sanity-check the site builds.

---

## Slancha project

- **What it is:** end-to-end AI inference platform, "black box" approach — single API endpoint, no model picking, no benchmarks. Four layers: Router → Task Analysis → Automated Fine-Tuning → Inference Optimization.
- **Source of truth:** `~/.openclaw/SLANCHA_BRIEF.md`. Always read this before changing copy or positioning.
- **Site code:** `~/.openclaw/workspace/site/` (React + Vite, static build).
- **Repo:** `github.com/loganclaw9000/slancha-website`.
- **Status at halt:** launch-ready. Copy/design/frontend/QA rounds complete. Agents were in "continuous improvement" mode (perf, SEO, content depth).

Per the operator: **Slancha + OpenClaw activities are wound down for now.** Don't resume heartbeats or Ralph Loop without confirmation — the halt is deliberate, not an incident.

---

## Gotchas you'll hit

- **`openclaw.json` has had a trailing comma in the `tools` section in the past.** Technically invalid JSON. If you edit it programmatically, use a regex strip: `re.sub(r',(\s*[}\]])', r'\1', raw)` before `json.loads`. The OpenClaw loader tolerates it; strict parsers don't.
- **Snapshot cron auto-commits + pushes every 30 min.** Anything you leave dirty in `~/.openclaw` ends up on GitHub. If you don't want that, either finish your edit fast or keep cron off.
- **`~/.openclaw/agents/*/agent/models.json` is NOT symlinked to `~/openclaw-state/agents/*/agent/models.json`.** They're separate files. If you update one, update the other.
- **OpenClaw version upgrades drop config keys.** The 2026.4.5 upgrade removed `agents.defaults.cliBackends`. Future upgrades may remove others — always run `openclaw doctor` after upgrading and be ready to prune dead keys.
- **Gateway port 18789** is loopback-bound. To reach it from another machine, SSH tunnel it; do not bind it to `0.0.0.0`.
- **The brain repo contains secrets** (gateway token, Maton API key, phone numbers). Rotate before sharing wider.

---

## If you're confused about what Claude Code is doing here

Claude Code runs in this repo in one of two modes:
- **Interactive** — you talk to it, it does work. Current mode.
- **Ralph Loop "boss"** — autonomous. Reads `~/.openclaw/ralph-boss-prompt.md` + `ralph-boss-learnings.md`, logs to `ralph-boss-log.md`, tracks itself in `ralph-boss-metrics.md`, updates `tasks/TASKS.md`. That loop is currently NOT running and shouldn't be restarted until the new setup is verified.

The `CLAUDE.md` in `~/openclaw-state/` has the fuller protocol if you want the details.
