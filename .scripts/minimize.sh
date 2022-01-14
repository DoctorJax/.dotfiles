#!/bin/bash

minimize() {
    winID="$(xdotool getactivewindow)"
    xdotool windowunmap $winID
    echo "$winID" >> "$HOME"/.cache/miniwinID
}

maximize() {
    xdotool windowmap $(cat "$HOME"/.cache/miniwinID | tail -n1)
    sed '$d' "$HOME"/.cache/miniwinID > "$HOME"/.cache/miniwinID0
    mv "$HOME"/.cache/miniwinID0 "$HOME"/.cache/miniwinID
}

case "$1" in
    -n) minimize ;;
    -m) maximize ;;
esac
