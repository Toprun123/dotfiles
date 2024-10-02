#!/usr/bin/env bash

opts="Lock\nShutdown\nReboot\nLogout\nSuspend"

sel=$(printf "$opts"|dmenu -p "Select Wi-Fi network:" -nf '#f1b950' -nb '#1d2434' -sb '#674099' -sf '#bac2de' -fn 'BatmanForeverAlternate-13')

case $sel in
    Shutdown) shutdown -h now
    ;;
    Reboot) reboot
    ;;
    Logout) xfce4-session-logout
    ;;
    Suspend) systemctl suspend
    ;;
    Lock) ~/dotfiles/scripts/lock.sh
    ;;
esac

