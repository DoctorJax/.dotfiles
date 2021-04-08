#! /bin/bash
/home/jackson/.local/bin/fixscreens.sh &
/home/jackson/.local/bin/keepscreenon.sh &

nitrogen --restore &
picom -b --experimental-backends --dbus --config /home/jackson/.config/picom/picom.conf &
nm-applet &

xfce4-clipman &
mailspring &
discord-canary &

/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 & eval $(gnome-keyring-daemon -s --components=pkcs11,secrets,ssh,gpg) &
