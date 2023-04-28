#!/usr/bin/bash

cd "$HOME"/Downloads

wget 'https://github.com/GooseMod/OpenAsar/releases/download/nightly/app.asar'

sudo mv app.asar /opt/discord-canary/resources/app.asar

pkill -9 DiscordCanary

sleep 1

discord-canary --enable-features=UseOzonePlatform --ozone-platform=wayland > /dev/null &
