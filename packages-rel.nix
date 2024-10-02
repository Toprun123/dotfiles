{ config, pkgs, ... }:

{

    environment.systemPackages = with pkgs; [

        fishPlugins.fzf-fish
        gnome.gnome-keyring
        gnome.nautilus
        haskellPackages.greenclip

        acpi
        bc
        bibata-cursors
        blueman
        brightnessctl
        btop
        canon-cups-ufr2
        cargo
        catppuccin-gtk
        cmatrix
        dmenu
        fastfetch
        feh
        fribidi
        fzf
        git
        gparted
        i3lock-color
        jq
        killall
        kitty
        lxappearance
        neovim
        nerdfonts
        nitrogen
        nix-index
        maim
        picom
        polkit_gnome
        polybar
        pulseaudioFull
        python3
        rofi
        rustc
        starship
        sysstat
        tldr
        tree
        unrar
        unzip
        vim
        virtualenv
        vorta
        vscode
        xarchiver
        xborders
        xclip
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

