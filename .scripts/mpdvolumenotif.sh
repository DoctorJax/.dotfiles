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

selectplaylist() {
    musicdir="$HOME/Music"
    fzfmenu=($(ls $musicdir | fzf --prompt="Which Artists Would You Like : " --border=rounded --margin=5% --color=dark --height 100% --reverse --header="                    MUSIC " --info=hidden --header-first))
    if [ -z "$fzfmenu" ]; then
        exit 1
    fi
    x=1
    while [ $x -le 1 ]
    do
        if [ -z "$fzfmenu" ]; then
            x=$(( $x + 1 ))
        fi
        selectedartists="$selectedartists $fzfmenu"
        fzfmenu=($(ls $musicdir | fzf --prompt="Which Artists Would You Like : " --border=rounded --margin=5% --color=dark --height 100% --reverse --header="                    MUSIC " --info=hidden --header-first))
    done
    mpc clear
    mpc update
    mpc add $selectedartists
    mpc play
    cd ~
    notify-send -t 2000 -a System "MPD" "Playlist: Specifically Selected"
}

case "$1" in
    -u) up ;;
    -d) down ;;
    -p) player ;;
    -s) loadstreambeats ;;
    -f) reloadfavorites ;;
    -sp) selectplaylist ;;
esac
