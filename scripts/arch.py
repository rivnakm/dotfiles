import shutil
import subprocess

from common import *


def install_arch():
    subprocess.run(
        ["sudo", "pacman", "-Syu", "--needed", "--noconfirm", "python"], check=True
    )

    subprocess.run(
        ["sudo", "python", f"{dotfiles_dir}/scripts/arch/set_makeopts.py"], check=True
    )
    subprocess.run(
        ["sudo", "python", f"{dotfiles_dir}/scripts/arch/enable_multilib.py"],
        check=True,
    )

    subprocess.run(
        [
            "sudo",
            "pacman",
            "-Syu",
            "--needed",
            "--noconfirm",
            "base-devel",
            "rustup",
            "git",
        ],
        check=True,
    )
    subprocess.run(["rustup", "default", "stable"], check=True)
    subprocess.run(
        ["git", "clone", "https://aur.archlinux.org/paru.git"], cwd="/tmp", check=True
    )
    subprocess.run(["makepkg", "-si"], cwd="/tmp/paru", check=True)
    shutil.rmtree("/tmp/paru")

    pkgs = [
        "clang",
        "cmake",
        "curl",
        "fastfetch",
        "flatpak",
        "fzf",
        "gimp",
        "github-cli",
        "gitkraken",
        "godot",
        "krita",
        "lld",
        "lutris",
        "neovide-git",
        "neovim-git",
        "ninja",
        "obsidian",
        "pfetch-rs",
        "podman",
        "podman-compose",
        "proton-ge-custom-bin",
        "ripgrep",
        "rsync",
        "starship",
        "steam",
        "tldr",
        "ttf-cascadia-mono-nerd"
        "visual-studio-code-bin",
        "wget",
        "wine-valve",
        "zig-git",
        "zls-git",
        "zsh",
    ]

    print("Installing system packages...")
    subprocess.run(["paru", "-S", "--needed", "--noconfirm"] + pkgs, check=True)

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
        "com.discordapp.Discord",
        "com.microsoft.Edge",
        "com.prusa3d.PrusaSlicer",
        "com.spotify.Client",
        "org.blender.Blender",
        "org.prismlauncher.PrismLauncher",
        "tv.plex.PlexDesktop",
    ]

    for flatpak in flatpaks:
        subprocess.run(["flatpak", "install", "flathub", flatpak, "-y"], check=True)

    install_dots()
    install_kde()
    install_fonts()
