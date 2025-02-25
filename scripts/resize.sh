#!/usr/bin/env bash

[ -z "$1" ] && echo "No direction provided" && exit 1
distanceStr="7 px"

moveChoice() {
  i3-msg resize "$1" "$2" "$distanceStr" | grep '"success":true' ||
    i3-msg resize "$3" "$4" "$distanceStr"
}

case $1 in
up)
  moveChoice grow up shrink down
  ;;
down)
  moveChoice shrink up grow down
  ;;
left)
  moveChoice shrink right grow left
  ;;
right)
  moveChoice grow right shrink left
  ;;
esac
