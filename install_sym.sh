#/bin/bash

ln -sv {dotfiles,$HOME}/.zshrc
ln -sv {dotfiles,$HOME}/.p10k.zsh
mkdir -pv $HOME/.config/nvim
ln -sv {dotfiles,$HOME}/.config/nvim/init.vim
mkdir -pv $HOME/.xmonad
ln -sv {dotfiles,$HOME}/.xmonad/xmonad.hs
mkdir -pv $HOME/.config/picom
ln -sv {dotfiles,$HOME}/.config/picom/picom.conf
