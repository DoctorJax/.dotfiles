#!/usr/bin/bash

pgrep -x companion > /dev/null || companion &

while :; do
  # Get the first line with aggregate of all CPUs
  cpu_now=($(head -n1 /proc/stat))
  # Get all columns but skip the first (which is the "cpu" string)
  cpu_sum="${cpu_now[@]:1}"
  # Replace the column seperator (space) with +
  cpu_sum=$((${cpu_sum// /+}))
  # Get the delta between two reads
  cpu_delta=$((cpu_sum - cpu_last_sum))
  # Get the idle time Delta
  cpu_idle=$((cpu_now[4]- cpu_last[4]))
  # Calc time spent working
  cpu_used=$((cpu_delta - cpu_idle))
  # Calc percentage
  cpu_usage=$((100 * cpu_used / cpu_delta))

  # Keep this as last for our next read
  cpu_last=("${cpu_now[@]}")
  cpu_last_sum=$cpu_sum

  curl "localhost:8888/set/custom-variable/CPU?value=$cpu_usage"

  ram_usage=$((($(free -m | awk '/Mem/ { print $3 }')*100/$(free -m | awk '/Mem/ { print $2 }'))))
  curl "localhost:8888/set/custom-variable/RAM?value=$ram_usage"

  # Wait a second before the next read
  sleep 1
done&

pactl subscribe | rg --line-buffered "change" | while read -r _; do
    volume=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print int($2*100)}')
    curl "localhost:8888/set/custom-variable/volume?value=$volume"

    mpd_volume=$(mpc | tail -n1 | awk -F ' ' '{ print $2 }')
    curl "localhost:8888/set/custom-variable/mpd_volume?value=$mpd_volume"

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
