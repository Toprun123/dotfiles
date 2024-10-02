#!/usr/bin/env bash

name=$(nmcli -t -f active,ssid dev wifi | grep '^yes' | awk -F: '{print $2}' | head -n 1)

if [ "$1" == "toggle" ]; then
    if [[ -z "$name" ]]; then
        nmcli networking on
    else
        nmcli networking off
    fi
else
    # Get the list of available Wi-Fi networks
    networks=$(nmcli -f SSID dev wifi list | awk 'NR>1 {gsub(/^ +| +$/, "", $1); print $1}' | awk '!seen[$0]++')

    # Use dmenu to select a network
    selected_network=$(echo "$networks" | dmenu -p "Select Wi-Fi network:" -nf '#f1b950' -nb '#1d2434' -sb '#674099' -sf '#bac2de' -fn 'BatmanForeverAlternate-13')

    # Check if a network was selected
    if [ -n "$selected_network" ]; then
        # Connect to the selected network
        kitty --title "passprompt" -e nmcli --ask dev wifi connect "$selected_network"
    else
        echo "No network selected"
    fi
fi
