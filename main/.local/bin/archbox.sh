#!/bin/bash
# Create an arch-based distrobox of name $1, if it doesn't already exist
# Optionally give the path to a script as the second argument to add an init hook

case "$2" in
  '') ;;
  *) hook="--init-hooks '$2'" ;;
esac

if hash distrobox &> /dev/null; then
  if ! distrobox list | grep -q "${1:-$arch_container_name}"; then
    distrobox create \
      --name "${1:-$arch_container_name}" \
      --image greyltc/archlinux-aur:paru \
      --pull \
      $hook
  else
    echo "The distrobox ${1:-$arch_container_name} already exists."
  fi
else
  echo "Distrobox is not installed."
fi 
