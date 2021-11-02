#!/usr/bin/python3

import os
import shutil
import subprocess
import sys

from pathlib import Path
from shutil import copyfile, SameFileError

def print_full(result: subprocess.CompletedProcess) -> None:
    print(result.stdout)
    print(result.stderr, file=sys.stderr)


def confirm(prompt, default=True):
    tries = 2
    while tries > 0:
        val = input("{} {}".format(prompt, "[Y/n]" if default else "[y/N]"))

        if (default and val == "") or val.lower() == "y":
            return True
        elif (not default and val == "") or val.lower() == "n":
            print("Skipping...")
            return False
        else:
            print("Unexpected input, try again...")
            tries -= 1

    return False


def check_deps(deps):
    print("Checking dependencies...")

    for dep in deps:
        process = subprocess.run(["which", dep], capture_output=True, text=True)
        if process.returncode != 0:
            print(process.stderr, file=sys.stderr)
            return False

    return True


def install_dotfiles():
    print("Installing dotfiles...")

    dotfiles_path = Path.home() / "dotfiles"
    if dotfiles_path.exists():
        # shutil.rmtree(dotfiles_path)
        pass

    process = subprocess.run(
        ["git", "clone", "https://github.com/mrivnak/dotfiles.git"],
        capture_output=True,
        text=True,
    )
    print_full(process)

    for file in [".zshrc", ".p10k.zsh", ".vimrc", "cat"]:
        try:
            copyfile(f"dotfiles/{file}", Path.home() / file)
        except SameFileError:
            # Ignore if the files are the same
            print(f"Warning: files dotfiles/{file} and ~/{file} are the same, skipping...")
            pass


def install_fonts():
    if confirm("Do you want to install fonts?"):
        print("Installing fonts...")

        font_path = Path.home() / ".fonts" / "Hack Nerd Font"

        try:
            font_path.mkdir()
        except FileExistsError:
            pass

        zip_path = font_path / "Hack.zip"
        process = subprocess.run(  # Download hack nerd font zip file
            [
                "wget",
                "-O",
                f"{zip_path}",
                "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Hack.zip",
            ],
            capture_output=True,
            text=True,
        )
        print_full(process)
        process = subprocess.run(  # Extract zip file
            ["unzip", "-o", "-d", f"{font_path}", f"{zip_path}"],
            capture_output=True,
            text=True,
        )
        print_full(process)

        zip_path.unlink()  # Delete zip file


def install_fetch():
    if confirm("Do you want to install neo/pfetch?"):
        for fetch in ["neofetch", "pfetch"]:
            print(f"Installing {fetch}...")

            fetch_path = Path("/tmp") / fetch

            process = subprocess.run(
                [
                    "git",
                    "clone",
                    f"https://github.com/dylanaraps/{fetch}.git",
                    fetch_path,
                ],
                capture_output=True,
                text=True,
            )
            print_full(process)

            process = subprocess.run(
                ["sudo", "make", "install"],
                capture_output=True,
                text=True,
                cwd=fetch_path,
            )
            print_full(process)


def install_omz():
    print("Installing Oh My Zsh...")

    omz_env = os.environ.copy()
    omz_env["CHSH"] = "no"
    omz_env["RUNZSH"] = "no"
    omz_env["KEEP_ZSHRC"] = "yes"

    process = subprocess.run(
        [
            "sh",
            "-c",
            "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)",
        ],
        capture_output=True,
        text=True,
        env=omz_env,
    )
    print_full(process)


def install_omz_plugins():
    print("Installing Oh My Zsh plugins...")
    p10k_path = Path.home() / ".oh-my-zsh" / "custom" / "plugins" / "powerlevel10k"
    zsh_as_path = (
        Path.home() / ".oh-my-zsh" / "custom" / "plugins" / "zsh-autosuggestions"
    )

    process = subprocess.run(
        [
            "git",
            "clone",
            "--depth=1",
            f"https://github.com/romkatv/powerlevel10k.git",
            p10k_path,
        ],
        capture_output=True,
        text=True,
    )
    print_full(process)

    process = subprocess.run(
        [
            "git",
            "clone",
            "--depth=1",
            f"https://github.com/zsh-users/zsh-autosuggestions.git",
            zsh_as_path,
        ],
        capture_output=True,
        text=True,
    )
    print_full(process)


def install_wallpapers():
    if confirm("Do you want to install wallpapers?"):
        print("Installing wallpapers...")

        pictures_path = Path.home() / "Pictures"
        walls_path = pictures_path / "os-wallpapers"

        try:
            pictures_path.mkdir()
        except FileExistsError:
            # Ignore if directory already exists and
            pass

        process = subprocess.run(
            [
                "git",
                "clone",
                f"https://github.com/mrivnak/os-wallpapers.git",
                walls_path,
            ],
            capture_output=True,
            text=True,
        )
        print_full(process)


def chsh():
    if os.environ["SHELL"] != subprocess.check_output(
        ["which", "zsh"], text=True
    ).replace("\n", ""):
        print("Changing user shell...")
        process = subprocess.run(
            ["sudo", "usermod", "-s", subprocess.check_output(["which", "zsh"])],
            capture_output=True,
            text=True,
        )
        print_full(process)


def main():
    deps = ["curl", "git", "sudo", "unzip", "wget", "zsh"]

    if not check_deps(deps):
        print("Error: unmet dependencies", file=sys.stderr)
        sys.exit(1)

    install_dotfiles()
    install_omz()
    install_omz_plugins()
    chsh()

    install_fonts()
    install_fetch()
    install_wallpapers()


if __name__ == "__main__":
    main()
