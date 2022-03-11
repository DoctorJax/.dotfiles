#!/bin/bash

up() {
    mpc volume +5
    notify-send -t 2000 -a System "MPD" "$(mpc | tail -n1 | awk -F ' ' '{ print $2 }')"
}

down() {
    mpc volume -5
    notify-send -t 2000 -a System "MPD" "$(mpc | tail -n1 | awk -F ' ' '{ print $2 }')"
}

player() {
    alacritty -e ncmpcpp
}

loadfavorites() {
    mpc clear
    mpc load favorites
    mpc shuffle
    notify-send -t 2000 -a System "MPD" "Playlist: Favorites"
}

loadstreambeats() {
    mpc clear
    mpc load streambeats
    mpc shuffle
    notify-send -t 2000 -a System "MPD" "Playlist: StreamBeats"
}

case "$1" in
    -u) up ;;
    -d) down ;;
    -p) player ;;
    -f) loadfavorites ;;
    -s) loadstreambeats ;;
esac
