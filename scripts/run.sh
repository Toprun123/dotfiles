#!/usr/bin/env bash

choice=$(compgen -c | grep -v -E '^(if|fi|case|esac|for|done|while|until|select|function|return|continue|break|time|exec|source|alias|builtin|read|export|unset|local|set|declare|typeset|:|\.|\[|coproc|l|ll|ls|then|else|elif|do|in|\{|\}|!|\[\[|\]\]|_.*|compgen)$' | sort | dmenu -nf '#f1b950' -nb '#1d2434' -sb '#674099' -sf '#bac2de' -fn 'BatmanForeverAlternate-13')

fish -c "$choice" > /dev/null 2>&1 & disown
