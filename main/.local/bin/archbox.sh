#!/bin/bash
# Create an arch-based distrobox of name $1, if it doesn't already exist
# Optionally give the path to a script as the second argument to add an init hook

if hash distrobox &> /dev/null; then
  mode=distrobox
elif hash proot-distro &> /dev/null; then
  mode=proot-distro
else
  echo "Neither distrobox nor proot-distro are installed!"
  exit 1
fi

# Minor functions
while true; do
  case "$1" in
    -h|--help)
      echo "Usage: $0 [options] [name] [init-hook]"
      echo
      echo "Options:"
      echo "  -h, --help    Show this help message"
      echo "  -l, --list    List distroboxes or proot-distros"
      echo "  -e, --enter   Enter distrobox or proot-distro"
      exit
	;;
    -l|--list) 
      case "$mode" in
        distrobox) distrobox list ;;
        proot-distro) proot-distro list 2>&1 ;;
      esac
      exit
    ;;
    -e|--enter) 
      shift
      case "$mode" in
        distrobox) distrobox enter "${1:-$arch_container_name}" ;;
        proot-distro) proot-distro login "${1:-$arch_container_name}" --user $(cat $HOME/.archbox_user) --termux-home -- sh -c bash ;;
      esac
      exit
    ;;
    -*)
      echo "Invalid option: $1"
      exit 1
    ;;
    *) break;;
  esac
done

# The main event
case "$mode" in
  distrobox) 
    if ! distrobox list | grep -q "${1:-$arch_container_name}"; then
      case "$2" in '') ;; *) hook="--init-hooks '$2'";; esac
      distrobox create \
        --name "${1:-$arch_container_name}" \
        --image greyltc/archlinux-aur:paru \
        --pull \
        $hook
    else
      echo "The distrobox ${1:-$arch_container_name} already exists."
    fi
  ;;
  proot-distro) 
    if ! proot-distro list 2>&1 | grep -q "${1:-$arch_container_name}"; then
      # unless $HOME/.archbox_user exists...
      if [ ! -f $HOME/.archbox_user ]; then
        # Prompt user for desired username
        read -p "Enter desired username: " username
        echo "$username" > $HOME/.archbox_user
      fi
      # create plugin from heredoc
      cat <<EOF >$PREFIX/etc/proot-distro/proot-archbox.sh
. $PREFIX/etc/proot-distro/archlinux.sh

DISTRO_NAME="Archbox"
DISTRO_COMMENT="Custom setup for Arch Linux, implemented as a distro plugin for proot-distro."

distro_setup() {
  # Fix environment variables on login or su.
  local f
  for f in su su-l system-local-login system-remote-login; do
    echo "session  required  pam_env.so readenv=1" >> ./etc/pam.d/"\${f}"
  done

  # Add user
  echo "$(cat $HOME/.archbox_user) ALL=(ALL) NOPASSWD:ALL" >> ./etc/sudoers
  run_proot_cmd useradd -m -G wheel -U $(cat $HOME/.archbox_user)

  # Run updates
  run_proot_cmd pacman -Syu sudo --noconfirm
}
EOF
      # Install system
      proot-distro install proot-archbox --override-alias "${1:-$arch_container_name}"
      # Run setup script as normal user
	  proot-distro login "${1:-$arch_container_name}" --user $(cat $HOME/.archbox_user) --termux-home -- $2
    else
      echo "The proot ${1:-$arch_container_name} already exists."
    fi
  ;;
esac
