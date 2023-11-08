#!/bin/bash
# Receive package lists from first arg
. "${1:-$HOME/dotfiles/packages.sh}"

# Update packages & install termux packages
pkg update -y && pkg install -y $termux_packages

# Stow dotfiles 
(cd $HOME/dotfiles && stow main termux)

# Extra stuff
termux-setup-storage
$HOME/.local/bin/termux-shortcuts.sh
