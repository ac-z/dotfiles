#!/bin/bash
# Receive package lists from first arg
. "${1:-$HOME/.packages}"

# Install extra layers
sudo rpm-ostree install $fedora_ostree_layers

# Set up default archbox
"$(dirname -- "$0")/archbox.sh" '' "$(dirname -- "$0")/setup-arch.sh"
