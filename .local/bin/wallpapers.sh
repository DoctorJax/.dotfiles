#!/bin/bash

random() {
    randomwall="$(find ~/wallpapers -name '*.jpg' -type f | shuf -n 1)"
    nitrogen --head=0 --set-zoom-fill "$randomwall"
    nitrogen --head=1 --set-zoom-fill "$randomwall"
    wal -n -i "$randomwall" &> /dev/null
    echo "$randomwall" > "$HOME"/.cache/randomwall
    echo 'awesome.restart()' | awesome-client
    printf "Random background has been chosen."
}

restore() {
    restorewall="$(cat "$HOME"/.cache/randomwall)"
    nitrogen --head=0 --set-zoom-fill "$restorewall"
    nitrogen --head=1 --set-zoom-fill "$restorewall"
    wal -n -i "$restorewall" &> /dev/null
    printf "Background has been restored."
}

setwall=$2
setbg() {
    nitrogen --head=0 --set-zoom-fill "$setwall"
    nitrogen --head=1 --set-zoom-fill "$setwall"
    wal -n -i "$setwall" &> /dev/null
    echo "$setwall" > "$HOME"/.cache/randomwall
    echo 'awesome.restart()' | awesome-client
    printf "Background has been set to $setwall."
}

help() {
    printf "Type -i for restore, -s to set new, or -r for random"
}

case "$1" in
    -i) restore ;;
    -r) random ;;
    -s) setbg ;;
    -h) help ;;
esac
