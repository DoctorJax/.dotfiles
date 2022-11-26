#!/bin/bash

gtktraybin="$HOME/GitRepos/stray/target/debug/gtk-tray"

starttray() {
    killtray
    ${gtktraybin}
}

killtray() {
    killall gtk-tray
}

toggle() {
    if [[ ! $(pidof gtk-tray) ]]; then
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
