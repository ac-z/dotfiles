#!/bin/bash
# Receive package lists from first arg
. "${1:-$HOME/dotfiles/packages.sh}"

# Install packages from repos & AUR
if hash paru; then
  paru -S --needed --noconfirm $arch_packages $aur_packages
else
  pacman -S --needed --noconfirm $arch_packages
  for package in $aur_packages; do
    "$(dirname -- "$0")/install-aur-makepkg.sh" $package
  done
fi

# Install packages from URL
for url in $arch_package_urls; do
  "$(dirname -- "$0")/install-arch-pkg-from-url.sh" $url
done

# Install pipx packages
for package in $pipx_packages; do
  pipx install $package
done
