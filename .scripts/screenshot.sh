#!/bin/bash

copyscreenshot(){
    case "$XDG_SESSION_TYPE" in
        x11) maim -u -s -n -m 1 | xclip -selection clipboard -t image/png ;;
        wayland) grim -g "$(slurp)" - | wl-copy ;;
        *) echo "Uh, nothing found? Goodluck"; exit 0 ;;
    esac

    notify-send -t 2000 -a System "Screenshot.sh" "Copied to clipboard"
}

timestamp(){
    pickLocation=$(cat /tmp/.screenshot.sh.tmp)

    if [[ -z "$pickLocation" ]]
    then
        pickLocation=$(zenity --file-selection --directory)
        echo "$pickLocation" > /tmp/.screenshot.sh.tmp
    fi

    if [[ -n "$2" ]]
    then
        pickLocation="$2"
        echo "$pickLocation" > /tmp/.screenshot.sh.tmp
    fi

    case "$XDG_SESSION_TYPE" in
        x11) maim -u -s "$pickLocation"/"$(date +%m-%d-%Y_%T).png" ;;
        wayland) grim -g "$(slurp)" "$pickLocation"/"$(date +%m-%d-%Y_%T).png" ;;
        *) echo "Uh, nothing found? Goodluck"; exit 0 ;;
    esac

    notify-send -t 2000 -a System "Screenshot.sh" "Saved to: $pickLocation"
}

case "$1" in
    -t) timestamp "$@";;
    *) copyscreenshot ;;
esac
