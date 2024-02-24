#!/bin/bash

pgrep -x thunderbird > /dev/null || thunderbird &
pgrep -x signal-desktop > /dev/null || signal-desktop --enable-features=UseOzonePlatform --ozone-platform=wayland --use-tray-icon &
pgrep -x DiscordCanary > /dev/null || /home/jackson/.local/bin/DiscordCanary --enable-features=UseOzonePlatform --ozone-platform=wayland &

pgrep -x btop > /dev/null || /home/jackson/.scripts/resources.sh &
