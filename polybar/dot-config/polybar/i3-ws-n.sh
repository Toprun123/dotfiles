#!/usr/bin/env bash

c_w=$(i3-msg -t get_workspaces | jq -r '.[] | select(.focused==true) | .name')

n_file="$HOME/dotfiles/.val_n"
if [ -f "$n_file" ]; then
    n=$(cat "$n_file")
else
    n=3  # Default value if the file doesn't exist
fi


# Define the active symbol and inactive symbol

a_s="%{T3}%{F#b5deff}󰻿%{T5} "  # Active workspace symbol
i_s="%{T3}%{F#999}%{T5} "  # Inactive workspace symbol

# Create an array for the output
output=()
# Loop through the number of workspaces
for ((i=1; i<=n; i++)); do
    if [[ "$i" -eq "$c_w" ]]; then
        output+=("$a_s") # Add active symbol for the current workspace
    else
        output+=("$i_s") # Add inactive symbol for other workspaces
    fi
done


printf "%s" "${output[@]}"

