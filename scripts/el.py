import subprocess
from common import *

def install_al9_server():
    subprocess.run(
        ["sudo", "dnf", "upgrade", "-y"],
        check=True,
    )
    subprocess.run(["sudo", "dnf", "install", "-y", "dnf-command(config-manager)"], check=True)
    subprocess.run(["sudo", "dnf", "config-manager", "--set-enabled", "crb"], check=True)

    pkgs = [
        "clang",
        "cmake",
        "curl",
        "flatpak",
        "gcc",
        "gcc-c++",
        "git",
        "lld",
        "ninja-build",
        "podman",
        "python3-pip",
        "rsync",
        "wget",
        "zsh",
    ]

    print("Installing system packages...")
    subprocess.run(["sudo", "dnf", "install", "-y"] + pkgs, check=True)

    print("Installing podman-compose...")
    subprocess.run(["pip3", "install", "--user", "podman-compose"], check=True)

    print("Installing tldr...")
    subprocess.run(["pip3", "install", "--user", "tldr"], check=True)

    install_rust()

    install_dots()

    install_starship()
    install_fastfetch()
    install_pfetch()
    install_gh_cli_rpm()
    install_zig()
    install_fzf()
