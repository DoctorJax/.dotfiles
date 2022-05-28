#!/bin/bash

delay="750"

if [[ -n "$2" ]]
then
    delay="$2"
fi

killxdotool() {
    pkill -9 xdotool
    notify-send -t 2000 -a System "Macro" "Killed Xdotool"
}

mobgrinder() {
    notify-send -t 2000 -a System "Macro" "Mob Grinder: Activated With $delay Delay"
    xdotool click --repeat 1000000 --delay $delay --window $(xdotool getactivewindow) 1
    notify-send -t 2000 -a System "Macro" "Mob Grinder: Deactivated"
}

case "$1" in
    -k) killxdotool ;;
    -m) mobgrinder ;;
esac
