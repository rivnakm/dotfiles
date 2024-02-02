#!/usr/bin/env bash

cmds=("git" "curl" "zsh" "cargo" "cmake" "make" "cc")

echo "Checking script requirements"
for cmd in "${cmds[@]}"; do
    if command -v "$cmd" &> /dev/null; then
        echo "$cmd found"
    else
        echo "Error: '$cmd' command not found."
        exit 1
    fi
done

$HOME/dotfiles/scripts/install_dotfiles.sh
$HOME/dotfiles/scripts/install_fonts.sh
$HOME/dotfiles/scripts/install_fetch.sh
$HOME/dotfiles/scripts/install_kde.sh
