#!/bin/bash

minimize() {
    winID="$(xdotool getactivewindow)"
    xdotool windowunmap "$winID"
    echo "$winID" >> "$HOME"/.cache/miniwinID
}

maximize() {
    xdotool windowmap "$(tail -n1 "$HOME"/.cache/miniwinID)"
    sed -i '$d' "$HOME"/.cache/miniwinID
}

case "$1" in
    -n) minimize ;;
    -m) maximize ;;
esac
