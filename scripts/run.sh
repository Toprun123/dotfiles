#!/usr/bin/env bash

choice=$(compgen -c | grep -v -E '^(if|fi|case|esac|for|done|while|until|select|function|return|continue|break|time|exec|source|alias|builtin|read|export|unset|local|set|declare|typeset|:|\.|\[|coproc|l|ll|ls|then|else|elif|do|in|\{|\}|!|\[\[|\]\]|_.*|compgen)$' | sort | dmenu -i -p "Enter command  " -nf '#4abaaf' -nb '#1f2335' -sb '#7aa2f7' -sf '#102030' -fn 'HurmitNerdFont-16')

fish -c "$choice" >/dev/null 2>&1 &
disown
