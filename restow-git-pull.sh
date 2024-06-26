#!/bin/bash
# Unstow all dirs, git pull, then restow
cd "$(dirname "$0")" || exit

for d in */; do
    stow -D "$d"
done

git pull || exit 1

for d in */; do
    stow "$d"
done
