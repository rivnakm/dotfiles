#!/bin/bash
#  ____ _____
# |  _ \_   _|  Derek Taylor (DistroTube)
# | | | || |    http://www.youtube.com/c/DistroTube
# | |_| || |    http://www.gitlab.com/dwt1/
# |____/ |_|
#
# Dmenu script for editing some of my more frequently edited config files.


declare options=("compton
editor
i3
i3status
kde
polybar
rofi
vim
zsh")

choice=$(echo -e "${options[@]}" | rofi -i -dmenu -p "Edit a config file: " -font "Hack 10" )

case "$choice" in
	quit)
		echo "Program terminated." && exit 1
	;;
	compton)
		choice="$HOME/.config/compton/compton.conf"
	;;
	editor)
		choice="$HOME/.config/dmenu/dmenu-edit-configs.sh"
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
	rofi)
		choice="$HOME/.config/rofi/config.rasi"
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
