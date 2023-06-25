#!/usr/bin/env bash

# Get location of dotfiles dynamically
SCRIPT_PATH=$BASH_SOURCE
DOTFILES_DIR="$(dirname $(dirname $SCRIPT_PATH))"
ZSH_CUSTOM=$HOME/.oh-my-zsh/custom

# Install files
cp -vr $DOTFILES_DIR/.zshrc $HOME/

# Bottom
mkdir -pv $HOME/.config/bottom
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

# Zsh plugins
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

