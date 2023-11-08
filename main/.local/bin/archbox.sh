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
        proot-distro) proot-distro list ;;
      esac
      exit
    ;;
    -e|--enter) 
      shift
      case "$mode" in
        distrobox) distrobox enter "${1:-$arch_container_name}" ;;
        proot-distro) proot-distro login "${1:-$arch_container_name}" --user $(cat .archbox_user) --termux-home ;;
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
      if [ ! -f .archbox_user ]; then
        # Prompt user for desired username
        echo "Enter desired username: "
        read username
        echo "$username" > .archbox_user
      fi

      # Only include this line if $2 exists
      if [ -n "$2" ]; then
        setup_script_line="cp $2 ./$(basename $2) && run_proot_cmd bash /$(basename $2)"
      fi
      # create from heredoc
      cat <<EOF >$PREFIX/etc/proot-distro/proot-archbox.sh
DISTRO_NAME="Archbox"
DISTRO_COMMENT="Custom setup for Arch Linux, implemented as a distro plugin for proot-distro."

TARBALL_URL['aarch64']="https://github.com/termux/proot-distro/releases/download/v3.18.1/archlinux-aarch64-pd-v3.18.1.tar.xz"
TARBALL_SHA256['aarch64']="68de6db105dc503e8defe55ac37fad9b531f07aa16b8a8072c505fff5fbc03a1"
TARBALL_URL['arm']="https://github.com/termux/proot-distro/releases/download/v3.18.1/archlinux-arm-pd-v3.18.1.tar.xz"
TARBALL_SHA256['arm']="2701e2aac78bb0cb86f113701ae226c35b38a4e8f5404ae97e7eb0cc4599ab79"

distro_setup() {
  # Fix environment variables on login or su.
  local f
  for f in su su-l system-local-login system-remote-login; do
    echo "session  required  pam_env.so readenv=1" >> ./etc/pam.d/"\${f}"
  done

  echo "$username ALL=(ALL) NOPASSWD:ALL" >> ./etc/sudoers
  run_proot_cmd useradd -m -G wheel -U $username

  # Copy the setup script
  $setup_script_line
}
EOF

      proot-distro install proot-archbox --override-alias "${1:-$arch_container_name}"
    else
      echo "The proot ${1:-$arch_container_name} already exists."
    fi
  ;;
esac
