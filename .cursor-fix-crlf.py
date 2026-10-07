#!/usr/bin/env python3
import os
from pathlib import Path

root = Path("/home/imanarshad233/Office/Eventease")
dirs = [root / "bin", root / "script"]
fixed = 0
for d in dirs:
    if not d.is_dir():
        continue
    for p in d.rglob("*"):
        if not p.is_file():
            continue
        data = p.read_bytes()
        if b"\r" not in data:
            continue
        p.write_bytes(data.replace(b"\r\n", b"\n").replace(b"\r", b"\n"))
        fixed += 1
        if p.stat().st_mode & 0o111 or p.suffix == ".sh":
            os.chmod(p, p.stat().st_mode | 0o111)
print(f"fixed {fixed} files")
