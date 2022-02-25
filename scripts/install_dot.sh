#/bin/bash

cp -v {dotfiles,$HOME}/.zshrc
cp -v {dotfiles,$HOME}/.p10k.zsh

mkdir -pv $HOME/.config/{bspwm,kitty,nvim,polybar,rofi,sxhkd}
cp -v {dotfiles,$HOME}/.config/bspwm/bspwmrc
cp -v {dotfiles,$HOME}/.config/kitty/kitty.conf
cp -v {dotfiles,$HOME}/.config/kitty/nord.conf
cp -v {dotfiles,$HOME}/.config/nvim/init.vim
cp -v {dotfiles,$HOME}/.config/polybar/config
cp -v {dotfiles,$HOME}/.config/polybar/launch.sh
cp -v {dotfiles,$HOME}/.config/rofi/config.rasi
cp -v {dotfiles,$HOME}/.config/rofi/nord.rasi
cp -v {dotfiles,$HOME}/.config/konsolerc

mkdir -pv $HOME/.local/share/konsole/
cp -v {dotfiles,$HOME}/.local/share/konsole/*
# mkdir -pv $HOME/.config/picom
# cp -v {dotfiles,$HOME}/.config/picom/picom.conf

mkdir -pv $HOME/Pictures
cp -v {dotfiles,$HOME}/Pictures/wallpaper.jpg
