#!/bin/bash

BLUE='\[\e[01;34m\]'
RED='\[\e[01;31m\]'
WHITE='\[\e[01;0m\]'
GREEN='\[\033[32m\]'
YELLOW='\[\033[33m\]'
set -o vi

bind 'set completion-ignore-case on'
parse_git_branch(){
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
PS1="${BLUE}[${RED}\t${BLUE}] ${BLUE}[${GREEN}\w${BLUE}]${YELLOW}$(parse_git_branch) \n ${WHITE}-> "

# Get the aliases and functions
# shellcheck source=/dev/null
if [ -f ~/.oxalate_shell_rc ]; then
  . ~/.oxalate_shell_rc
fi

# shellcheck source=/dev/null
[[ -f "$HOME/git-completion.bash" ]] && source "$HOME/git-completion.bash"

# shellcheck source=/dev/null
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
alias cs280="cd /mnt/c/Users/gians/Desktop/CS/SchoolStuff/CS280"
alias cs="cd /mnt/c/Users/gians/Desktop/CS/"
alias schoolstuff="cd /mnt/c/Users/gians/Desktop/CS/SchoolStuff"
alias webdev="cd /mnt/c/Users/gians/Desktop/CS/WebDev"
alias pythons="cd /mnt/c/Users/gians/Desktop/CS/pythons"
alias open-pdf="xdg-open"
alias sdoji="python3 /mnt/c/Users/gians/Desktop/CS/pythons/randomstuff/randSikhStuff/sdoJi/sdojiWeb.py"
