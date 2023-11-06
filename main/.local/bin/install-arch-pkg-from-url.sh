#!/bin/bash
# This script takes 1 arg, must be a URL with a sensible filename at the end

package_name=$(basename "$1") 
# using --noscriptlet to prevent outside packages from adding repos and breaking shit
wget -O $package_name "$1" && 
  sudo pacman -U --noscriptlet --noconfirm "$package_name" &&
  rm "$package_name"
