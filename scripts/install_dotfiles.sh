#!/usr/bin/env bash

# Get location of dotfiles dynamically
SCRIPT_PATH=$BASH_SOURCE
DOTFILES_DIR="$(dirname $(dirname $SCRIPT_PATH))"

# Install files
# Fish
# Fisher
curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher

# Fish plugins
fisher install jorgebucaran/autopair.fish
fisher install jorgebucaran/replay.fish
fisher install catppuccin/fish

mkdir -pv $HOME/.config/fish
cp -vr $DOTFILES_DIR/.config/fish/* $HOME/.config/fish/

# Bottom
mkdir -pv $HOME/.config/bottom
cp -vr $DOTFILES_DIR/.config/bottom/* $HOME/.config/bottom/

# Tmux
mkdir -pv $HOME/.config/tmux
cp -vr $DOTFILES_DIR/.config/tmux/* $HOME/.config/tmux

# Starship
cp -v $DOTFILES_DIR/.config/starship.toml $HOME/.config/

# Neovim
if [ -d $HOME/.config/nvim ]; then
    pushd $HOME/.config/nvim; git pull; popd
else
    git clone https://github.com/mrivnak/neovim-config $HOME/.config/nvim
fi

