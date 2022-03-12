#!/bin/bash

streamdeckmuted() {
    sed -i "s/white-micicon.png/white-micicon-mute.png/g" ~/.streamdeck_ui.json
    kill -USR1 `pgrep streamdeck`
}

streamdeckunmuted() {
    sed -i "s/white-micicon-mute.png/white-micicon.png/g" ~/.streamdeck_ui.json
    kill -USR1 `pgrep streamdeck`
}

micmute() {
    amixer set Capture toggle
    amixer get Capture | grep "\[on\]" && streamdeckunmuted || streamdeckmuted
    notify-send -i /home/jackson/Pictures/white-micicon.png -t 4000 -a System "Microphone" "$(amixer get Capture | tail -n1)"
}

micmute
