import subprocess
from common import *


def install_ubuntu():
    subprocess.run(["sudo", "dpkg", "--add-architecture", "i386"], check=True)
    subprocess.run(
        ["sudo", "apt", "update"],
        check=True,
    )
    subprocess.run(
        ["sudo", "apt", "upgrade", "-y"],
        check=True,
    )

    pkgs = [
        "build-essential",
        "clang",
        "cmake",
        "curl",
        "flatpak",
        "fzf",
        "gimp",
        "krita",
        "lld",
        "lutris",
        "ninja-build",
        "podman",
        "python-is-python3",
        "python3-pip",
        "rsync",
        "software-properties-common",
        "steam-installer",
        "tldr",
        "wget",
        "zsh",
    ]

    print("Installing system packages...")
    subprocess.run(["sudo", "apt", "install", "--yes"] + pkgs, check=True)

    print("Installing podman-compose...")
    subprocess.run(["pip3", "install", "--user", "podman-compose"], check=True)
    
    print("Installing Rust...")
    install_rust()

    print("Installing flatpaks...")
    subprocess.run(
        [
            "flatpak",
            "remote-add",
            "--if-not-exists",
            "flathub",
            "https://flathub.org/repo/flathub.flatpakrepo",
        ],
        check=True,
    )
    flatpaks = [
        "com.microsoft.Edge",
        "org.prismlauncher.PrismLauncher",
    ]

    for flatpak in flatpaks:
        subprocess.run(["flatpak", "install", "flathub", flatpak, "-y"], check=True)

    print("Installing snaps...")
    snaps = [
        ["blender", "--classic"],
        ["discord"],
        ["gitkraken", "--classic"],
        ["godot-4"],
        ["plex-desktop"],
        ["prusa-slicer"],
        ["spotify"],
    ]
    for snap in snaps:
        subprocess.run(["sudo", "snap", "install"] + snap, check=True)

    install_dots()
    install_kde()
    install_fonts()

    install_starship()
    install_fastfetch()
    install_pfetch()
    install_gh_cli_deb()
    install_zig()
    install_vscode_deb()

def install_ubuntu_server():
    subprocess.run(["sudo", "dpkg", "--add-architecture", "i386"], check=True)
    subprocess.run(
        ["sudo", "apt", "update"],
        check=True,
    )
    subprocess.run(
        ["sudo", "apt", "upgrade", "-y"],
        check=True,
    )

    pkgs = [
        "build-essential",
        "clang",
        "cmake",
        "curl",
        "flatpak",
        "fzf",
        "lld",
        "ninja-build",
        "podman",
        "python-is-python3",
        "python3-pip",
        "rsync",
        "software-properties-common",
        "tldr",
        "wget",
        "zsh",
    ]

    print("Installing system packages...")
    subprocess.run(["sudo", "apt", "install", "--yes"] + pkgs, check=True)

    print("Installing podman-compose...")
    subprocess.run(["pip3", "install", "--user", "podman-compose"], check=True)
    
    print("Installing Rust...")
    install_rust()

    install_dots()

    install_starship()
    install_fastfetch()
    install_pfetch()
    install_gh_cli_deb()
    install_zig()
