#!/data/data/com.termux/files/usr/bin/bash
# When run with no args: 
# - Generate a shim script for each defined function in ~/.shortcuts.
# When run with one arg: 
# - Run the given function.

########################################
# Define your functions here:

Termux-Shell() {
  bash -l
}

Arch-Shell() {
  bash $HOME/.local/bin/archbox.sh --enter arch-devbox
}

Arch-Editor() {
  bash $HOME/.local/bin/archbox.sh --enter arch-devbox nvim
}

########################################

# Collect function names into a list
functions="$(declare -F | awk '{print $3}')"

# If no arguments are given to this script, create shims
if [ $# -eq 0 ]; then
  scriptname="$(realpath $0)"
  for function in $functions; do
    echo
    echo "Creating shim for $function"
    tee $HOME/.shortcuts/$function <<EOF
#!/data/data/com.termux/files/usr/bin/bash
# This is a generated shim file for a function in $scriptname
# Any edits to this file may be overwritten
# If the given function doesn't exist in $scriptname, this script should delete itself
bash $scriptname $function
if [ \$? -eq 5 ]; then
  echo "Function \$1 doesn't exist in $scriptname."
  echo "Deleting shim."
  rm $HOME/.shortcuts/$function
fi
EOF
    chmod +x $HOME/.shortcuts/$function
  done
# If the first arg is a function, run it
elif echo "$functions" | grep -q "$1"; then
  $1
# If the first arg isn't a function, exit with code 5, indicating the shim should be deleted
else
  exit 5
fi
