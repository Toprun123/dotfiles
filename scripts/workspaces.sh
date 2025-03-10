#!/usr/bin/env bash

m_file="$HOME/dotfiles/.val_m"
if [ -f "$m_file" ]; then
  m=$(cat "$m_file")
else
  m=3
fi

n_file="$HOME/dotfiles/.val_n"
if [ -f "$n_file" ]; then
  n=$(cat "$n_file")
else
  n=3
fi

wss=$(i3-msg -t get_workspaces)
c_w=$(echo "$wss" | jq -r '.[] | select(.focused==true) | .name')
f_w=$(echo "$wss" | jq -r '.[] | select(.visible==true and .focused==false) | .name')
out=$(echo "$wss" | jq -r '.[] | select(.focused) | .output')

if xrandr | grep "HDMI-1 connected" >/dev/null; then
  if [[ "$c_w" -eq "30" ]]; then
    n_w=30
    p_w=30
  elif [[ "$c_w" -eq "40" ]]; then
    n_w=40
    p_w=40
  elif [[ "$c_w" -ge 1 && "$c_w" -le "$n" ]]; then
    n_w=$(((c_w % n + n) % n + 1))
    p_w=$((((c_w - 2) % n + n) % n + 1))
  else
    n_w=$((((c_w - 10) % m + m) % m + (10 + 1)))
    p_w=$((((c_w - 2 - 10) % m + m) % m + (10 + 1)))
  fi
else
  if [[ "$c_w" -eq "30" ]]; then
    n_w=30
    p_w=30
  elif [[ "$c_w" -eq "40" ]]; then
    n_w=40
    p_w=40
  else
    n_w=$(((c_w % n + n) % n + 1))
    p_w=$((((c_w - 2) % n + n) % n + 1))
  fi
fi

if [ "$1" = "n" ]; then
  i3-msg workspace "$n_w"
elif [ "$1" = "p" ]; then
  i3-msg workspace "$p_w"
elif [ "$1" = "mn" ]; then
  i3-msg move container to workspace "$n_w"
elif [ "$1" = "mp" ]; then
  i3-msg move container to workspace "$p_w"
elif [ "$1" = "add-n" ]; then
  if ! xrandr | grep "HDMI-1 connected" >/dev/null; then
    if ((n < 10)); then
      n=$((n + 1))
      echo "$n" >"$n_file"
    fi
  else
    if ((n < 7)); then
      n=$((n + 1))
      echo "$n" >"$n_file"
    fi
  fi
elif [ "$1" = "rm-n" ]; then
  if ((n > 1)); then
    n=$((n - 1))
    echo "$n" >"$n_file"
    del_w=$((n + 1))
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
  if xrandr | grep "HDMI-1 connected" >/dev/null; then
    if ((m < 7)); then
      m=$((m + 1))
      echo "$m" >"$m_file"
    fi
  fi
elif [ "$1" = "rm-m" ]; then
  if xrandr | grep "HDMI-1 connected" >/dev/null; then
    if ((m > 1)); then
      m=$((m - 1))
      echo "$m" >"$m_file"
      del_w=$((10 + m + 1))
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
  if (("$c_w" < "20")) && (("$c_w" > "10")); then
    exit
  fi
  current=$(head -n 1 ~/dotfiles/.min_cache)
  if [ "$c_w" = "30" ]; then
    i3-msg workspace $current
  elif [ "$c_w" = "40" ]; then
    i3-msg workspace 30
  else
    echo -e "$c_w" >~/dotfiles/.min_cache
    i3-msg workspace 30
  fi
elif [ "$1" = "mvmin" ]; then
  if (("$c_w" < "20")) && (("$c_w" > "10")); then
    exit
  fi
  current=$(head -n 1 ~/dotfiles/.min_cache)
  if [ "$c_w" = "30" ]; then
    i3-msg move container to workspace "$current"
  else
    i3-msg move container to workspace 30
  fi
elif [ "$1" = "min2" ]; then
  if (("$c_w" < "20")) && (("$c_w" > "10")); then
    exit
  fi
  current=$(head -n 1 ~/dotfiles/.min_cache)
  if [ "$c_w" = "40" ]; then
    i3-msg workspace $current
  elif [ "$c_w" = "30" ]; then
    i3-msg workspace 40
  else
    echo -e "$c_w" >~/dotfiles/.min_cache
    i3-msg workspace 40
  fi
elif [ "$1" = "mvmin2" ]; then
  if (("$c_w" < "20")) && (("$c_w" > "10")); then
    exit
  fi
  current=$(head -n 1 ~/dotfiles/.min_cache)
  if [ "$c_w" = "40" ]; then
    i3-msg move container to workspace "$current"
  else
    i3-msg move container to workspace 40
  fi
fi
