# Fancy Stuff
pgrep -x waybar > /dev/null || waybar &
pgrep -x swaybg > /dev/null || swaybg --image "$(find ~/wallpapers -name '*.jpg' -type f | shuf -n 1)" -m fill &
dunst &

# Useful Stuff
/usr/bin/emacs --daemon &

# MPD Stuff
pgrep -x mpd > /dev/null || mpd /home/jackson/.config/mpd/mpd.conf &
pgrep -x mpd-mpris > /dev/null || /home/jackson/go/bin/mpd-mpris &

# Run Once
pgrep -x streamdeck.sh > /dev/null || /home/jackson/.local/bin/streamdeck.sh &

pgrep -x mailspring > /dev/null || mailspring &
pgrep -x discord-canary > /dev/null || discord-canary --disable-gpu &
pgrep -x signal-desktop > /dev/null || signal-desktop --use-tray-icon &

# Polkit
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 & eval "$(gnome-keyring-daemon -s --components=pkcs11,secrets,ssh,gpg)" &
