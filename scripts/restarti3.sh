#!/usr/bin/env bash

LOCKFILE="/tmp/i3-restart.lock"

# Check if the lock file exists
if [ ! -f "$LOCKFILE" ]; then
    # Create the lock file to prevent looping
    touch "$LOCKFILE"

    # Sleep for 2 seconds and restart i3
    sleep 3
    i3-msg restart
fi

sleep 20 && rm -f $LOCKFILE
