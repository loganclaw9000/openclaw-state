#!/bin/bash
# Pull messages from a remote agent's outbox into a local mirror.
# This catches messages that were created but not pushed (e.g. SSH was down).
#
# Usage: pull.sh <host>
# Example: pull.sh Pauls-MacBook-Pro-2.local

set -euo pipefail

HOST=${1:?Usage: pull.sh <host>}
COMMS_DIR="$HOME/.openclaw/agent-comms"
INBOX="$COMMS_DIR/inbox"
REMOTE_OUTBOX="~/.openclaw/agent-comms/outbox/"
LOCAL_HOSTNAME=$(hostname)
LOG="$COMMS_DIR/watcher.log"

log() {
    echo "[$(date -u +%Y-%m-%dT%H:%M:%SZ)] [pull] $*" | tee -a "$LOG"
}

# Pull remote outbox to a temp dir, then copy messages addressed to us into inbox
TMPDIR=$(mktemp -d)
trap 'rm -rf "$TMPDIR"' EXIT

log "Pulling outbox from $HOST..."
rsync -avz --ignore-existing "${HOST}:${REMOTE_OUTBOX}" "$TMPDIR/" 2>/dev/null || {
    log "ERROR: rsync from $HOST failed"
    exit 1
}

PULLED=0
for f in "$TMPDIR"/*.json; do
    [[ -f "$f" ]] || continue
    # Only import messages addressed to us
    TO=$(python3 -c "import json; print(json.load(open('$f')).get('to',''))" 2>/dev/null || echo "")
    MSG_ID=$(python3 -c "import json; print(json.load(open('$f')).get('id',''))" 2>/dev/null || echo "")

    if [[ "$TO" == "$LOCAL_HOSTNAME" || "$TO" == "${LOCAL_HOSTNAME}.local" ]]; then
        if [[ ! -f "$INBOX/$MSG_ID.json" ]]; then
            cp "$f" "$INBOX/$MSG_ID.json"
            log "Pulled message $MSG_ID from $HOST"
            ((PULLED++))
        fi
    fi
done

log "Pull complete: $PULLED new messages from $HOST"
