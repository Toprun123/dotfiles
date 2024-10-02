#!/usr/bin/env bash

current_workspace=$(i3-msg -t get_workspaces | jq -r '.[] | select(.focused==true) | .name')

#i3-msg workspace $ws1 output monitor eDP1
#i3-msg workspace $ws2 output monitor eDP1
#i3-msg workspace $ws3 output monitor eDP1
#i3-msg workspace $ws4 output monitor HDMI1
#i3-msg workspace $ws5 output monitor HDMI1
#i3-msg workspace $ws6 output monitor HDMI1

if xrandr | grep "HDMI1 connected" > /dev/null; then
    case "$current_workspace" in
        1) echo "       |      "
        ;;
        2) echo "       |      "
        ;;
        3) echo "       |      "
        ;;
        4) echo "       |      "
        ;;
        5) echo "       |      "
        ;;
        6) echo "       |      "
        ;;
        *) echo "       |      "
        ;;
    esac
else
    case "$current_workspace" in
        1) echo "            "
        ;;
        2) echo "            "
        ;;
        3) echo "            "
        ;;
        4) echo "            "
        ;;
        5) echo "            "
        ;;
        6) echo "            "
        ;;
        *) echo "            "
        ;;
    esac
fi
