#!/bin/bash

xrandr --output DP-1 --left-of HDMI-0

xrandr --output HDMI-0 --primary

xset r rate 660 75

xsetwacom set "Wacom Bamboo Pen Pen stylus" MapToOutput HEAD-0

#xinput set-prop 10 "libinput Accel Profile Enabled" 0, 1

#xinput setprop 13 300 0,1

#sleep 1

#awesome-client 'awesome.restart()'
