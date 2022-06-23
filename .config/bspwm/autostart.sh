# Fancy Stuff
picom -b --experimental-backends --dbus --config /home/jackson/.config/picom/picom.conf &
xrdb ~/.Xresources &
dunst &

# Useful Stuff
nm-applet &
/usr/bin/emacs --daemon &
numlockx on &

# MPD Stuff
pgrep -x mpd > /dev/null || mpd /home/jackson/.config/mpd/mpd.conf &
pgrep -x mpd-mpris > /dev/null || mpd-mpris &

# My Scripts
/home/jackson/.scripts/wallpapers.sh -i &
/home/jackson/.scripts/fixscreens.sh &
/home/jackson/.scripts/keepscreenon.sh &

# Run Once
pgrep -x xfce4-clipman > /dev/null || xfce4-clipman &
pgrep -x streamdeck.sh > /dev/null || /home/jackson/.local/bin/streamdeck.sh &

pgrep -x mailspring > /dev/null || mailspring &
pgrep -x discord-canary > /dev/null || discord-canary &
pgrep -x signal-desktop > /dev/null || signal-desktop --use-tray-icon &

# Polkit
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 & eval "$(gnome-keyring-daemon -s --components=pkcs11,secrets,ssh,gpg)" &
