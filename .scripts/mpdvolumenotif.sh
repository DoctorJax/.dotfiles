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
    kitty -e ncmpcpp
}

loadstreambeats() {
    mpc clear
    mpc load streambeats
    mpc shuffle
    mpc play
    notify-send -t 2000 -a System "MPD" "Playlist: StreamBeats"
}

reloadfavorites() {
    cd ~/Music
    mpc clear
    mpc rm favorites
    mpc update
    mpc add $(\ls)
    mpc save favorites
    mpc shuffle
    mpc play
    cd ~
    notify-send -t 2000 -a System "MPD" "Playlist: Favorites"
}

case "$1" in
    -u) up ;;
    -d) down ;;
    -p) player ;;
    -s) loadstreambeats ;;
    -f) reloadfavorites ;;
esac
