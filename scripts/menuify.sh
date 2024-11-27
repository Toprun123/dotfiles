#!/usr/bin/env bash

list=""

declare -A commands_map

mapfile -t lines

for line in "${lines[@]}"; do
    id=$(echo "$line" | awk -F '[ #()]' '{print $2}')
    #command=$(echo "$line" | awk '{if(match($0,/\[(.*)\]/,arr)){print arr[1];}}')
    list+="$id"$'\n'
    commands_map["$id"]="$line"
done

selected=$(printf "$list" | dmenu -p "Select what to do:" -nf '#e0af68' -nb '#1f2335' -sb '#414868' -sf '#ffffff' -fn 'HurmitNerdFont-16')

if [ -n "$selected" ]; then
    command_to_run=${commands_map["$selected"]}
    printf "$command_to_run"
fi
