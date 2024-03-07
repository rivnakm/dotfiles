import os
import sys

if os.geteuid() != 0:
    print("Script must be run as root", file=sys.stderr)

def set_makeopts():
    lines = []
    with open("/etc/makepkg.conf", "r", encoding="utf-8") as f:
        lines = f.readlines()

    with open("/etc/makepkg.conf", "w", encoding="utf-8") as f:
        for i, line in enumerate(lines):
            if line.startswith("#MAKEFLAGS"):
                lines[i] = f"MAKEFLAGS=\"-j{os.cpu_count()}\"\n"
                break

        f.writelines(lines)

set_makeopts()
