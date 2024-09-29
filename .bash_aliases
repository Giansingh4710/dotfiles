#!/bin/bash

if [ -f ~/dotfiles/scripts/alias.sh ]; then
  . ~/dotfiles/scripts/alias.sh
fi

alias ls='ls --color=auto' # see colors when using ls
alias gs="git status"
alias ..='cd ..'
alias ...='cd ../..'
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias df='df -h' # disk free, in Gigabytes, not bytes
alias lpath='echo $PATH | tr ":" "\n"' # list the PATH separated by new lines

if [[ "$OSTYPE" == "darwin2"* ]]; then
  alias ios='open -a /Applications/Xcode.app/Contents/Developer/Applications/Simulator.app'
  alias toggleyabai="~/dotfiles/configs/skhd/toggleyabai.sh"
  alias nvims="~/dotfiles/nvim/switch_configs.sh"

  alias ai="ollama run llama2-uncensored"
  alias codeai="ollama run codellama:7b-code"
  alias obd="cd '/Users/gians/Library/Mobile Documents/iCloud~md~obsidian/Documents/'"
fi

if [[ ~ == "/Users/gians" ]];then
  alias icloud="cd ~/Library/Mobile\ Documents/com\~apple\~CloudDocs/"
  alias randTxt="v ~/Library/Mobile\ Documents/com\~apple\~CloudDocs/randomTxtFiles/info.txt"

  alias dev="cd /Users/gians/Desktop/dev"
  alias todo="v /Users/gians/Desktop/todo.md"
  alias ssa="nvim /Users/gians/Desktop/NJIT/SSA/SSA23-24.txt"
  alias py_src="source ~/py3_venv_1/bin/activate"

  alias ghcs="gh copilot suggest"
  alias ghce="gh copilot explain"
fi

# check if nvim is installed
if command -v nvim &> /dev/null; then
  alias v="nvim"
  alias vimrc="nvim ~/dotfiles/configs/nvim/init.lua"
else
  alias v="vim"
  alias vimrc="vim ~/.vimrc"
fi

if command -v tmux &> /dev/null; then
  alias t="tmux"
fi

if command -v trash &> /dev/null; then
  alias rm=trash
fi

# if command -v bat &> /dev/null; then
  # alias cat='bat --paging=never'
# fi

if command -v zoxide &> /dev/null; then
  alias cd="z"
fi

if command -v lazygit &> /dev/null; then
  alias lg='lazygit'
fi

if command -v python3 &> /dev/null; then
  alias py="python3"
  alias python="python3"
fi

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
  alias open="xdg-open"
  alias start="explorer.exe"
fi

cap () { tee /tmp/capture.out; } # capture the output of a command so it can be retrieved with ret
ret () { cat /tmp/capture.out; } # return the output of the most recent command that was captured by cap

# if [ -e /tmp/last_working_dir ]; then
#   cd "$(cat /tmp/last_working_dir )" ; echo "Last working directory..."
# fi
# save_dir_changed () { pwd > /tmp/last_working_dir; }
# chpwd_functions+=(save_dir_changed) # chpwd_functions is an array of function names which when the working directory changes
