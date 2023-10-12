#!/usr/bin/env bash

mkdir -pv $HOME/.config
mkdir -pv $HOME/.local/share/konsole
cp -v dotfiles/.config/konsolerc $HOME/.config/
cp -vr dotfiles/.local/share/konsole/* $HOME/.local/share/konsole/
