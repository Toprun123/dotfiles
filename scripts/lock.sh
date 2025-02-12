#!/usr/bin/env bash

setxkbmap us

i3lock \
  -ek \
  -c 1a1b2688 \
  --nofork \
  --inside-color=00000000 \
  --insidever-color=e0af6888 \
  --insidewrong-color=f7768e88 \
  --ring-color=00000000 \
  --ringver-color=00000000 \
  --ringwrong-color=00000000 \
  --line-color=00000000 \
  --separator-color=00000000 \
  --verif-color=ffffffff \
  --wrong-color=ffffffff \
  --modif-color=ffffffff \
  --layout-color=ffffffff \
  --time-color=ffffffff \
  --date-color=ffffffff \
  --greeter-color=ffffffff \
  --time-str="%H:%M:%S" \
  --date-str="" \
  --verif-text="Verifying…" \
  --wrong-text="Wrong!" \
  --noinput-text="No input!" \
  --lock-text="Locking…" \
  --lockfailed-text="Lock failed!" \
  --no-modkey-text \
  --time-font="FantasqueSansM Nerd Font" \
  --date-font="FantasqueSansM Nerd Font" \
  --layout-font="FantasqueSansM Nerd Font" \
  --verif-font="FantasqueSansM Nerd Font" \
  --wrong-font="FantasqueSansM Nerd Font" \
  --timeoutline-width=0 \
  --dateoutline-width=0 \
  --layoutoutline-width=0 \
  --verifoutline-width=0 \
  --wrongoutline-width=0 \
  --greeteroutline-width=0 \
  --modifieroutline-width=0 \
  --pass-media-keys \
  --pass-screen-keys \
  --pass-power-keys \
  --pass-volume-keys

#i3lock-color -ek -c 33333377 --inside-color=00000000 --insidever-color=4b8a2488 --insidewrong-color=c22a2a88 --ring-color=ffffff00 --ringver-color=4b8a24ff --ringwrong-color=c22a2aff --line-color=ffffff00 --separator-color=ffffff00 --verif-color=ffffffff --wrong-color=ffffffff --modif-color=ffffffff --layout-color=ffffffff --time-color=ffffffff --date-color=ffffffff --greeter-color=ffffffff --time-str="%H:%M:%S" --date-str="" --verif-text="Verifying…" --wrong-text="Wrong!" --noinput-text="No input!" --lock-text="Locking…" --lockfailed-text="Lock failed!" --no-modkey-text --time-font="FantasqueSansM Nerd Font" --date-font="FantasqueSansM Nerd Font" --layout-font="FantasqueSansM Nerd Font" --verif-font="FantasqueSansM Nerd Font" --wrong-font="FantasqueSansM Nerd Font" --timeoutline-width=0 --dateoutline-width=0 --layoutoutline-width=0 --verifoutline-width=0 --wrongoutline-width=0 --greeteroutline-width=0 --modifieroutline-width=0 --pass-media-keys --pass-screen-keys --pass-power-keys --pass-volume-keys
