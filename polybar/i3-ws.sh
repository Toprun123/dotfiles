#!/usr/bin/env bash

current_workspace=$(i3-msg -t get_workspaces | jq -r '.[] | select(.focused==true) | .name')

battery_level=$(cat /sys/class/power_supply/BAT0/capacity)
battery_status=$(cat /sys/class/power_supply/BAT0/status)
if [[ $battery_level -lt 20 ]] && [[ $battery_status == "Discharging" ]]; then
    dunstify "Battery Low" "Please charge your device." -h int:value:$battery_level -u critical -r 999
fi
if [[ $battery_level -lt 10 ]] && [[ $battery_status == "Discharging" ]]; then
    dunstify "Battery Critical" "Please charge your device." -h int:value:$battery_level -u critical -r 999
fi

if xrandr | grep "HDMI1 connected" > /dev/null; then
    case "$current_workspace" in
        1) echo "       |      "
        ;;
        2) echo "       |      "
        ;;
        3) echo "       |      "
        ;;
        4) echo "       |      "
        ;;
        5) echo "       |      "
        ;;
        6) echo "       |      "
        ;;
        *) echo "       |      "
        ;;
    esac
else
    case "$current_workspace" in
        1) echo "            "
        ;;
        2) echo "            "
        ;;
        3) echo "            "
        ;;
        4) echo "            "
        ;;
        5) echo "            "
        ;;
        6) echo "            "
        ;;
        *) echo "            "
        ;;
    esac
fi
