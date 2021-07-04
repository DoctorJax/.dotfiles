#!/bin/bash

set -euo pipefail

random() {
    randomwall="$(find ~/wallpapers -name '*.jpg' -type f | shuf -n 1)"
    nitrogen --head=0 --set-zoom-fill "$randomwall"
    nitrogen --head=1 --set-zoom-fill "$randomwall"
    wal -n -i "$randomwall"
    echo "$randomwall" > "$HOME"/.cache/randomwall
    echo 'awesome.restart()' | awesome-client
}

restore() {
    restorewall="$(cat "$HOME"/.cache/randomwall)"
    nitrogen --head=0 --set-zoom-fill "$restorewall"
    nitrogen --head=1 --set-zoom-fill "$restorewall"
    wal -n -i "$restorewall"
}

setbg() {
    read -p "Enter wallpaper path: " setwall
    nitrogen --head=0 --set-zoom-fill "$setwall"
    nitrogen --head=1 --set-zoom-fill "$setwall"
    wal -n -i "$setwall"
    echo "$setwall" > "$HOME"/.cache/randomwall
    echo 'awesome.restart()' | awesome-client
}

help() {
    printf "Type -i for restore, -d to set new, or -r for random"
}

noOpt=1
while getopts "hdrim" opt; do
    case "$opt" in
        i) restore ;;
        r) random ;;
        d) setbg ;;
	*) printf "## Invalid option ##\nType -i for restore, -d to set new, or -r for random" ;;
    esac
    noOpt=0
done
[ $noOpt = 1 ] && help
