#!/bin/bash
# Receive package lists from first arg
. "${1:-$HOME/dotfiles/packages.sh}"

# Install packages from repos & AUR
if hash paru &> /dev/null; then
  paru -S --needed --noconfirm $arch_packages $aur_packages
else
  sudo pacman -S --needed --noconfirm $arch_packages
  for package in $aur_packages; do
    "$HOME/dotfiles/main/.local/bin/install-aur-makepkg.sh" $package
  done
fi

# Install packages from URL
for url in $arch_package_urls; do
  "$HOME/dotfiles/main/.local/bin/install-arch-pkg-from-url.sh" $url
done

# Stow dotfiles 
(cd $HOME/dotfiles && stow main termux)
