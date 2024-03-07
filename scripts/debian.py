import subprocess
from common import *


def install_debian():
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
        "podman-compose",
        "python-is-python3",
        "rsync",
        "software-properties-common",
        "steam-installer",
        "tldr",
        "wget",
        "zsh",
    ]

    print("Installing system packages...")
    subprocess.run(["sudo", "apt", "install", "--yes"] + pkgs, check=True)

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
    install_gh_cli_deb()
    install_zig()
    install_vscode_deb()


def install_debian_server():
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
        "fzf",
        "lld",
        "ninja-build",
        "podman",
        "podman-compose",
        "python-is-python3",
        "rsync",
        "software-properties-common",
        "tldr",
        "wget",
        "zsh",
    ]

    print("Installing system packages...")
    subprocess.run(["sudo", "apt", "install", "--yes"] + pkgs, check=True)

    install_rust()

    install_dots()

    install_starship()
    install_fastfetch()
    install_pfetch()
    install_gh_cli_deb()
    install_zig()
