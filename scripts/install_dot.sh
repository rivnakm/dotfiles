#!/usr/bin/env bash

mkdir -pv $HOME/.config/{fish,helix/themes,bottom,tmux}
cp -vr dotfiles/.config/fish/* $HOME/.config/fish/
cp -vr dotfiles/.config/helix/* $HOME/.config/helix/
cp -vr dotfiles/.config/bottom/* $HOME/.config/bottom/
cp -vr dotfiles/.config/tmux/* $HOME/.config/tmux
cp -v dotfiles/.config/starship.toml $HOME/.config/

wget https://raw.githubusercontent.com/mrivnak/github-helix-theme/main/github_dark.toml -O $HOME/.config/helix/themes/github_dark.toml