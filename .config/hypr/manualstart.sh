#!/bin/bash

pgrep -x thunderbird > /dev/null || thunderbird &
pgrep -x signal-desktop > /dev/null || signal-desktop &
pgrep -x DiscordCanary > /dev/null || /home/jackson/.local/bin/DiscordCanary --enable-features=UseOzonePlatform --ozone-platform=wayland &
