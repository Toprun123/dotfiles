#!/usr/bin/env bash

battery_level=$(cat /sys/class/power_supply/BAT0/capacity)
battery_status=$(cat /sys/class/power_supply/BAT0/status)
if [[ $battery_level -lt 20 ]] && [[ $battery_status == "Discharging" ]]; then
    dunstify "Battery Low" "Please charge your device." -h int:value:$battery_level -u critical -r 999
fi
if [[ $battery_level -lt 10 ]] && [[ $battery_status == "Discharging" ]]; then
    dunstify "Battery Critical" "Please charge your device." -h int:value:$battery_level -u critical -r 999
fi

# Total number of workspaces
m_file="$HOME/dotfiles/.val_m"
if [ -f "$m_file" ]; then
    m=$(cat "$m_file")
else
    m=3 # Default value if the file doesn't exist
fi

a_s="%{T5} %{T3}%{F#7aa2f7}󰻿"  # Active workspace symbol
i_s="%{T5} %{T3}%{F#999}"  # Inactive workspace symbol

c_w=$(i3-msg -t get_workspaces | jq -r '.[] | select(.focused==true) | .name')


# Check if HDMI1 is connected
if xrandr | grep "HDMI-1 connected" > /dev/null; then

    # Create an array for the output
    output=()

    # Repeat the same logic for the secondary workspaces (if needed)
    for ((i=11; i<=10+m; i++)); do
        if [[ $i -eq $c_w ]]; then
            output+=("$a_s") # Add active symbol for the current workspace
        else
            output+=("$i_s") # Add inactive symbol for other workspaces
        fi
    done

else

    # If HDMI1 is not connected, create the same output without the separator
    echo "%{F#e0af68} 󰶐 "

fi

# Join the output array into a single string and print
printf "%s" "%{T5}${output[@]}%{T5} "

