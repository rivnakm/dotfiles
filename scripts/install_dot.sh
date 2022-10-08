#!/usr/bin/env bash

mkdir -pv $HOME/.config/{fish,helix/themes}
cp -vr dotfiles/.config/fish/* $HOME/.config/fish/
cp -vr dotfiles/.config/helix/* $HOME/.config/helix/
cp -v dotfiles/.config/starship.toml $HOME/.config/

wget https://raw.githubusercontent.com/mrivnak/github-helix-theme/main/github_dark.toml -O $HOME/.config/helix/themes/github_dark.toml