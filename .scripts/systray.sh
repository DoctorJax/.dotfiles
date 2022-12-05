#!/bin/bash

starttray() {
    killtray
    waybar
}

killtray() {
    killall waybar
}

toggle() {
    if [[ ! $(pidof waybar) ]]; then
        starttray
    else
        killtray
    fi
}

case "$1" in
    -s ) starttray ;;
    -k ) killtray ;;
    -t ) toggle ;;
esac
