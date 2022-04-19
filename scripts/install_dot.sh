#/usr/bin/env bash

mkdir -pv $HOME/.config
cp -vr $HOME/{dotfiles/,}.config/nvim
cp -vr $HOME/{dotfiles/,}.config/fish
cp -v $HOME/{dotfiles/,}.config/starship.toml
