#!/usr/bin/env bash
# Move the focused window to the next or previous workspace in i3

# Load `m` from a persistent file or default to 3 if it doesn't exist
m_file="$HOME/dotfiles/.val_m"
if [ -f "$m_file" ]; then
    m=$(cat "$m_file")
else
    m=3  # Default value if the file doesn't exist
fi

n_file="$HOME/dotfiles/.val_n"
if [ -f "$n_file" ]; then
    n=$(cat "$n_file")
else
    n=3  # Default value if the file doesn't exist
fi

# Get the current workspace number
wss=$(i3-msg -t get_workspaces)
c_w=$(echo "$wss" | jq -r '.[] | select(.focused==true) | .name')
f_w=$(echo "$wss" | jq -r '.[] | select(.visible==true and .focused==false) | .name')
out=$(echo "$wss" | jq -r '.[] | select(.focused) | .output')
#t=$((n + m))  # Total workspaces

if xrandr | grep "HDMI-1 connected" > /dev/null; then

    if [[ "$c_w" -eq "30" ]]; then

        n_w=30
        p_w=30

    elif [[ "$c_w" -ge 1 && "$c_w" -le "$n" ]]; then

        # If current workspace is in the primary set (1 to n)
        n_w=$(((c_w % n + n) % n + 1))
        p_w=$((((c_w - 2) % n + n) % n + 1))

    else

        # If current workspace is outside the primary set
        n_w=$((((c_w - 10) % m + m) % m + (10 + 1)))
        p_w=$((((c_w - 2 - 10) % m + m) % m + (10 + 1)))

    fi

else

    if [[ "$c_w" -eq "30" ]]; then

        n_w=30
        p_w=30

    else

        # Fallback if HDMI1 is not connected
        n_w=$(((c_w % n + n) % n + 1))
        p_w=$((((c_w - 2) % n + n) % n + 1))

    fi

fi

# Execute based on the argument passed
if [ "$1" = "n" ]; then
    i3-msg workspace "$n_w"
elif [ "$1" = "p" ]; then
    i3-msg workspace "$p_w"
elif [ "$1" = "mn" ]; then
    i3-msg move container to workspace "$n_w"
elif [ "$1" = "mp" ]; then
    i3-msg move container to workspace "$p_w"
elif [ "$1" = "add-n" ]; then

    if ! xrandr | grep "HDMI-1 connected" > /dev/null; then
        if (( n < 10 )); then

            # Increment n
            n=$((n + 1))
            # Save the new value of m to the persistent config file
            echo "$n" > "$n_file"

        fi
    else
        if (( n < 7 )); then

            # Increment n
            n=$((n + 1))
            # Save the new value of m to the persistent config file
            echo "$n" > "$n_file"

        fi
    fi

elif [ "$1" = "rm-n" ]; then

    if (( n > 1 )); then

        n=$((n - 1))
        # Save the new value of m, n to the persistent config file
        echo "$n" > "$n_file"

        del_w=$((n + 1))  # Last workspace number for the second monitor
        i3-msg "[workspace=\"^$del_w$\"] move to workspace $n"

        if [ "$f_w" = "$del_w" ]; then
            eval $(xdotool getmouselocation --shell)
            i3-msg workspace "$n"
            i3-msg focus output $out
            xdotool mousemove $X $Y
        fi

        if [ "$c_w" = "$del_w" ]; then
            i3-msg workspace "$n"
        fi

    fi


elif [ "$1" = "add-m" ]; then

    if xrandr | grep "HDMI-1 connected" > /dev/null; then
        if (( m < 7 )); then

            # Increment m
            m=$((m + 1))

            # Save the new value of m to the persistent config file
            echo "$m" > "$m_file"

        fi
    fi


elif [ "$1" = "rm-m" ]; then

    if xrandr | grep "HDMI-1 connected" > /dev/null; then
        if (( m > 1 )); then

            m=$((m - 1))

            # Save the new value of m to the persistent config file
            echo "$m" > "$m_file"

            # Remove the last workspace on the second monitor
            del_w=$((10 + m + 1))  # Last workspace number for the second monitor
            l_w=$((10 + m))
            i3-msg "[workspace=\"^$del_w$\"] move to workspace $l_w"

            if [ "$f_w" = "$del_w" ]; then
                eval $(xdotool getmouselocation --shell)
                i3-msg workspace "$l_w"
                i3-msg focus output $out
                xdotool mousemove $X $Y
            fi

            if [ "$c_w" = "$del_w" ]; then
                i3-msg workspace "$l_w"
            fi

        fi
    fi

elif [ "$1" = "min" ]; then

  current=$(head -n 1 ~/dotfiles/.min_cache)
  state=$(tail -n 1 ~/dotfiles/.min_cache)

  if [ "$state" = "0" ]; then
    echo -e "$c_w\n1" > ~/dotfiles/.min_cache
    i3-msg workspace 30
  else
    echo -e "$c_w\n0" > ~/dotfiles/.min_cache
    i3-msg workspace $current
  fi

elif [ "$1" = "mvmin" ]; then

  current=$(head -n 1 ~/dotfiles/.min_cache)
  state=$(tail -n 1 ~/dotfiles/.min_cache)

  if [ "$state" = "0" ]; then
    i3-msg move container to workspace 30
  else
    i3-msg move container to workspace "$current"
  fi


fi
