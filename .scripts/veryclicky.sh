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

rightclick() {
    case "$3" in
        spam)
            notify-send -t 2000 -a System "Macro" "Rightclick: Spam"
            xdotool click --repeat 1000000 --delay $delay --window $(xdotool getactivewindow) 3
            notify-send -t 2000 -a System "Macro" "Rightclick: Deactivated"
        ;;
        hold)
            notify-send -t 2000 -a System "Macro" "Rightclick: Hold"
            xdotool mousedown --window $(xdotool getactivewindow) 3
        ;;
    esac
}

case "$1" in
    -k) killxdotool ;;
    -m) mobgrinder ;;
    -r) rightclick "$@" ;;
esac
