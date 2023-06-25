#!/usr/bin/env bash

mkdir -pv $HOME/.config
mkdir -pv $HOME/.local/share/{konsole,plasma-systemmonitor}
cp -v dotfiles/.config/{konsolerc,systemmonitorrc} $HOME/.config/
cp -vr dotfiles/.local/share/konsole/* $HOME/.local/share/konsole/
cp -vr dotfiles/.local/share/plasma-systemmonitor/* $HOME/.local/share/plasma-systemmonitor/
curl -o $HOME/.local/share/konsole/github_dark_default.colorscheme https://raw.githubusercontent.com/projekt0n/github-theme-contrib/main/konsole/github_dark_default.colorscheme
