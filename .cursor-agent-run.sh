#!/usr/bin/env bash
set -euo pipefail
LOG="/home/imanarshad233/Office/Eventease/.cursor-agent-run.log"
: > "$LOG"
exec >> "$LOG" 2>&1

echo "=== $(date -Iseconds) start ==="
cd /home/imanarshad233/Office/Eventease

if git rev-parse --show-toplevel >/dev/null 2>&1; then
  echo "GIT_REPO=yes"
else
  echo "GIT_REPO=no (worktree skipped)"
fi

chmod +x script/bootstrap.sh bin/* 2>/dev/null || true

echo "=== bootstrap ==="
set +e
bash script/bootstrap.sh
BOOT=$?
set -e
echo "BOOTSTRAP_EXIT=$BOOT"

if [ "$BOOT" -ne 0 ]; then
  echo "=== post-bootstrap recovery ==="
  bundle install
  RAILS_ENV=development bundle exec rails runner 'puts :ok' || echo "RAILS_RUNNER_FAILED"
fi

if [ -f Gemfile.lock ]; then echo "GEMFILE_LOCK=exists"; else echo "GEMFILE_LOCK=missing"; fi

# Stop any existing dev on 3000
fuser -k 3000/tcp 2>/dev/null || true
pkill -f 'bin/dev' 2>/dev/null || true
sleep 2

echo "=== start bin/dev ==="
nohup bin/dev > /tmp/eventease-dev.log 2>&1 &
echo "DEV_PID=$!"

for i in $(seq 1 30); do
  HTTP=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:3000 2>/dev/null || echo "000")
  if [ "$HTTP" = "200" ] || [ "$HTTP" = "302" ] || [ "$HTTP" = "301" ]; then
    break
  fi
  sleep 2
done
echo "HTTP_CODE=${HTTP:-unknown}"

echo "=== dev log (last 80 lines) ==="
tail -80 /tmp/eventease-dev.log 2>/dev/null || true
echo "=== done ==="
