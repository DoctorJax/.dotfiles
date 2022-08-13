if [[ "$(tty)" = "/dev/tty1" ]]; then
    pgrep bspwm || startx
fi

if [[ "$(tty)" = "/dev/tty2" ]]; then
    export LIBVA_DRIVER_NAME=nvidia
    export CLUTTER_BACKEND=wayland
    export XDG_SESSION_TYPE=wayland
    export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
    export MOZ_ENABLE_WAYLAND=1
    export GBM_BACKEND=nvidia-drm
    export __GLX_VENDOR_LIBRARY_NAME=nvidia
    export WLR_NO_HARDWARE_CURSORS=1
    export WLR_BACKEND=vulkan
    export QT_QPA_PLATFORM=wayland
    export GDK_BACKEND="wayland,x11"
    export XDG_CURRENT_DESKTOP=hyprland
    export XDG_SESSION_DESKTOP=hyprland
    export XDG_CURRENT_SESSION_TYPE=wayland
    pgrep Hyprland || Hyprland
fi
