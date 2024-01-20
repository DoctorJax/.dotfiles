#!/bin/bash

hyprctl dispatch workspace 11
sleep 0.5
hyprctl dispatch exec '[workspace 11;float;size 1072 651;move 4 4] kitty -e btop'
hyprctl dispatch exec '[workspace 11;float;size 1072 652;move 4 663] kitty -e sudo dmesg --follow'
hyprctl dispatch exec '[workspace 11;float;size 1072 593;move 4 1323] firefox -p Personal --new-window http://homeassistant:8123/dashboard-grid/home'
