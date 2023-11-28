#!/bin/bash

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

##############
### Config ###
##############

# Default name for new arch container
arch_container_name="devbox"

alias e=\$EDITOR
alias ls="ls --color=always --group-directories-first"
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
### Dev tools ###
#################

function install-nvim {
	curl -LO https://github.com/neovim/neovim/releases/download/v0.9.2/nvim-linux64.tar.gz
	tar -xvf nvim-linux64.tar.gz --strip-components=1 -C $HOME/.local
	rm nvim-linux64.tar.gz
}

# Source Rust's env
export CARGO_HOME="$HOME/.config/cargo"
if [ -f "$HOME/.config/cargo/env" ]; then
	. "$HOME/.config/cargo/env"
fi

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
	# Neovim-remote editing support
	if hash "nvr" &>/dev/null; then
		export NVR_CMD=$EDITOR
		if [ -n "$NVIM" ]; then
			export EDITOR="nvr --remote -so"
		fi
	fi
# If Neovim is not installed
elif hash "vim" &>/dev/null; then
	export EDITOR="vim -O"
elif hash "vi" &>/dev/null; then
	export EDITOR="vi -O"
elif hash "nano" &>/dev/null; then
	export EDITOR="nano"
fi
export VISUAL=$EDITOR

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
. ~/.bash_prompt
