#!/bin/bash
#  ____ _____
# |  _ \_   _|  Derek Taylor (DistroTube)
# | | | || |    http://www.youtube.com/c/DistroTube
# | |_| || |    http://www.gitlab.com/dwt1/
# |____/ |_|
#
# Dmenu script for editing some of my more frequently edited config files.


declare options=("
i3
i3status
kde
polybar
vim
zsh")

choice=$(echo -e "${options[@]}" | dmenu -nf '#F8F8F2' -nb '#282A36' -sb '#6272A4' -sf '#F8F8F2' -fn 'Hack-10' -i -p 'Edit a config file: ')

case "$choice" in
	quit)
		echo "Program terminated." && exit 1
	;;
	i3)
		choice="$HOME/.config/i3/config"
	;;
	i3status)
		choice="$HOME/.config/i3status/config"
	;;
    kde)
		choice="$HOME/.config/plasma-workspace/env/wm.sh"
	;;
	polybar)
		choice="$HOME/.config/polybar/config"
	;;
    vim)
		choice="$HOME/.vimrc"
	;;
	zsh)
		choice="$HOME/.zshrc"
	;;
	*)
		exit 1
	;;
esac
code "$choice"