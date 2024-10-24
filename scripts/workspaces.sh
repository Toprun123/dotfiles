#!/usr/bin/env bash
# Move the focused window to the next or previous workspace in i3

# Load `m` from a persistent file or default to 3 if it doesn't exist
config_file="$HOME/dotfiles/.val_m"
if [ -f "$config_file" ]; then
    m=$(cat "$config_file")
else
    m=3  # Default value if the file doesn't exist
fi

# Get the current workspace number
c_w=$(i3-msg -t get_workspaces | jq -r '.[] | select(.focused==true) | .name')
n=3  # Number of primary workspaces
t=$((n + m))  # Total workspaces

if xrandr | grep "HDMI1 connected" > /dev/null; then

    if [[ "$c_w" -ge 1 && "$c_w" -le "$n" ]]; then

        # If current workspace is in the primary set (1 to n)
        n_w=$(((c_w % n + n) % n + 1))
        p_w=$((((c_w - 2) % n + n) % n + 1))

    else

        # If current workspace is outside the primary set
        n_w=$((((c_w - n) % m + m) % m + (n + 1)))
        p_w=$((((c_w - 2 - n) % m + m) % m + (n + 1)))

    fi

else

    # Fallback if HDMI1 is not connected
    n_w=$(((c_w % t + t) % t + 1))
    p_w=$((((c_w - 2) % t + t) % t + 1))

fi

# Execute based on the argument passed
if [ "$1" = "n" ]; then
    i3-msg workspace "$n_w"
elif [ "$1" = "p" ]; then
    i3-msg workspace "$p_w"
elif [ "$1" = "mn" ]; then
    i3-msg move container to workspace "$n_w"
elif [ "$1" = "mp" ]; then
    i3-msg move container to workspace "$p_w"
elif [ "$1" = "add" ]; then

    # Increment m
    m=$((m + 1))

    # Save the new value of m to the persistent config file
    echo "$m" > "$config_file"

    # Add new workspace on the second monitor
    new_w=$((n + m))  # Workspace number for new workspace

    # Move the new workspace to the second monitor (adjust
    i3-msg workspace "$new_w"
    i3-msg move workspace to output HDMI1

elif [ "$1" = "rm" ]; then

    if (( m > 1 )); then

        m=$((m - 1))

        # Save the new value of m to the persistent config file
        echo "$m" > "$config_file"

        # Remove the last workspace on the second monitor
        del_w=$((n + m + 1))  # Last workspace number for the second monitor
        l_w=$((n + m))
        i3-msg "[workspace=$del_w] move to workspace $l_w"
        i3-msg workspace "$l_w"

    fi

fi
