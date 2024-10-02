#!/usr/bin/env bash
# Move the focused window to the next workspace in i3

# Get the current workspace number

current_workspace=$(i3-msg -t get_workspaces | jq -r '.[] | select(.focused==true) | .name')

if xrandr | grep "HDMI1 connected" > /dev/null; then
    if [ "$current_workspace" -eq "1" ] || [ "$current_workspace" -eq "2" ] || [ "$current_workspace" -eq "3" ]; then
        n_w=$((($current_workspace % 3 + 3) % 3 + 1))
        p_w=$(((($current_workspace - 2) % 3 + 3) % 3 + 1))

        if [ "$1" = "n" ]; then
            i3-msg workspace "$n_w"
        elif [ "$1" = "p" ]; then
            i3-msg workspace "$p_w"
        elif [ "$1" = "mn" ]; then
            i3-msg move container to workspace "$n_w"
        elif [ "$1" = "mp" ]; then
            i3-msg move container to workspace "$p_w"
        fi
    else
        n_w=$(((($current_workspace - 3) % 3 + 3) % 3 + 4))
        p_w=$(((($current_workspace - 5) % 3 + 3) % 3 + 4))

        if [ "$1" = "n" ]; then
            i3-msg workspace "$n_w"
        elif [ "$1" = "p" ]; then
            i3-msg workspace "$p_w"
        elif [ "$1" = "mn" ]; then
            i3-msg move container to workspace "$n_w"
        elif [ "$1" = "mp" ]; then
            i3-msg move container to workspace "$p_w"
        fi
    fi

else
    n_w=$((($current_workspace % 6 + 6) % 6 + 1))
    p_w=$(((($current_workspace - 2) % 6 + 6) % 6 + 1))

    if [ "$1" = "n" ]; then
        i3-msg workspace "$n_w"
    elif [ "$1" = "p" ]; then
        i3-msg workspace "$p_w"
    elif [ "$1" = "mn" ]; then
        i3-msg move container to workspace "$n_w"
    elif [ "$1" = "mp" ]; then
        i3-msg move container to workspace "$p_w"
    fi
fi

