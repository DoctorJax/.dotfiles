#!/usr/bin/bash

pgrep -x companion > /dev/null || companion &

pactl subscribe | rg --line-buffered "change" | while read -r _; do
    if [[ $(mpc | grep -ow 'playing') = "playing" ]]; then
        curl "localhost:8888/set/custom-variable/music?value=playing"
    else
        curl "localhost:8888/set/custom-variable/music?value=paused"
    fi

    if [[ $(amixer get Capture | grep -o '\[on\]') = "[on]" ]]; then
        curl "localhost:8888/set/custom-variable/micmute?value=unmute"
    else
        curl "localhost:8888/set/custom-variable/micmute?value=mute"
    fi

    sinkinfo=$(pactl get-default-sink | grep -Eo "CORSAIR|Dell" | head -1)
    if [[ $sinkinfo = "CORSAIR" ]]; then
        curl "localhost:8888/set/custom-variable/sinktoggle?value=headphones"
        batterystatus=$(headsetcontrol -b | grep Battery | awk -F ' ' '{ print $2 }')
        if [[ $batterystatus = "Unavailable" ]]; then
            batterystatus=Off
        fi
        curl "localhost:8888/set/custom-variable/headphone_charge?value=$batterystatus"
    elif [[ $sinkinfo = "Dell" ]]; then
        curl "localhost:8888/set/custom-variable/sinktoggle?value=speaker"
    else
        curl "localhost:8888/set/custom-variable/sinktoggle?value=earbuds"
    fi
done
