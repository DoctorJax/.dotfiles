#!/bin/bash

killxdotool() {
    pkill -9 xdotool
    notify-send -t 2000 -a System "Macro" "Killed Xdotool"
}

mobgrinder() {
    notify-send -t 2000 -a System "Macro" "Mob Grinder: Activated"
    xdotool click --repeat 1000 --delay 750 1
    notify-send -t 2000 -a System "Macro" "Mob Grinder: Deactivated"
}

case "$1" in
    -k) killxdotool ;;
    -m) mobgrinder ;;
esac
