#!/bin/bash

## Packages for both Arch and Termux

universal_packages='
  git
  stow
  zip
  unzip
  ncdu
  tree
  htop
  tmux
  screen
  bash-completion
  starship
  ripgrep
  fd
  neovim
  openssh
  python-pip
'
pipx_packages='
  neovim-remote
'

## Arch-Specific packages

arch_packages='
  base-devel
  man-db
  npm
  code
  xdg-utils
  wl-clipboard
  foot-terminfo
  python-pipx
'
arch_packages="$arch_packages $universal_packages"
aur_packages='
  walk-bin
'
arch_package_urls='
  https://mega.nz/linux/repo/Arch_Extra/x86_64/megacmd-x86_64.pkg.tar.zst
'

## Termux-specific packages

termux_packages='
  man
  walk
  openssl
  libexpat
  nodejs
  termux-tools
  megacmd
'
termux_packages="$termux_packages $universal_packages"

## Other stuff

fedora_ostree_layers='
  distrobox
  starship
  sway-config-fedora
  mako
  libvirt
  virt-manager
  smartmontools
'
