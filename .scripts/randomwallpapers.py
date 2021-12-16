#!/usr/bin/python

import random
import os
import time

num = str(random.randrange(0, 305) + 1)

str_len = len(num)

str_fin = ""

for i in range(0, 4 - str_len):
    str_fin += "0"

str_fin += str(num)

str_fin += ".jpg"

# os.system("nitrogen --head=0 --set-zoom-fill ~/wallpapers/" + str_fin )
# os.system("nitrogen --head=1 --set-zoom-fill ~/wallpapers/" + str_fin )
# os.system("wal -n -i ~/wallpapers/" + str_fin)

os.system("nitrogen --head=0 --set-zoom-fill ~/wallpapers/" + str_fin + " && nitrogen --head=1 --set-zoom-fill ~/wallpapers/" + str_fin + " && wal -n -i ~/wallpapers/" + str_fin )

os.system("notify-send -t 4000 'Wallpaper set to: '" + str_fin )

os.system("echo 'awesome.restart()' | awesome-client")
