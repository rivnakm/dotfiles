#!/usr/bin/env bash

mkdir -pv $HOME/.config/fish
cp -vr dotfiles/.config/fish/* $HOME/.config/fish/

# mkdir -pv $HOME/.config/helix
# cp -vr dotfiles/.config/helix/* $HOME/.config/helix/

mkdir -pv $HOME/.config/bottom
cp -vr dotfiles/.config/bottom/* $HOME/.config/bottom/

mkdir -pv $HOME/.config/tmux
cp -vr dotfiles/.config/tmux/* $HOME/.config/tmux

cp -v dotfiles/.config/starship.toml $HOME/.config/

# wget https://raw.githubusercontent.com/mrivnak/github-helix-theme/main/github_dark.toml -O $HOME/.config/helix/themes/github_dark.toml

sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
nvim -c PlugInstall

