#!/usr/bin/env bash

current_layout=$(setxkbmap -query | grep layout | awk '{print $2}')

if [ "$current_layout" == "us" ]; then
    echo "%{T2}english%{T-}"
elif [ "$current_layout" == "pk" ]; then
    echo "%{T2}  $(echo 'اردو' | fribidi --rtl | awk '{$1=$1;print}') %{T-}"
elif [ "$current_layout" == "ara" ]; then
    echo "%{T2}$(echo 'العربية' | fribidi --rtl | awk '{$1=$1;print}')%{T-}"
else
    echo "%{T2}türkçe %{T-}"
fi
