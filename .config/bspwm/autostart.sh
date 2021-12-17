# Fancy Stuff
picom -b --experimental-backends --dbus --config /home/jackson/.config/picom/picom.conf &
nm-applet &
/usr/bin/emacs --daemon &
dunst &

# MPD Stuff
pgrep -x mpd > /dev/null || mpd /home/jackson/.config/mpd/mpd.conf &
pgrep -x mpd-mpris > /dev/null || /home/jackson/go/bin/mpd-mpris &

# My Scripts
/home/jackson/.scripts/wallpapers.sh -i &
/home/jackson/.scripts/fixscreens.sh &
/home/jackson/.scripts/keepscreenon.sh &

# Run Once
pgrep -x xfce4-clipman > /dev/null || xfce4-clipman &
pgrep -x mailspring > /dev/null || mailspring &
pgrep -x discord-canary > /dev/null || discord-canary &

# Polkit
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 & eval "$(gnome-keyring-daemon -s --components=pkcs11,secrets,ssh,gpg)" &
