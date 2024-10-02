#!/usr/bin/env bash

vol=$(pactl get-sink-volume @DEFAULT_SINK@ | grep -oP '\d+%' | head -n 1 | sed 's/%//')

mute=$(pactl get-sink-mute @DEFAULT_SINK@ | awk '{print $2}')

if [ "$mute" == "yes" ]; then
    echo "  $vol%"
fi


case "$vol" in
    0) echo "  $vol%"
    ;;
    *) echo "  $vol%"
    ;;
esac


