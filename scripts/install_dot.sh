#!/usr/bin/env bash

# Get location of dotfiles dynamically
SCRIPT_PATH="${BASH_SOURCE}"
while [ -L "${SCRIPT_PATH}" ]; do
  SCRIPT_DIR="$(cd -P "$(dirname "${SCRIPT_PATH}")" >/dev/null 2>&1 && pwd)"
  SCRIPT_PATH="$(readlink "${SCRIPT_PATH}")"
  [[ ${SCRIPT_PATH} != /* ]] && SCRIPT_PATH="${SCRIPT_DIR}/${SCRIPT_PATH}"
done
SCRIPT_PATH="$(readlink -f "${SCRIPT_PATH}")"
SCRIPT_DIR="$(cd -P "$(dirname -- "${SCRIPT_PATH}")" >/dev/null 2>&1 && pwd)"
DOTFILES_DIR="$(dirname "${SCRIPT_DIR}")"

# Install files
mkdir -pv $HOME/.config/fish
cp -vr $DOTFILES_DIR/.config/fish/* $HOME/.config/fish/

mkdir -pv $HOME/.config/bottom
cp -vr $DOTFILES_DIR/.config/bottom/* $HOME/.config/bottom/

mkdir -pv $HOME/.config/tmux
cp -vr $DOTFILES_DIR/.config/tmux/* $HOME/.config/tmux

cp -v $DOTFILES_DIR/.config/starship.toml $HOME/.config/

git clone https://github.com/mrivnak/neovim-config ~/.config/nvim

