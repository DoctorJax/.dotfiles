#!/bin/bash

notify-send -i /home/jackson/Pictures/white-micicon.png -t 4000 -a System "Microphone" "$(amixer set Capture toggle | grep Mono | tail -n1)"
