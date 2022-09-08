#!/bin/bash

headphones_sink="alsa_output.usb-Corsair_CORSAIR_VOID_ELITE_Wireless_Gaming_Dongle-00.analog-stereo"
earbuds_sink="alsa_output.pci-0000_1f_00.3.analog-stereo"

headphones() {
    pactl set-default-sink $headphones_sink
    notify-send -t 2000 -a System "Audio Swap" "Default Sink: Headphones"
}

earbuds() {
    pactl set-default-sink $earbuds_sink
    notify-send -t 2000 -a System "Audio Swap" "Default Sink: Earbuds"
}

togglesink() {
    pactl get-default-sink | grep $headphones_sink && earbuds || headphones
}

case "$1" in
    -h) headphones;;
    -e) earbuds;;
    -t) togglesink;;
esac
