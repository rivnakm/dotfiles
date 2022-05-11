#!/usr/bin/env bash

mkdir -pv $HOME/.config/{fish,nvim}
cp -vr dotfiles/.config/fish/* $HOME/.config/fish/
cp -v dotfiles/.config/starship.toml $HOME/.config

git clone https://github.com/mrivnak/nvim-config $HOME/.config/nvim
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'