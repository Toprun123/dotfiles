#!/usr/bin/env bash

signal_strength=$(nmcli -f IN-USE,SIGNAL dev wifi | grep '^*' | awk '{print $2}')

bars=$((signal_strength * 4 / 100))

case "$bars" in
    0) echo "󰤭 "
    ;;
    1) echo "󰤟 "
    ;;
    2) echo "󰤢 "
    ;;
    3) echo "󰤥 "
    ;;
    4) echo "󰤨 "
    ;;
    *) echo "󰤭 "
    ;;
esac


