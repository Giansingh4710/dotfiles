#!/bin/bash

if [ -f ~/dotfiles/scripts/alias.sh ]; then
  . ~/dotfiles/scripts/alias.sh
fi

if [ -f ~/dotfiles/api_keys.sh ]; then
  . ~/dotfiles/api_keys.sh
fi

alias ls='ls --color=auto' # see colors when using ls
alias ll='ls -l'
alias ..='cd ..'
alias ...='cd ../..'
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias df='df -h'                       # disk free, in Gigabytes, not bytes
alias lpath='echo $PATH | tr ":" "\n"' # list the PATH separated by new lines

alias gc="git checkout"
alias gs="git status"
alias glog="git log --graph --topo-order --pretty='%w(100,0,6)%C(yellow)%h%C(bold)%C(black)%d %C(cyan)%ar %C(green)%an%n%C(bold)%C(white)%s %N' --abbrev-commit"

alias configs="v ~/dotfiles -c ':chdir ~/dotfiles'"
alias yankp="curl 'https://yankpaste.xyz/getTexts' | jq -r '.rows[0].text'"
pastey() {
  local input
  input=$(printf "%s" "$*" | jq -Rs .) # Safely escape input for JSON
  curl -H 'Content-Type: application/json' \
    -d "{\"text\":${input}}" \
    -X POST https://yankpaste.xyz/saveText
}
uploadyp() {
  if [ -z "$1" ]; then
    echo "Usage: uploadyp <filename>"
    return 1
  fi

  if [ ! -f "$1" ]; then
    echo "File '$1' not found!"
    return 1
  fi

  curl -X POST -F "file=@$1" https://yankpaste.xyz/upload
}

if [[ "$OSTYPE" == "darwin2"* ]]; then
  alias oo="v  '/Users/gians/Library/Mobile Documents/iCloud~md~obsidian/Documents/KhojDil/' -c ':chdir /Users/gians/Library/Mobile Documents/iCloud~md~obsidian/Documents/KhojDil/'"
  alias diskspace="system_profiler SPStorageDataType | grep 'Free' | head -1"
  alias ios='open -a /Applications/Xcode.app/Contents/Developer/Applications/Simulator.app'
  alias battery="pmset -g batt"

  alias icloud="cd ~/Library/Mobile\ Documents/com\~apple\~CloudDocs/"
  if [[ ~ == "/Users/gians" ]]; then
    alias randTxt="v ~/Library/Mobile\ Documents/com\~apple\~CloudDocs/randomTxtFiles/info.txt"
    alias dev="cd /Users/gians/Desktop/dev"
    alias ssa="nvim /Users/gians/Desktop/NJIT/SSA/SSA23-24.txt"
    alias py_src="source ~/py3_venv_1/bin/activate"
    alias ghcs="gh copilot suggest"
    alias ghce="gh copilot explain"
  fi

  frontmost() {
    osascript -e 'tell application "System Events" to tell process '"\"$1\"" \
      -e 'set frontmost to true' \
      -e 'end tell'
  }
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
  alias battery="upower -i $(upower -e | grep 'BAT') | grep -E \"state|to\\ full|percentage\""
  diskspace() {
    df -BG --total | grep 'total' | awk '{print "🖥️  Total: " $2 "  |  📂 Used: " $3 "  |  📦 Free: " $4}'
  }
fi

if command -v nvim &>/dev/null; then
  alias v="nvim"
  alias vimrc="nvim ~/dotfiles/configs/nvim/init.lua -c ':chdir ~/dotfiles/configs/nvim'"
else
  alias v="vim"
  alias vimrc="vim ~/.vimrc"
fi

if command -v tmux &>/dev/null; then
  alias t="tmux"
fi

if command -v trash &>/dev/null; then
  alias rm=trash
fi

if command -v lazygit &>/dev/null; then
  alias lg='lazygit'
fi

if command -v python3 &>/dev/null; then
  alias py="python3"
  alias python="python3"
fi

cap() { tee /tmp/capture.out; } # capture the output of a command so it can be retrieved with ret
ret() { cat /tmp/capture.out; } # return the output of the most recent command that was captured by cap

if [[ "$OSTYPE" == "darwin2"* ]]; then
  export REACT_EDITOR=nvim
  export ANDROID_HOME=$HOME/Library/Android/sdk
  export PATH=$PATH:$ANDROID_HOME/emulator
  export PATH=$PATH:$ANDROID_HOME/platform-tools
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion
  [ -s "/Users/gians/.bun/_bun" ] && source "/Users/gians/.bun/_bun"
  export BUN_INSTALL="$HOME/.bun"
  export PATH="$BUN_INSTALL/bin:$PATH"
fi
