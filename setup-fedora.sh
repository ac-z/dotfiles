#!/bin/bash
# Receive package lists from first arg
. "${1:-$HOME/dotfiles/packages.sh}"

# Install extra layers
sudo dnf install $fedora_ostree_layers

# Stow dotfiles 
(cd $HOME/dotfiles && stow main termux)

# Set up default archbox
"$(dirname -- "$0")/archbox.sh" '' "$(dirname -- "$0")/setup-arch.sh"
