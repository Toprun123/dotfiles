#!/usr/bin/env bash

if [ "$1" == "toggle" ]; then
    if [ "$(xset q | grep timeout | awk '{print $2}')" == "0" ]; then
        xset s on
        xset +dpms
    else
        xset s off
        xset -dpms
    fi
else
    if [ "$(xset q | grep timeout | awk '{print $2}')" == "0" ]; then
        echo "%{T4}%{F#ff9050}󰅶"
    else
        echo "%{T4}%{F#d8a369}󰾪"
    fi
fi

