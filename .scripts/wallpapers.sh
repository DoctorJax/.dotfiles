#!/bin/bash

random() {
    randomwall="$(find ~/wallpapers -name '*.jpg' -type f | shuf -n 1)"
    feh --bg-fill -z "$randomwall"
    printf "Random background has been chosen."
}

restore() {
    "$HOME"/.fehbg
    printf "Background has been restored."
}

setwall=$2
setbg() {
    feh --bg-fill -z "$setwall"
    printf "Background has been set to $setwall."
}

help() {
    printf "\n Type -i for restore, -s to set new, or -r for random \n"
}

case "$1" in
    -i) restore ;;
    -r) random ;;
    -s) setbg ;;
    -h) help ;;
esac
