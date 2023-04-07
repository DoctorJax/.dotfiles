#!/bin/bash

headphones_sink="alsa_output.usb-Corsair_CORSAIR_VOID_ELITE_Wireless_Gaming_Dongle-00.analog-stereo"
earbuds_sink="alsa_output.pci-0000_1f_00.3.analog-stereo"
speaker_sink="alsa_output.usb-Dell_Dell_AC511_USB_SoundBar-00.analog-stereo"

headphones() {
    pactl set-default-sink $headphones_sink
    notify-send -t 2000 -a System "Audio Swap" "Default Sink: Headphones"
}

earbuds() {
    pactl set-default-sink $earbuds_sink
    notify-send -t 2000 -a System "Audio Swap" "Default Sink: Earbuds"
}

speaker() {
    pactl set-default-sink $speaker_sink
    notify-send -t 2000 -a System "Audio Swap" "Default Sink: Speakers"
}

togglesink() {
    if [[ $(pactl list sinks | grep -Eo "Dell" | head -1) = "Dell" ]]; then
        speaker
    else
        pactl get-default-sink | grep $headphones_sink && earbuds || headphones
    fi
}

case "$1" in
    -h) headphones;;
    -e) earbuds;;
    -t) togglesink;;
    -s) speaker;;
esac
