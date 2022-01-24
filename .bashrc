#!/bin/bash

# Author: Zheng Hao Tan <tanzhao@umich.edu>
# MIT License
BLUE='\[\e[01;34m\]'
RED='\[\e[01;31m\]'
WHITE='\[\e[01;0m\]'
GREEN='\[\033[32m\]'
YELLOW='\[\033[33m\]'

bind 'set completion-ignore-case on'

parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

PS1="${BLUE}[\t] ${BLUE}[${GREEN}\w${BLUE}]${YELLOW}\$(parse_git_branch) ${WHITE}-> "



#hlaha asdhhsahlsa
#vahvdhd
# Get the aliases and functions
# shellcheck source=/dev/null
if [ -f ~/.oxalate_shell_rc ]; then
  . ~/.oxalate_shell_rc
fi

# shellcheck source=/dev/null
[[ -f "$HOME/git-completion.bash" ]] && source "$HOME/git-completion.bash"

# shellcheck source=/dev/null
[ -f ~/.fzf.bash ] && source ~/.fzf.bash


#so in PS1 var, i would do put '/d' to show Week Day

#d - "Weekday Month Date" format (e.g., "Tue May 26")
#e - an ASCII escape character (033)
#h - the hostname up to the first .
#H - the full hostname
#j - the number of jobs currently run in background
#l - the basename of the shells terminal device name
#n - newline
#r - carriage return
#s - the name of the shell, the basename of $0 (the portion following the final slash)
#t - the current time in 24-hour HH:MM:SS format
#T - the current time in 12-hour HH:MM:SS format
#@ - the current time in 12-hour am/pm format
#A - the current time in 24-hour HH:MM format
#u - the username of the current user
#v - the version of bash (e.g., 4.00)
#V - the release of bash, version + patch level (e.g., 4.00.0)
#w - Complete path of current working directory
#W - the basename of the current working directory
#! - the history number of this command
## - the command number of this command
#$ - if the effective UID is 0, a #, otherwise a $
#nnn - the character corresponding to the octal number nnn
#\ - a backslash
#[ - begin a sequence of non-printing characters, which could be used to embed a terminal control sequence into the prompt
#] - end a sequence of non-printing characters
