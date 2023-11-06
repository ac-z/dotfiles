#!/bin/bash
# Receive package lists from first arg
. "${1:-$HOME/.packages}"

# Update packages & install termux packages
pkg update && pkg install -y $termux_packages

# Install pipx
pkg install python-pip && pip install --user pipx

# Install pipx packages
for package in $pipx_packages; do
	pipx install $package
done
