#!/usr/bin/env bash

current_layout=$(setxkbmap -query | grep layout | awk '{print $2}')

if [ "$current_layout" == "us" ]; then
    echo "english"
elif [ "$current_layout" == "pk" ]; then
    echo "$(echo 'اردو' | fribidi --rtl | awk '{$1=$1;print}')"
elif [ "$current_layout" == "ara" ]; then
    echo "$(echo 'العربية' | fribidi --rtl | awk '{$1=$1;print}')"
else
    echo "türkçe"
fi

