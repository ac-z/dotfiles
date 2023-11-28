#!/bin/bash

function current_user() {
  if [ -n "$USER" ]; then
    printf "$USER"
  else
    printf "$USERNAME"
  fi
}

# If in a git repo, get the git branch
[[ -d .git ]] && git_branch=" ($(git branch --show-current 2> /dev/null))"

echo "$(current_user)@$HOSTNAME:$(dirs)${git_branch}"
