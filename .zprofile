if [[ "$(tty)" = "/dev/tty1" ]]; then
    pgrep bspwm || startx
fi

if [[ "$(tty)" = "/dev/tty2" ]]; then
    export WLR_NO_HARDWARE_CURSORS=1
    export QT_QPA_PLATFORM=wayland
    export XDG_CURRENT_DESKTOP=hyprland
    export XDG_SESSION_DESKTOP=hyprland
    export XDG_CURRENT_SESSION_TYPE=wayland
    export GDK_BACKEND="wayland,x11"
    export MOZ_ENABLE_WAYLAND=1
    pgrep Hyprland || Hyprland
fi
