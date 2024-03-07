import subprocess
from common import *


def install_fedora():
    subprocess.run(
        "sudo dnf install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm",
        shell=True,
        check=True,
    )
    subprocess.run(
        ["sudo", "dnf", "install", "dnf-command(config-manager)", "-y"], check=True
    )
    subprocess.run(
        ["sudo", "dnf", "config-manager", "--enable", "-y", "fedora-cisco-openh264"],
        check=True,
    )
    subprocess.run(
        ["sudo", "dnf", "upgrade", "-y"],
        check=True,
    )

    pkgs = [
        "clang",
        "cmake",
        "curl",
        "flatpak",
        "fzf",
        "gcc",
        "gcc-c++",
        "git",
        "gimp",
        "krita",
        "lld",
        "lutris",
        "ninja-build",
        "podman",
        "podman-compose",
        "rsync",
        "steam",
        "tldr",
        "wget",
        "xz",
        "zsh",
    ]

    print("Installing system packages...")
    subprocess.run(["sudo", "dnf", "install", "-y"] + pkgs, check=True)

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
        "com.axosoft.GitKraken",
        "com.discordapp.Discord",
        "com.microsoft.Edge",
        "com.prusa3d.PrusaSlicer",
        "com.spotify.Client",
        "org.blender.Blender",
        "org.godotengine.Godot",
        "org.prismlauncher.PrismLauncher",
        "tv.plex.PlexDesktop",
    ]

    for flatpak in flatpaks:
        subprocess.run(["flatpak", "install", "flathub", flatpak, "-y"], check=True)

    install_dots()
    install_kde()
    install_fonts()

    install_starship()
    install_fastfetch()
    install_pfetch()
    install_gh_cli_rpm()
    install_zig()
    install_vscode_rpm()


def install_fedora_server():
    subprocess.run(
        ["sudo", "dnf", "upgrade", "-y"],
        check=True,
    )

    pkgs = [
        "clang",
        "cmake",
        "curl",
        "flatpak",
        "fzf",
        "gcc",
        "gcc-c++",
        "git",
        "lld",
        "ninja-build",
        "podman",
        "podman-compose",
        "rsync",
        "tldr",
        "wget",
        "xz",
        "zsh",
    ]

    print("Installing system packages...")
    subprocess.run(["sudo", "dnf", "install", "-y"] + pkgs, check=True)

    install_rust()

    install_dots()

    install_starship()
    install_fastfetch()
    install_pfetch()
    install_gh_cli_rpm()
    install_zig()
