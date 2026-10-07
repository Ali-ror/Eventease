#!/usr/bin/env python3
content = r"""#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."

chmod +x bin/*

echo "== bundle install =="
bundle install

echo "== tailwindcss:install =="
bin/rails tailwindcss:install || true

echo "== importmap (vendor JS) =="
bin/rails importmap:install || true

echo "== credentials =="
test -f config/master.key || bin/rails credentials:edit --environment development 2>/dev/null || EDITOR=true bin/rails secret > /dev/null

echo "== db:create =="
bin/rails db:create

echo "== tailwindcss:build =="
bin/rails tailwindcss:build

echo "Bootstrap complete."
"""
path = "/home/imanarshad233/Office/Eventease/script/bootstrap.sh"
with open(path, "w", newline="\n") as f:
    f.write(content)
import os
os.chmod(path, 0o755)
print("wrote", path, open(path).readline().strip())
