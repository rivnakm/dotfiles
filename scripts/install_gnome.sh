#!/usr/bin/env bash
dconf reset -f /org/gnome/terminal/legacy/profiles:/ && dconf load /org/gnome/terminal/legacy/profiles:/ < $HOME/dotfiles/gnome-terminal-profiles.dconf 