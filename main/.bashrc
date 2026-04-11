#!/bin/bash

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

##############
### Config ###
##############

# Default name for new arch container
export arch_container_name="devbox"

function e {
  $EDITOR $@
}
alias ls="ls -h --color=always --group-directories-first"
alias ll="ls -l"
alias la="ls -a"
alias lla="ls -la"
alias tree='tree --filesfirst -CAI ".git"'

#################
### TTY stuff ###
#################
if [ "$TERM" = "linux" ]; then
  # if file /lib/kbd/consolefonts/ter-228b.psf.gz exists, use it
  if [ -f /lib/kbd/consolefonts/ter-228b.psf.gz ]; then
    setfont /lib/kbd/consolefonts/ter-228b.psf.gz
      /bin/echo -e "
        \e]P0000000
        \e]P1ce0000
        \e]P200be00
        \e]P3ffee00
        \e]P43575ff
        \e]P5923cff
        \e]P600d991
        \e]P7f2a400
        \e]P8505050
        \e]P9ff3e3e
        \e]PA95d00f
        \e]PBf2a400
        \e]PC19bbfb
        \e]PDdc00c8
        \e]PE00ffd5
        \e]PFffffff
      "
  fi
fi

#################
### Dev tools ###
#################

function c {
    case "$1" in
      devbox)
        shift
        if [ -n "$1" ]; then
          CONTAINER_NAME="$1"
        else
          CONTAINER_NAME="devbox"
        fi

        if [ -n "$2" ]; then
          IMAGE="$2"
        else
          IMAGE="ghcr.io/ac-z/tuesday:latest"
        fi

        if ! podman ps -a --format '{{.Names}}' | grep -q "^${CONTAINER_NAME}$"; then
          podman create \
            --security-opt label=disable \
            --cap-add=NET_RAW \
            --uidmap 0:1:1000 \
            --uidmap 1000:0:1 \
            --uidmap 1001:1001:64535 \
            --gidmap 0:1:1000 \
            --gidmap 1000:0:1 \
            --gidmap 1001:1001:64535 \
            -e WAYLAND_DISPLAY=$WAYLAND_DISPLAY \
            -e XDG_RUNTIME_DIR=/tmp/ \
            -v $XDG_RUNTIME_DIR/$WAYLAND_DISPLAY:/tmp/$WAYLAND_DISPLAY:ro \
            -e SSH_AUTH_SOCK=/tmp/ssh-auth.sock \
            -v $SSH_AUTH_SOCK:/tmp/ssh-auth.sock:ro \
            --device /dev/dri \
            --name $CONTAINER_NAME \
            "$IMAGE" \
            sleep infinity
        fi
        podman start $CONTAINER_NAME
        ;;
      *)
        podman "$@"
        ;;
    esac
}

#####################
### Env Variables ###
#####################

export XDG_CONFIG_HOME="${HOME}/.config"

## Path vars
function ensure_dir_in_path_var() {
	[[ ":${!1}:" == *":$2:"* ]] || export "$1"="${!1}:$2"
}
function add_usrprefix() {
	ensure_dir_in_path_var PATH $1/bin
	ensure_dir_in_path_var LD_LIBRARY_PATH $1/lib
}
add_usrprefix "${HOME}/.local"

## Editor variable
# If Neovim is installed
if hash "nvim" &>/dev/null; then
	export EDITOR="nvim -O"
    export MANPAGER="nvim +Man!"
# If Neovim is not installed
elif hash "vim" &>/dev/null; then
	export EDITOR="vim -O"
elif hash "vi" &>/dev/null; then
	export EDITOR="vi -O"
elif hash "nano" &>/dev/null; then
	export EDITOR="nano"
fi
export VISUAL=$EDITOR

# Source Rust's env
export CARGO_HOME="$HOME/.config/cargo"
if [ -f "$HOME/.config/cargo/env" ]; then
	. "$HOME/.config/cargo/env"
fi

# Paths
function source_if_exists {
	if [ -f "$1" ]; then
		. "$1"
	fi
}
# GNU/Linux completions
source_if_exists /usr/share/bash-completion/bash_completion
# Termux completions
source_if_exists $PREFIX/share/bash-completion/bash_completion

# Prompt
. _bash_prompt
