#!/bin/bash

# Ensure this repo was cloned in the right spot (in $HOME/dotfiles)
if [ ! -d $HOME/dotfiles/.git ]; then
  echo "Please clone this repo into $HOME/dotfiles"
  exit
fi

# Distro detection
if [[ "$PREFIX" == *"com.termux"* ]]; then
  distro="termux"
elif ( . /etc/os-release && [ "$NAME" == "Arch Linux" ] ); then
  distro="arch"
elif ( . /etc/os-release && [ "$NAME" == "Fedora Linux" ] ); then
  distro="fedora"
  if [ -e "/usr/bin/rpm-ostree" ]; then
	distro="fedora-ostree"
  fi
fi

# Check for a setup script for the right distro
if [ -n "$distro" ]; then
  if [ -e $HOME/.local/bin/setup-${distro}.sh ]; then
    read -p "Run setup-${distro}.sh? [Y/n] " -n 1 -r && echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
      bash $HOME/.local/bin/setup-${distro}.sh
    fi
  else
    echo "No setup-${distro}.sh found."
  fi
fi

# Termux hostname is just "localhost", so use something else
if [ "$HOSTNAME" == "localhost" ]; then
  read -p "Please enter a name for this device: " device_name
else
  device_name=$HOSTNAME
fi

# Generate new SSH key for this device
ssh-keygen -t ed25519 -C "(Key pair for SSH from $HOSTNAME)" -N "" -f "$HOME/.ssh/id_ed25519"

# Set this git repo's upstrem url to use ssh instead of https
cd $HOME/dotfiles
git remote set-url origin git@github.com:amb3r-dev/dotfiles.git
