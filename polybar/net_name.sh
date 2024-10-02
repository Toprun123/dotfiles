#!/usr/bin/env bash

name=$(nmcli -t -f active,ssid dev wifi | grep '^yes' | awk -F: '{print $2}' | head -n 1)

if [ -z "$name" ]; then
    echo "Disconnected"
else
    echo $name
fi

