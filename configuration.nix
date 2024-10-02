{ config, pkgs, ... }:

{

    imports = [
        /etc/nixos/hardware-configuration.nix
        /etc/nixos/packages-rel.nix
    ];


    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    sound.enable = true;
    system.stateVersion = "23.05";
    hardware.bluetooth.enable = true;
    #nix.settings.experimental-features = [ "nix-command" "flakes" ];


    networking = {
        hostName = "nixos";
        networkmanager.enable = true;
        firewall = {
            enable = true;
            allowedTCPPorts = [];
            allowedUDPPorts = [];
        };
    };


    time.timeZone = "Asia/Riyadh";

    i18n = {
        defaultLocale = "en_US.UTF-8";
        extraLocaleSettings = {
            LC_CTYPE="en_US.UTF-8";
            LC_NAME = "en_US.UTF-8";
            LC_TIME = "en_US.UTF-8";
            LC_PAPER = "en_US.UTF-8";
            LC_NUMERIC = "en_US.UTF-8";
            LC_ADDRESS = "en_US.UTF-8";
            LC_MONETARY = "en_US.UTF-8";
            LC_TELEPHONE = "en_US.UTF-8";
            LC_MEASUREMENT = "en_US.UTF-8";
            LC_IDENTIFICATION = "en_US.UTF-8";
        };
    };


    services = {
        displayManager.defaultSession = "xfce+i3";
        gvfs.enable = true;
        printing = {
            enable = true;
            drivers = [ pkgs.gutenprint ];
        };
        gnome.gnome-keyring.enable = true;
        avahi = {
            enable = true;
            nssmdns4 = true;
            openFirewall = true;
        };
        xserver = {
            enable = true;
            videoDrivers = ["intel"];
            windowManager.i3.enable = true;
            xkb = {
                variant = "";
                layout = "us,tr,ara,pk";
            };
            desktopManager = {
                xterm.enable = false;
                xfce = {
                    enable = true;
                    noDesktop = true;
                    enableXfwm = false;
                };
            };
            displayManager.lightdm = {
                enable = true;
                background = /home/sixzix-admin/dotfiles/bg.jpg;
            };
        };
        pipewire = {
            enable = true;
            pulse.enable = true;
            alsa = {
                enable = true;
                support32Bit = true;
            };
        };
        picom = {
            fade = true;
            vSync = true;
            enable = true;
            fadeDelta = 8;
            backend = "egl";
            inactiveOpacity = 0.87;
            settings = {
                corner-radius = 18;
                blur = {
                    size = 7;
                    deviation = 3;
                    method = "gaussian";
                };
                opacity-rule = [
                    "85:class_g = 'Polybar'"
                ];
                blur-background-exclude = [
                    "class_g    ~= 'slop'"
                    "class_i    ~= 'slop'"
                    "name       ~= 'slop'"
                    "window_type = 'menu'"
                    "window_type = 'tooltip'"
                    "role        = 'xborder'"
                    "window_type = 'popup_menu'"
                    "window_type = 'dropdown_menu'"
                ];
            };
        };
    };


    nixpkgs.config = {
        pulseaudio = true;
        allowUnfree = true;
        packageOverrides = pkgs: rec {
            polybar = pkgs.polybar.override {
                i3Support = true;
            };
        };
    };


    users.users.sixzix-admin = {
        isNormalUser = true;
        description = "Syed Daanish";
        extraGroups = [ "networkmanager" "wheel" ];
    };


    security = {
        rtkit.enable = true;
        polkit.enable = true;
        pam.services.lightdm.enableGnomeKeyring = true;
    };


    systemd.user.services.polkit-gnome-authentication-agent-1 = {
        after = [ "graphical-session.target" ];
        wants = [ "graphical-session.target" ];
        wantedBy = [ "graphical-session.target" ];
        description = "polkit-gnome-authentication-agent-1";
        serviceConfig = {
            RestartSec = 1;
            Type = "simple";
            TimeoutStopSec = 10;
            Restart = "on-failure";
            ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        };
    };


    environment.variables = {
        TERM = "kitty";
        TERMINAL = "kitty";
        GTK_THEME = "catppuccin-frappe-blue-standard";
    };


}

