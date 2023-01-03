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

bars() {
    if [[ $(eww state | grep 'bar: false') ]]; then
        eww update bar=true
    else
        eww update bar=false
    fi
}

case "$1" in
    -s ) starttray ;;
    -k ) killtray ;;
    -t ) toggle ;;
    -b ) bars ;;
esac
