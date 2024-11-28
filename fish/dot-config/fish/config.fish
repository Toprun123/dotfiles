alias .="cd ."
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../../.."
alias py="python3"
alias ls="eza -TlL 2 --git --total-size --no-permissions --no-user --no-time --icons=always --group-directories-first"
alias lsa="eza -TlaL 1 --git --total-size --no-permissions --no-user --no-time --icons=always --group-directories-first"
alias s="python3 -m http.server 8080"
alias pipes.sh="pipes-rs -d 1 -r 0 -b true -p 1 -t 0.5"
alias vi="nvim"
alias vim="nvim"
alias stow="stow --dotfiles"
set fish_greeting
fzf_configure_bindings --directory=\cz --history=\ca
starship init fish | source
set -x GOPATH "$HOME/.go"
if set -q KITTY_STR
    kitty @ --to=$KITTY_LISTEN_ON set-spacing padding=8 margin=0
    set t_w (tput cols)
    if [ $t_w -ge 71 ]
        echo
        fastfetch
    end
    set -e KITTY_STR
end
function y
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    magick -size 1920x1080 xc:#0f0f1f /tmp/bg-kitty.png
    kitty @ --to=$KITTY_LISTEN_ON set-background-image /tmp/bg-kitty.png
    kitty @ --to=$KITTY_LISTEN_ON set-spacing padding=30 margin=0
    yazi $argv --cwd-file="$tmp"
    if set cwd (command cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
        builtin cd -- "$cwd"
    end
    rm -f -- "$tmp"
    magick -size 1920x1080 xc:#080014 /tmp/bg-kitty.png
    kitty @ --to=$KITTY_LISTEN_ON set-background-image /tmp/bg-kitty.png
    kitty @ --to=$KITTY_LISTEN_ON set-spacing padding=8 margin=0
end
function g
    magick -size 1920x1080 xc:#0f0f1f /tmp/bg-kitty.png
    kitty @ --to=$KITTY_LISTEN_ON set-background-image /tmp/bg-kitty.png
    kitty @ --to=$KITTY_LISTEN_ON set-spacing padding=30 margin=0
    gitui
    magick -size 1920x1080 xc:#080014 /tmp/bg-kitty.png
    kitty @ --to=$KITTY_LISTEN_ON set-background-image /tmp/bg-kitty.png
    kitty @ --to=$KITTY_LISTEN_ON set-spacing padding=8 margin=0
end
function ghd
    magick -size 1920x1080 xc:#0f0f1f /tmp/bg-kitty.png
    kitty @ --to=$KITTY_LISTEN_ON set-background-image /tmp/bg-kitty.png
    kitty @ --to=$KITTY_LISTEN_ON set-spacing padding=30 margin=0
    gh dash
    magick -size 1920x1080 xc:#080014 /tmp/bg-kitty.png
    kitty @ --to=$KITTY_LISTEN_ON set-background-image /tmp/bg-kitty.png
    kitty @ --to=$KITTY_LISTEN_ON set-spacing padding=8 margin=0
end
function editor
    set pos (cat ~/dotfiles/.pos)
    y $pos
    nvim
    echo $PWD > ~/dotfiles/.pos
end
function funk
    for i in (seq 100)
         for j in (seq (math $COLUMNS - 1))
              math "ceil(6 * cos(($i + $j) * pi / 5))"
         end | spark | read sparks
         echo -n $sparks\r && sleep .1
    end
end
