#!/bin/bash
# This script takes 1 arg, must be a valid AUR package

d=/tmp/${USER}_aur
mkdir -p "$d"
for p in "${@##-*}"; do
  (
    cd "$d"
    git clone "https://aur.archlinux.org/$p.git"
    cd "$p"
    makepkg "${@##[^\-]*}"
  )
done
