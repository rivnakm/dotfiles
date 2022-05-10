#!/usr/bin/env bash

mkdir -pv $HOME/.config/{fish,nvim}
cp -vr dotfiles/.config/nvim/* $HOME/.config/nvim/
cp -vr dotfiles/.config/fish/* $HOME/.config/fish/
cp -v dotfiles/.config/starship.toml $HOME/.config
