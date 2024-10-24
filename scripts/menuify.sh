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

selected=$(printf "$list" | dmenu -nf '#f1b950' -nb '#1d2434' -sb '#674099' -sf '#bac2de' -fn 'BatmanForeverAlternate-16')

if [ -n "$selected" ]; then
    command_to_run=${commands_map["$selected"]}
    printf "$command_to_run"
fi
