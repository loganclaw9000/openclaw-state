#!/bin/bash
# handler.sh — process one unread inbox message via claude --print
# Usage: handler.sh <message_file.json>

set -euo pipefail

MSG_FILE="$1"
COMMS_DIR="$HOME/.openclaw/agent-comms"
CONFIG="$COMMS_DIR/config.json"
THREAD_DIR="$COMMS_DIR/threads"
LOG="$COMMS_DIR/watcher.log"
SCRIPTS_DIR=$(find ~/.claude -path "*/agent-comms/scripts" -type d 2>/dev/null | head -1)
HOSTNAME_LOCAL=$(hostname)

mkdir -p "$THREAD_DIR"

log() { echo "[$(date -u +%Y-%m-%dT%H:%M:%SZ)] [handler] $*" >> "$LOG"; }

[[ -f "$MSG_FILE" ]] || exit 0

# Parse message
MSG_ID=$(python3 -c "import json; print(json.load(open('$MSG_FILE'))['id'])")
FROM=$(python3 -c "import json; print(json.load(open('$MSG_FILE'))['from'])")
THREAD_ID=$(python3 -c "import json; print(json.load(open('$MSG_FILE'))['thread_id'])")
SUBJECT=$(python3 -c "import json; print(json.load(open('$MSG_FILE')).get('subject',''))")
CONTENT=$(python3 -c "import json; print(json.load(open('$MSG_FILE'))['content'])")
STATUS=$(python3 -c "import json; print(json.load(open('$MSG_FILE')).get('status',''))")

[[ "$STATUS" == "unread" ]] || exit 0

# Anti-loop: skip self
if [[ "$FROM" == "$HOSTNAME_LOCAL" || "$FROM" == "${HOSTNAME_LOCAL}.local" ]]; then
    log "SKIP self: $MSG_ID"
    python3 -c "import json; m=json.load(open('$MSG_FILE')); m['status']='read'; json.dump(m, open('$MSG_FILE','w'), indent=2)"
    exit 0
fi

# Anti-loop: thread reply count
COUNT_FILE="$THREAD_DIR/${THREAD_ID}.count"
REPLY_COUNT=0
[[ -f "$COUNT_FILE" ]] && REPLY_COUNT=$(cat "$COUNT_FILE")
MAX_REPLIES=$(python3 -c "import json; print(json.load(open('$CONFIG')).get('max_thread_replies', 5))" 2>/dev/null || echo 5)
if (( REPLY_COUNT >= MAX_REPLIES )); then
    log "SKIP max replies ($REPLY_COUNT/$MAX_REPLIES): $MSG_ID thread=$THREAD_ID"
    python3 -c "import json; m=json.load(open('$MSG_FILE')); m['status']='read'; json.dump(m, open('$MSG_FILE','w'), indent=2)"
    exit 0
fi

# Anti-loop: cooldown
LAST_FILE="$THREAD_DIR/${THREAD_ID}.last"
COOLDOWN=$(python3 -c "import json; print(json.load(open('$CONFIG')).get('cooldown_seconds', 30))" 2>/dev/null || echo 30)
if [[ -f "$LAST_FILE" ]]; then
    LAST=$(cat "$LAST_FILE")
    NOW=$(date +%s)
    if (( (NOW - LAST) < COOLDOWN )); then
        log "SKIP cooldown: $MSG_ID thread=$THREAD_ID"
        exit 0
    fi
fi

# Mark read immediately to prevent double-handling
python3 -c "import json; m=json.load(open('$MSG_FILE')); m['status']='read'; json.dump(m, open('$MSG_FILE','w'), indent=2)"
log "Processing $MSG_ID from $FROM (thread $THREAD_ID, reply $((REPLY_COUNT+1))/$MAX_REPLIES)"

# Build reply via claude --print (pipe prompt via stdin to avoid shell quoting issues)
REPLY_FILE="/tmp/agent-reply-${MSG_ID}.txt"
HANDLER_LOG="/tmp/agent-handler-${MSG_ID}.log"
PROMPT_FILE="/tmp/agent-prompt-${MSG_ID}.txt"

cat > "$PROMPT_FILE" <<PROMPT
You are the Claude Code agent on $(hostname). You received this agent-comms message:

From: $FROM
Thread: $THREAD_ID
Subject: $SUBJECT
Content:
$CONTENT

Compose a concise, collaborative reply. Write ONLY the reply text to $REPLY_FILE — no preamble, no explanation to the user, just write the file.
Then send it: bash $SCRIPTS_DIR/send.sh $FROM $REPLY_FILE "$THREAD_ID" "Re: $SUBJECT"

You are an AI agent collaborating with another AI agent. Be direct and actionable.
PROMPT

cat "$PROMPT_FILE" | claude --print \
    --bare \
    --dangerously-skip-permissions \
    --allowedTools "Bash Read Write Edit Grep Glob" \
    > "$HANDLER_LOG" 2>&1

EXIT_CODE=$?
if [[ $EXIT_CODE -ne 0 ]]; then
    log "ERROR: claude exited $EXIT_CODE for $MSG_ID — see $HANDLER_LOG"
else
    log "Done: $MSG_ID replied"
fi

# Update thread counters
echo $((REPLY_COUNT + 1)) > "$COUNT_FILE"
date +%s > "$LAST_FILE"
