if [[ "$(tty)" = "/dev/tty1" ]]; then
    pgrep bspwm || startx
fi

if [[ "$(tty)" = "/dev/tty2" ]]; then
    pgrep Hyprland || Hyprland
fi
