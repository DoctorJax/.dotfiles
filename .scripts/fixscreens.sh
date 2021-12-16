#!/bin/bash

xrandr --output DP-1 --left-of HDMI-0

xrandr --output HDMI-0 --primary

xsetwacom set "Wacom Bamboo Pen Pen stylus" MapToOutput HEAD-0

xset r rate 660 75
