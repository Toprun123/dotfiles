{ config, pkgs, ... }:

{

    environment.systemPackages = with pkgs; [

        haskellPackages.greenclip

        acpi
        bc
        bibata-cursors
        blueman
        brightnessctl
        btop
        canon-cups-ufr2
        cmatrix
        dmenu
        dunst
        fastfetch
        feh
        fribidi
        gcc
        git
        gnupg
        gparted
        i3lock-color
        inkscape
        jq
        killall
        kitty
        libnotify
        maim
        neovim
        nerdfonts
        picom
        pinentry
        pipes-rs
        polkit_gnome
        polybar
        pulseaudioFull
        python3
        rofi
        rustup
        sqlite
        sshfs
        starship
        sysstat
        tldr
        tree
        unzip
        vim
        virtualenv
        vorta
        vscode
        xborders
        xclip
        xournal
        xss-lock
        yazi
        zoom-us

    ];


    programs = {
        firefox.enable = true;
        dconf.enable = true;
        fish.enable = true;
        neovim.enable = true;
        bash = {
            interactiveShellInit = ''
                if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
                then
                    shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
                    exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
                fi
            '';
        };
    };

}

