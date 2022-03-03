#/bin/bash

cp -v $HOME/{dotfiles/,}.zshrc
cp -v $HOME/{dotfiles/,}.p10k.zsh

mkdir -pv $HOME/.config
cp -v $HOME/{dotfiles/,}.config/konsolerc
mkdir -pv $HOME/.local/share/konsolerc
cp -v $HOME/{dotfiles/,}.local/share/konsole/RDark.profile
cp -v $HOME/{dotfiles/,}.local/share/konsole/RDark.colorscheme

# mkdir -pv $HOME/.config/{bspwm,kitty,nvim,polybar,rofi,sxhkd}
# cp -v $HOME/{dotfiles/,}.config/bspwm/bspwmrc
# cp -v $HOME/{dotfiles/,}.config/kitty/kitty.conf
# cp -v $HOME/{dotfiles/,}.config/kitty/onedark.conf
# cp -v $HOME/{dotfiles/,}.config/nvim/init.vim
# cp -v $HOME/{dotfiles/,}.config/polybar/config
# cp -v $HOME/{dotfiles/,}.config/polybar/launch.sh
# cp -v $HOME/{dotfiles/,}.config/rofi/config.rasi
# cp -v $HOME/{dotfiles/,}.config/rofi/onedark.rasi
# cp -v $HOME/{dotfiles/,}.config/sxhkd/sxhkdrc

# mkdir -pv $HOME/.config/picom
# cp -v $HOME/{dotfiles/,}.config/picom/picom.conf

# mkdir -pv $HOME/Pictures
# cp -v $HOME/{dotfiles/,}Pictures/wallpaper.jpg
