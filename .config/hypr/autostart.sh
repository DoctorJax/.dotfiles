# Fancy Stuff
pgrep -x waybar > /dev/null || waybar &
/home/jackson/.scripts/wallpapers.sh -i &
dunst &

# Useful Stuff
/usr/bin/emacs --daemon &

# Steam was being a pain
xrandr --output XWAYLAND0 --primary &

# MPD Stuff
pgrep -x mpd > /dev/null || mpd /home/jackson/.config/mpd/mpd.conf &
pgrep -x mpd-mpris > /dev/null || mpd-mpris &

# Run Once
pgrep -x streamdeck.sh > /dev/null || /home/jackson/.local/bin/streamdeck.sh &

pgrep -x mailspring > /dev/null || mailspring --background &
pgrep -x signal-desktop > /dev/null || signal-desktop --start-in-tray --ozone-platform=wayland &
pgrep -x DiscordCanary > /dev/null || discord-canary --enable-features=UseOzonePlatform --ozone-platform=wayland --ignore-gpu-blocklist &

# Polkit
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 & eval "$(gnome-keyring-daemon -s --components=pkcs11,secrets,ssh,gpg)" &
