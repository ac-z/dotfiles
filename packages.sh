#!/bin/bash

## Packages for both Arch and Termux

universal_packages='
  git
  vim
  stow
  zip
  unzip
  ncdu
  tree
  htop
  tmux
  screen
  bash-completion
  wget
  openssh
  python-pip
'
pipx_packages='
'

## Arch-Specific packages

arch_packages='
  base-devel
  man-db
  npm
  xdg-utils
  ripgrep
  fd
  neovim
  wl-clipboard
  foot-terminfo
  python-pipx
'
arch_packages="$arch_packages $universal_packages"

aur_packages='
  walk-bin
  page-git
'
# For installing from URL
arch_package_urls='
'
# Architecture-specific Arch packages
arch_x86_64_packages='
  code
  firefox
'
case $(uname -m) in
  x86_64) 
    arch_packages="$arch_packages $arch_x86_64_packages" 
    arch_package_urls="$arch_package_urls https://mega.nz/linux/repo/Arch_Extra/x86_64/megacmd-x86_64.pkg.tar.zst"
  ;;
esac

## Termux-specific packages

termux_packages='
  man
  walk
  openssl
  libexpat
  nodejs
  termux-tools
  termux-api
  proot-distro
  megacmd
'
termux_packages="$termux_packages $universal_packages"

## Other stuff

fedora_ostree_layers='
  distrobox
  sway-config-fedora
  mako
  libvirt
  virt-manager
  smartmontools
'
