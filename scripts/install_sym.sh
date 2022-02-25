#/bin/bash

ln -sfv {dotfiles,$HOME}/.zshrc
ln -sfv {dotfiles,$HOME}/.p10k.zsh

mkdir -pv $HOME/.config/{bspwm,kitty,nvim,polybar,rofi,sxhkd}
ln -sfv {dotfiles,$HOME}/.config/bspwm/bspwmrc
ln -sfv {dotfiles,$HOME}/.config/kitty/*
ln -sfv {dotfiles,$HOME}/.config/nvim/init.vim
ln -sfv {dotfiles,$HOME}/.config/polybar/*
ln -sfv {dotfiles,$HOME}/.config/rofi/*
ln -sfv {dotfiles,$HOME}/.config/konsolerc

mkdir -pv $HOME/.local/share/konsole/
ln -sfv {dotfiles,$HOME}/.local/share/konsole/*
# mkdir -pv $HOME/.config/picom
# ln -sfv {dotfiles,$HOME}/.config/picom/picom.conf

mkdir -pv $HOME/Pictures
ln -sfv {dotfiles,$HOME}/Pictures/wallpaper.jpg
