#!/bin/bash
# Agent-Comms Inbox Watcher — polls inbox, dispatches to handler.sh
# Usage: watcher.sh [--once]

set -euo pipefail

COMMS_DIR="$HOME/.openclaw/agent-comms"
INBOX="$COMMS_DIR/inbox"
HANDLER="$COMMS_DIR/handler.sh"
CONFIG="$COMMS_DIR/config.json"
PEERS_FILE="$COMMS_DIR/peers"
LOG="$COMMS_DIR/watcher.log"
LOCKFILE="$COMMS_DIR/.watcher.lock"

POLL_INTERVAL=$(python3 -c "import json; print(json.load(open('$CONFIG')).get('poll_interval_seconds', 30))")
ONCE=false
[[ "${1:-}" == "--once" ]] && ONCE=true

log() { echo "[$(date -u +%Y-%m-%dT%H:%M:%SZ)] [watcher] $*" | tee -a "$LOG"; }

# Lock
if [[ -f "$LOCKFILE" ]]; then
    OLD_PID=$(cat "$LOCKFILE" 2>/dev/null || echo "")
    if [[ -n "$OLD_PID" ]] && kill -0 "$OLD_PID" 2>/dev/null; then
        log "ERROR: Already running (PID $OLD_PID)"
        exit 1
    fi
    rm -f "$LOCKFILE"
fi
echo $$ > "$LOCKFILE"
trap 'rm -f "$LOCKFILE"; log "Stopped."; exit 0' EXIT INT TERM

chmod +x "$HANDLER"

log "Started (PID $$, poll=${POLL_INTERVAL}s)"

while true; do
    # Pull from peers
    if [[ -f "$PEERS_FILE" ]]; then
        while IFS= read -r peer || [[ -n "$peer" ]]; do
            [[ -z "$peer" || "$peer" == \#* ]] && continue
            rsync -az --ignore-existing "${peer}:~/.openclaw/agent-comms/outbox/" "$INBOX/" 2>/dev/null || true
        done < "$PEERS_FILE"
    fi

    # Dispatch unread messages to handler
    for f in "$INBOX"/*.json; do
        [[ -f "$f" ]] || continue
        STATUS=$(python3 -c "import json; print(json.load(open('$f')).get('status',''))" 2>/dev/null || echo "")
        if [[ "$STATUS" == "unread" ]]; then
            bash "$HANDLER" "$f" &
        fi
    done

    $ONCE && { log "Single pass done."; break; }
    sleep "$POLL_INTERVAL"
done
