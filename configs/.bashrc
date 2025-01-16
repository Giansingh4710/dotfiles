#!/bin/bash

echo "Remember Vaheguru Ji With Every Breath"

BLUE='\[\e[01;34m\]'
RED='\[\e[01;31m\]'
WHITE='\[\e[01;0m\]'
GREEN='\[\033[32m\]'
YELLOW='\[\033[33m\]'
set -o vi

parse_git_branch() {
	git branch 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
PS1="${BLUE}[${RED}\t${BLUE}] ${BLUE}[${GREEN}\w${BLUE}]${YELLOW}\$(parse_git_branch) \n ${WHITE}-> "

if [ -f ~/dotfiles/bash_aliases ]; then
	. ~/dotfiles/bash_aliases
fi

if command -v starship &> /dev/null; then
  eval "$(starship init bash)" # makes cmd line pretty
fi
