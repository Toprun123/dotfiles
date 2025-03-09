#!/usr/bin/env bash

POLYBAR_PID=$(pgrep -f "polybar --reload main -l info" | awk '{print $1}')
HDMI_POLYBAR_PID=$(pgrep -f "polybar --reload main -l notice" | grep -v "polybar --reload main -l info")

if [ -n "$POLYBAR_PID" ]; then
  kill "$POLYBAR_PID"
else
  MONITOR=eDP-1 polybar --reload main -l info >/dev/null 2>&1 &
fi

if [ -z "$HDMI_POLYBAR_PID" ]; then
  MONITOR=HDMI-1 polybar --reload main -l notice >/dev/null 2>&1 &
fi
