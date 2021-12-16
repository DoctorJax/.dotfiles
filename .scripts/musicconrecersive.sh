#!/bin/bash

# Does the music conversion but adds new lines to output file names
for a in ./*
do
    cd "$a"/
    for b in *.wav
    do
        ffmpeg -i "$b" "$(basename --suffix='.wav' $b)".ogg
    done
    cd ../
done

# Should fix the file names too
for d in ./*
do
    cd "$d"/
    for i in *
    do
        IN=$(basename --suffix='.ogg' "$i")
        OUT=$(echo $IN | tr "$\'" '-' | sed 's/---\\n--/-/g')
        echo "$OUT"
        if [[ "$IN" != "$OUT" ]]
        then
            mv "$IN".ogg "$OUT".ogg
        fi
    done
    rm -rf *.wav
    cd ../
done

echo "Should technically be done"
