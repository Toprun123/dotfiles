#!/usr/bin/env bash

opts="  Lock\n  Shutdown\n󰜉 Reboot\n  StopX11\n󰒲  Suspend"

sel=$(printf "$opts"|dmenu -p "Select Power Option:" -nf '#e0af68' -nb '#1f2335' -sb '#f7768e' -sf '#1a1b26' -fn 'HurmitNerdFont-16')

case $sel in
    "  Shutdown") shutdown -h now
    ;;
    "󰜉 Reboot") reboot
    ;;
    "  StopX11") i3-msg exit
    ;;
    "󰒲  Suspend") systemctl suspend
    ;;
    "  Lock") ~/dotfiles/scripts/lock.sh
    ;;
esac

