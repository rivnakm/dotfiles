#!/bin/bash
#  __  __ ____  
# |  \/  |  _ \ 
# | |\/| | |_) |
# | |  | |  _ < 
# |_|  |_|_| \_\
#
# Michael Rivnak
# [https://github.com/mrivnak]
#
# Dmenu script for editing some of my more frequently edited config files.


declare options=("editor
i3
i3status
kde
picom
polybar
rofi
vim
zsh")

choice=$(echo -e "${options[@]}" | dmenu -nf '#F8F8F2' -nb '#282A36' -sb '#6272A4' -sf '#F8F8F2' -fn 'Hack-10' -i -p 'Edit a config file: ')
# choice=$(echo -e "${options[@]}" | rofi -i -dmenu -p "Edit a config file: " -font "Hack 10" )

case "$choice" in
	quit)
		echo "Program terminated." && exit 1
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
	picom)
		choice="$HOME/.config/picom.conf"
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
codium "$choice"
