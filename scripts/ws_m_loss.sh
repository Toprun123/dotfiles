#!/usr/bin/env bash

if ! xrandr | grep "HDMI-1 connected" > /dev/null; then

    n_file="$HOME/dotfiles/.val_n"
    if [ -f "$n_file" ]; then
        n=$(cat "$n_file")
    else
        n=3  # Default value if the file doesn't exist
    fi

    workspaces=$(i3-msg -t get_workspaces | jq -r '.[] | .name' | grep "1.")

    for ws in $workspaces; do
        if (( n < 10 )); then
            # Increment n
            n=$((n + 1))
            # Save the new value of n to the persistent config file
            echo "$n" > "$n_file"
            i3-msg "[workspace=$ws] move to workspace $n"
        else
            i3-msg "[workspace=$ws] move to workspace $n"
        fi
    done

fi
