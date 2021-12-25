#!/bin/bash

up() {
    mpc volume +5
    notify-send -t 2000 -a System "MPD" "$(mpc | tail -n1 | awk -F ' ' '{ print $2 }')"
}

down() {
    mpc volume -5
    notify-send -t 2000 -a System "MPD" "$(mpc | tail -n1 | awk -F ' ' '{ print $2 }')"
}

player() {
    urxvt -title Music -g 130x34-320+16 -st -fn "xft:Meslo LG S Nerd Font:size=12" -e ncmpcpp & disown
}

case "$1" in
    -u) up ;;
    -d) down ;;
    -p) player ;;
esac
