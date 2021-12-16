!#/bin/bash

killall -q polybar
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done
polybar jackson &

if type "xrandr"; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    MONITOR=$m polybar --reload jackson &
  done
else
  polybar --reload jackson &
fi

