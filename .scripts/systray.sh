#!/bin/bash

EWW="eww"

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
    if [[ $(${EWW} state | grep 'bar: false') ]]; then
        ${EWW} update bar=true
    else
        ${EWW} update bar=false
    fi
}

notif() {
    if [[ $(${EWW} state | grep 'rightside: false') ]]; then
        ${EWW} update rightside=true
    else
        ${EWW} update rightside=false
    fi
}

case "$1" in
    -s ) starttray ;;
    -k ) killtray ;;
    -t ) toggle ;;
    -b ) bars ;;
    -n ) notif ;;
esac
