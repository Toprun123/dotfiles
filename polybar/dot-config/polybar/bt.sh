#!/usr/bin/env bash

bt_state=$(bluetoothctl show | grep "Powered: yes")

if [ "$1" == "tg" ]; then
    if [[ -z "$bt_state" ]]; then
        echo " "
    else
        echo " "
    fi
else
    if [[ -z "$bt_state" ]]; then
        echo "󰂲 "
    else
        echo "󰂱 "
    fi
fi

if [ "$1" == "toggle" ]; then
    if [[ -z "$bt_state" ]]; then
        bluetoothctl power on
    else
        bluetoothctl power off
    fi
fi

