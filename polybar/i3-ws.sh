#!/usr/bin/env bash

c_w=$(i3-msg -t get_workspaces | jq -r '.[] | select(.focused==true) | .name')

battery_level=$(cat /sys/class/power_supply/BAT0/capacity)
battery_status=$(cat /sys/class/power_supply/BAT0/status)
if [[ $battery_level -lt 20 ]] && [[ $battery_status == "Discharging" ]]; then
    dunstify "Battery Low" "Please charge your device." -h int:value:$battery_level -u critical -r 999
fi
if [[ $battery_level -lt 10 ]] && [[ $battery_status == "Discharging" ]]; then
    dunstify "Battery Critical" "Please charge your device." -h int:value:$battery_level -u critical -r 999
fi

# Total number of workspaces
config_file="$HOME/dotfiles/.val_m"
if [ -f "$config_file" ]; then
    m=$(cat "$config_file")
else
    m=3 # Default value if the file doesn't exist
fi

n=3  # Number of primary workspaces
t=$((n + m))  # Total workspaces

# Define the active symbol and inactive symbol
a_s=""  # Active workspace symbol
i_s=""  # Inactive workspace symbol

# Check if HDMI1 is connected
if xrandr | grep "HDMI1 connected" > /dev/null; then
    # Create an array for the output
    output=()
    
    # Loop through the number of workspaces
    for ((i=1; i<=n; i++)); do
        if [[ $i -eq $c_w ]]; then
            output+=("$a_s ") # Add active symbol for the current workspace
        else
            output+=("$i_s ") # Add inactive symbol for other workspaces
        fi
    done

    # Add a separator for the second monitor workspace section
    output+=("|")

    # Repeat the same logic for the secondary workspaces (if needed)
    for ((i=n+1; i<=t; i++)); do
        if [[ $i -eq $c_w ]]; then
            output+=("$a_s ") # Add active symbol for the current workspace
        else
            output+=("$i_s ") # Add inactive symbol for other workspaces
        fi
    done

else
    # If HDMI1 is not connected, create the same output without the separator
    output=()

    for ((i=1; i<=t; i++)); do
        if [[ $i -eq $c_w ]]; then
            output+=("$a_s ") # Add active symbol for the current workspace
        else
            output+=("$i_s ") # Add inactive symbol for other workspaces
        fi
    done
fi

# Join the output array into a single string and print
echo "${output[@]}"
