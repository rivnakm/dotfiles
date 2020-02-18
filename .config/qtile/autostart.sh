#! /bin/bash 
picom &
wmctrl -lp | awk '/Desktop — Plasma/{print $3}' | xargs kill
nitrogen --restore &
urxvtd -q -o -f &

nitrogen --restore &
