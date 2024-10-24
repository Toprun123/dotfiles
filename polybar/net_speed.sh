#!/usr/bin/env bash

name=$(nmcli -t -f active,ssid dev wifi | grep '^yes' | awk -F: '{print $2}' | head -n 1)

if [[ -z "$name" ]]; then
    echo "%{F#ff0f0f}󱈸%{F-}"
    exit
fi

ping -c 1 8.8.8.8 > /dev/null 2>&1
if [ ! $? -eq 0 ]; then
    echo "%{F#ff0f0f}󰪎 %{F-}"
fi

# Get the network interface name (replace `your-connection-name` with your actual connection name)
INTERFACE="wlp0s20f3"

# Temporary file to store sar output
TEMP_FILE=$(mktemp)

# Interval in seconds
INTERVAL=1

# Count of reports
COUNT=1

# Collect network stats
sar -n DEV $INTERVAL $COUNT > $TEMP_FILE

# Extract relevant information
# echo "Network usage for interface $INTERFACE:"
db=$(grep "$INTERFACE" $TEMP_FILE | tail -n 1 | awk '{print $3}')
ub=$(grep "$INTERFACE" $TEMP_FILE | tail -n 1 | awk '{print $4}')

convert_bytes() {
    local BYTES=$1
    local BYTES=${BYTES%.*}
    local UNIT
    if (( BYTES >= 1024 )); then
        echo "$(echo "scale=2; $BYTES/1024" | bc)M"
    else
        echo "${BYTES}K"
    fi
}

db=$(convert_bytes $db)
ub=$(convert_bytes $ub)

echo "%{F#a4c7f5} %{F-}$db %{F#ffee8c} %{F-}$ub"

# Clean up
rm $TEMP_FILE
