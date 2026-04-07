#!/bin/bash

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

##############
### Config ###
##############

# Default name for new arch container
export arch_container_name="devbox"

function e {
    case $EDITOR in
        nvim*)
            local command="$EDITOR"
            # If any arguments start with :, group all remaining arguments together
            while [[ "$1" != "" ]]; do
                if [[ ! $1 == :* ]]; then
                    command+=" $1"
                else
                    # If $NVIM exists
                    if [[ "$NVIM" != "" ]]; then
                        command+=" --cmd \"$1\""
                    else
                        command+=" -c \"$1\""
                    fi
                fi
                shift
            done

            # Don't let the escaped quotes get included in the args, use eval
            eval $command
        ;;
        *)
            $EDITOR $@
        ;;
    esac
}
alias ls="ls -h --color=always --group-directories-first"
alias ll="ls -l"
alias la="ls -a"
alias lla="ls -la"
alias tree='tree --filesfirst -CAI ".git"'
alias wcd='cd $(walk)'

# "Enter Archbox"
function ea {
    # If no argument is given, engage default setup script
	[ -z "$1" ] && setup_script=$HOME/dotfiles/setup-arch.sh
	if ! bash archbox.sh --list | grep -q "arch-${1:-$arch_container_name}"; then
		bash archbox.sh "arch-${1:-$arch_container_name}" $setup_script && ea "${1:-$arch_container_name}"
	else
		bash archbox.sh --enter "arch-${1:-$arch_container_name}"
	fi
}

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

function install-nvim {
	curl -LO https://github.com/neovim/neovim/releases/download/v0.10.1/nvim-linux64.tar.gz
	tar -xvf nvim-linux64.tar.gz --strip-components=1 -C $HOME/.local
	rm nvim-linux64.tar.gz
}

function podman-wl {
    podman "$1" \
      --security-opt label=disable \
      --uidmap 0:1:1000 \
      --uidmap 1000:0:1 \
      --uidmap 1001:1001:64535 \
      --gidmap 0:1:1000 \
      --gidmap 1000:0:1 \
      --gidmap 1001:1001:64535 \
      -e WAYLAND_DISPLAY=$WAYLAND_DISPLAY \
      -e XDG_RUNTIME_DIR=/tmp/ \
      -v $XDG_RUNTIME_DIR/$WAYLAND_DISPLAY:/tmp/$WAYLAND_DISPLAY:ro \
      --device /dev/dri "${@:2}"
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
