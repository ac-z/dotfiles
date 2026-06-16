#!/bin/bash
# Unstow all dirs
cd "$(dirname "$0")" || exit

for d in */; do
    stow -D "$d"
done
