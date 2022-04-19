#!/usr/bin/env bash

$HOME/dotfiles/scripts/install_dot.sh
$HOME/dotfiles/scripts/install_fonts.sh
$HOME/dotfiles/scripts/install_fetch.sh

chsh -s $(which fish)