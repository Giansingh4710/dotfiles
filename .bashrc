#!/bin/bash

# .bashrc file
# Author: Zheng Hao Tan <tanzhao@umich.edu>
# MIT License

# These are my bashrc settings. Feel free to take whatever you want.

BLUE='\[\e[01;34m\]'
RED='\[\e[01;32m\]'
WHITE='\[\e[01;0m\]'
GREEN='\[\033[32m\]'
YELLOW='\[\033[33m\]'
bind 'set completion-ignore-case on'
parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
PS1="${GREEN}\w ${YELLOW}\$(parse_git_branch) ${WHITE}$ "

# Get the aliases and functions
# shellcheck source=/dev/null
if [ -f ~/.oxalate_shell_rc ]; then
  . ~/.oxalate_shell_rc
fi

# shellcheck source=/dev/null
[[ -f "$HOME/git-completion.bash" ]] && source "$HOME/git-completion.bash"

# shellcheck source=/dev/null
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
