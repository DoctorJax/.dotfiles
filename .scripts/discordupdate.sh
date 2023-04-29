#!/usr/bin/bash

update() {
    cd "$HOME"/Downloads

    wget 'https://github.com/GooseMod/OpenAsar/releases/download/nightly/app.asar'
    sudo mv app.asar /opt/discord-canary/resources/app.asar

    pkill -9 DiscordCanary
    sleep 1
    discord-canary --enable-features=UseOzonePlatform --ozone-platform=wayland > /dev/null &
}

theme() {
    echo '{"openasar":{"setup":true,"noTyping":true,"quickstart":true,"css":"@import url(\"https://dyzean.github.io/Tokyo-Night/tokyo-night.theme.css\");"}}' > "$HOME"/.config/discordcanary/settings.json

    pkill -9 DiscordCanary
    sleep 1
    discord-canary --enable-features=UseOzonePlatform --ozone-platform=wayland > /dev/null &
}

case "$1" in
    -u) update ;;
    -t) theme ;;
    -a) update; theme ;;
    *) update ;;
esac
