import os
import sys

if os.geteuid() != 0:
    print("Script must be run as root", file=sys.stderr)

def enable_multilib():
    lines = []
    with open("/etc/pacman.conf", "r", encoding="utf-8") as f:
        lines = f.readlines()
        if "[multilib]\n" in lines:
            return

    with open("/etc/pacman.conf", "w", encoding="utf-8") as f:
        for i, line in enumerate(lines):
            if line.startswith("#[multilib]"):
                lines[i] = "[multilib]\n"
                lines[i + 1] = "Include = /etc/pacman.d/mirrorlist\n"
                f.writelines(lines)
                return

        lines.append("[multilib]\n")
        lines.append("Include = /etc/pacman.d/mirrorlist\n")
        print("Multilib enabled at the end")

        f.writelines(lines)

enable_multilib()
