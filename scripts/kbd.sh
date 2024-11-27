#!/usr/bin/env bash

current_layout=$(setxkbmap -query | grep layout | awk '{print $2}')

if [ -z "$1" ]; then
    if [ "$current_layout" == "us" ]; then
        setxkbmap tr
    elif [ "$current_layout" == "tr" ]; then
        setxkbmap ara
    elif [ "$current_layout" == "ara" ]; then
        setxkbmap pk
    else
        setxkbmap us
    fi
    exit 1
fi

if [ "$current_layout" == "us" ]; then
    setxkbmap pk
elif [ "$current_layout" == "pk" ]; then
    setxkbmap ara
elif [ "$current_layout" == "ara" ]; then
    setxkbmap tr
else
    setxkbmap us
fi
