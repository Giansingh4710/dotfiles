#!/bin/bash

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
  alias cs288="cd /mnt/c/Users/gians/Desktop/CS/SchoolStuff/CS288"
  alias cs="cd /mnt/c/Users/gians/Desktop/CS/"
  alias schoolstuff="cd /mnt/c/Users/gians/Desktop/CS/SchoolStuff"
  alias webdev="cd /mnt/c/Users/gians/Desktop/CS/WebDev"
  alias pythons="cd /mnt/c/Users/gians/Desktop/CS/pythons"
  alias open="xdg-open"
  alias sdoji="python3 /mnt/c/Users/gians/Desktop/CS/pythons/randomstuff/randSikhStuff/sdoJi/sdojiWeb.py"
  alias start="explorer.exe"
  alias vim="nvim"
  alias settings="vim /mnt/c/Users/gians/AppData/Local/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState/settings.json"
  alias randShabad="python3 /mnt/c/Users/gians/Desktop/CS/pythons/randomstuff/randSikhStuff/randShabad.py"
  alias vimv="~/.dotfiles/vimv.sh"
fi

if [[ "$OSTYPE" == "darwin21"* ]]; then
  alias sdo="open /Applications/Safari.app https://sdoji.xyz/other_pages/all.html"
  alias vim="nvim"
  alias vimv="~/dotfiles/vimv.sh"
  alias python="python3"
  alias py="python3"
  alias toggleyabai="~/.config/skhd/toggleyabai.sh"
  alias cs288="cd /Users/gians/Desktop/dev/SchoolStuff/CS288"
  alias webdev="cd /Users/gians/Desktop/dev/webdev"
fi
