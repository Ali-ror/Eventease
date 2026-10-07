#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."

chmod +x bin/*

echo "== bundle install =="
bundle install

echo "== tailwindcss:install =="
bin/rails tailwindcss:install || true

echo "== importmap (vendor JS) =="
bin/importmap pin @hotwired/turbo-rails @hotwired/stimulus @hotwired/stimulus-loading

echo "== credentials =="
test -f config/master.key || bin/rails credentials:edit --environment development 2>/dev/null || EDITOR=true bin/rails secret > /dev/null

echo "== db:create =="
bin/rails db:create

echo "== tailwindcss:build =="
bin/rails tailwindcss:build

echo "Bootstrap complete."
