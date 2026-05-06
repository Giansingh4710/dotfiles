# if [ -x /opt/homebrew/bin/brew ]; then
#   eval "$(/opt/homebrew/bin/brew shellenv)"
# fi

if [ -f ~/dotfiles/bash_aliases ]; then
    . ~/dotfiles/bash_aliases
fi

eval "$(fzf --zsh)"
export PATH="$HOME/.local/bin:$PATH" # for claude code

# ----- Custom ZSH settings to Make it Look nice-----
autoload -U colors && colors # Enable colors
setopt PROMPT_SUBST

# ----- Theme definitions -----
autoload -U colors && colors
setopt PROMPT_SUBST
zmodload zsh/datetime

# ----- Git -----
parse_git_branch() {
  git rev-parse --abbrev-ref HEAD 2>/dev/null | sed 's/^/(/;s/$/)/'
}

# ----- Timer -----
preexec() {
  CMD_START=$EPOCHREALTIME
}

precmd() {
  if [[ -n $CMD_START ]]; then
    local start_ms end_ms total_ms
    printf -v start_ms '%.0f' $(( CMD_START * 1000 ))
    printf -v end_ms   '%.0f' $(( EPOCHREALTIME * 1000 ))
    total_ms=$(( end_ms - start_ms ))

    local total_sec=$(( total_ms / 1000 ))
    local hours=$(( total_sec / 3600 ))
    local mins=$(( (total_sec % 3600) / 60 ))
    local secs=$(( total_sec % 60 ))
    local ms=$(( total_ms % 1000 ))

    CMD_TIME=""
    (( hours > 0 )) && CMD_TIME+="${hours}h "
    (( mins  > 0 )) && CMD_TIME+="${mins}m "
    if (( total_sec > 0 )); then
      CMD_TIME+="${secs}s"
    else
      CMD_TIME+="${ms}ms"
    fi

    unset CMD_START
  else
    CMD_TIME=""
  fi
}

PATH_COLOR="%{$fg[yellow]%}"
GIT_COLOR="%{$fg[green]%}"
PROMPT_COLOR="%{$fg[white]%}"
TIME_COLOR="%{$fg[white]%}"
DURATION_COLOR="%{$fg[red]%}"

# ----- Prompt -----
PROMPT="${PATH_COLOR}%~%{$reset_color%} ${GIT_COLOR}\$(parse_git_branch)%{$reset_color%}
${PROMPT_COLOR}❯%{$reset_color%} "
[[ -n "$SSH_CONNECTION" ]] && PROMPT='%n@%m '$PROMPT

RPROMPT='%{$fg[white]%}%*%{$reset_color%} %{$fg[magenta]%}${CMD_TIME}%{$reset_color%}'
