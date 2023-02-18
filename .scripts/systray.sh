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

notif() {
    if [[ $(eww state | grep 'rightside: false') ]]; then
        eww update rightside=true
    else
        eww update rightside=false
    fi
}

case "$1" in
    -s ) starttray ;;
    -k ) killtray ;;
    -t ) toggle ;;
    -b ) bars ;;
    -n ) notif ;;
esac
