#!/usr/bin/env bash

val=$(brightnessctl | grep -oP '\d+%' | head -n 1 | sed 's/%//')

bars=$((val * 2 / 100))

case "$bars" in
    0) echo "󰃞 $val%"
    ;;
    1) echo "󰃟 $val%"
    ;;
    2) echo "󰃠 $val%"
    ;;
    *) echo "error?"
    ;;
esac


