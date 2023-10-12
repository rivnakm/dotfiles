#!/usr/bin/env bash

mkdir -pv $HOME/.config
mkdir -pv $HOME/.local/share/{konsole,plasma-systemmonitor}
cp -v dotfiles/.config/{konsolerc,systemmonitorrc} $HOME/.config/
cp -vr dotfiles/.local/share/konsole/* $HOME/.local/share/konsole/
cp -vr dotfiles/.local/share/plasma-systemmonitor/* $HOME/.local/share/plasma-systemmonitor/
