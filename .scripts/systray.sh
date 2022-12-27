#!/bin/bash

starttray() {
    killtray
    waybar
    eww update bar0=false
    eww update bar1=false
}

killtray() {
    killall waybar
    eww update bar0=true
    eww update bar1=true
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
