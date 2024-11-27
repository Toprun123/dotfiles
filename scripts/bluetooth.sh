#!/usr/bin/env bash

if [ "$1" == "toggle" ]; then
    if bluetoothctl show | grep -q "Powered: yes"; then
        bluetoothctl devices Connected | grep "Device" | awk '{print $2}' | while read mac; do
            bluetoothctl disconnect $mac
        done
        bluetoothctl power off
    else
        bluetoothctl power on
    fi
else
    bluetoothctl --timeout 5 scan on
    opts=$(bluetoothctl devices | grep -Ev "Device .* ..-..-..-..-..-.." | awk '{ print "󰂰  " $2 "  " substr($0, index($0,$3)) }')

    selected_option=$(echo "$opts" | rofi -dmenu | awk '{ print $2 }')

    if [[ ! -z "$selected_option" ]]; then
        bluetoothctl connect $selected_option
    fi
fi
