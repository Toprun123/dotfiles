alias .="cd ."
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../../.."
alias ,="nix-shell -p "
alias pyth="python3 ~/Main/EsoLangs/pyth/pyth.py"
alias cod="code ."
alias k="kitty -e --hold fish"
#alias brainf="~Main/EsoLangs/BrainF**K/brainfuck"
#alias wspace="~Main/EsoLangs/Whitespace/wspace"
#alias ls="ls -shlc --color=auto --group-directories-first"
alias ls="tree -vqhFCAL 2 --du --dirsfirst"
alias lsa="tree -vqhFCAL 1 --du --dirsfirst"
alias lsh="tree -vqhaFCAL 1 --du --dirsfirst"
set fish_greeting
set -gx GTK_THEME "catppuccin-frappe-blue-standard"
starship init fish | source
if test -n "$KITTY_WINDOW_ID"
    set t_w (tput cols)
    if [ $t_w -ge 71 ]
        echo
        fastfetch
    end
end
function ,
    if test -z "$argv[2]"
        set argv[2] $argv[1]
    else if [ "$argv[2]" = "-s" ]
        nix-shell -p $argv[1] --arg config '{ allowUnfree = true; }'
        return
    end
    nix-shell -p $argv[1] --run "$argv[2]" --arg config '{ allowUnfree = true; }'
end
function y
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    yazi $argv --cwd-file="$tmp"
    if set cwd (command cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
        builtin cd -- "$cwd"
    end
    rm -f -- "$tmp"
end
