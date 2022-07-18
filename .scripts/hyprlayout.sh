#!/usr/bin/env bash

us() {
    sed -i "s/kb_variant=colemak/kb_variant=/" ~/.config/hypr/hyprland.conf
    notify-send -t 2000 -a System "Hyprland" "Layout: US"
}

colemak() {
    sed -i "s/kb_variant=/kb_variant=colemak/" ~/.config/hypr/hyprland.conf
    notify-send -t 2000 -a System "Hyprland" "Layout: Colemak"
}

toggle() {
    grep "kb_variant=colemak" ~/.config/hypr/hyprland.conf && us || colemak
}

case "$1" in
    -u) us;;
    -c) colemak;;
    -t) toggle;;
esac
