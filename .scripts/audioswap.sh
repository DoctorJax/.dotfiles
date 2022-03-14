#!/bin/bash

headphones_sink="alsa_output.usb-Corsair_CORSAIR_VOID_ELITE_Wireless_Gaming_Dongle-00.analog-stereo"
earbuds_sink="alsa_output.pci-0000_1f_00.3.analog-stereo"

headphones() {
    pactl set-default-sink $headphones_sink
    sed -i "s/earbuds.png/headphones.png/g" ~/.streamdeck_ui.json
    kill -USR1 `pgrep streamdeck`
    notify-send -t 2000 -a System "Audio Swap" "Default Sink: Headphones"
}

earbuds() {
    pactl set-default-sink $earbuds_sink
    sed -i "s/headphones.png/earbuds.png/g" ~/.streamdeck_ui.json
    kill -USR1 `pgrep streamdeck`
    notify-send -t 2000 -a System "Audio Swap" "Default Sink: Earbuds"
}

togglesink() {
    pactl get-default-sink | grep $headphones_sink && earbuds || headphones
}



recordingsink() {
    pactl load-module module-null-sink sink_name=virtualsink
    pactl load-module module-loopback source=virtualsink.monitor sink="$(pactl get-default-sink)" latency_msec=1
    notify-send -t 2000 -a System "Audio Swap" "Virtual Sink: Enabled"
}

norecordingsink() {
    pactl unload-module module-null-sink
    pactl unload-module module-loopback
    notify-send -t 2000 -a System "Audio Swap" "Virtual Sink: Disabled"
}

togglerecordingsink() {
    pactl list sinks short | grep virtualsink && norecordingsink || recordingsink
}

case "$1" in
    -h) headphones;;
    -e) earbuds;;
    -t) togglesink;;
    -r) recordingsink;;
    -n) norecordingsink;;
    -s) togglerecordingsink;;
esac
