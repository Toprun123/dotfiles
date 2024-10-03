#!/usr/bin/env bash


DOT_DIR=$(pwd)

CONFIG_DIR=~/.config

if [ ! -d "/etc/nixos" ]; then
    echo "Please use nixos to load configuration and dependencies properly.\nExiting.."
    exit
fi


if [ -f /etc/nixos/configuration.nix ] && [ ! -L /etc/nixos/configuration.nix ]; then
    sudo mv /etc/nixos/configuration.nix /etc/nixos/configuration.nix.bak
    sudo ln -s $DOT_DIR/configuration.nix /etc/nixos/configuration.nix
else
    sudo ln -s $DOT_DIR/configuration.nix /etc/nixos/configuration.nix
fi

if [ -f /etc/nixos/packages-rel.nix ] && [ ! -L /etc/nixos/packages-rel.nix ]; then
    sudo mv /etc/nixos/packages-rel.nix /etc/nixos/packages-rel.nix.bak
    sudo ln -s $DOT_DIR/packages-rel.nix /etc/nixos/packages-rel.nix
else
    sudo ln -s $DOT_DIR/packages-rel.nix /etc/nixos/packages-rel.nix
fi

#if [ -f /etc/nixos/flake.nix ] && [ ! -L /etc/nixos/flake.nix ]; then
#    sudo mv /etc/nixos/flake.nix /etc/nixos/flake.nix.bak
#    sudo ln -s $DOT_DIR/flake.nix /etc/nixos/flake.nix
#else
#    sudo ln -s $DOT_DIR/flake.nix /etc/nixos/flake.nix
#fi

rm -f $CONFIG_DIR/kitty/kitty.conf
ln -s $DOT_DIR/kitty.conf $CONFIG_DIR/kitty/kitty.conf

rm -f $CONFIG_DIR/btop/themes/catppuccin_mocha.theme
ln -s $DOT_DIR/themes/catppuccin_mocha.theme $CONFIG_DIR/btop/themes/catppuccin_mocha.theme

rm -f $CONFIG_DIR/i3/config
ln -s $DOT_DIR/i3config $CONFIG_DIR/i3/config

rm -f $CONFIG_DIR/starship.toml
ln -s $DOT_DIR/starship.toml $CONFIG_DIR/starship.toml

rm -f $CONFIG_DIR/fish/config.fish
ln -s $DOT_DIR/config.fish $CONFIG_DIR/fish/config.fish

rm -f $CONFIG_DIR/fastfetch/config.jsonc
ln -s $DOT_DIR/fastfetch.jsonc $CONFIG_DIR/fastfetch/config.jsonc

rm -f $CONFIG_DIR/polybar
ln -s $DOT_DIR/polybar/ $CONFIG_DIR/polybar

rm -f ~/.Xresources
cp $DOT_DIR/.Xresources ~/.Xresources

rm -f $CONFIG_DIR/gtk-3.0/settings.ini
ln -s $DOT_DIR/gtk.config.ini $CONFIG_DIR/gtk-3.0/settings.ini

rm -f $CONFIG_DIR/gtk-4.0/settings.ini
ln -s $DOT_DIR/gtk.config.ini $CONFIG_DIR/gtk-4.0/settings.ini

sudo nixos-rebuild switch

