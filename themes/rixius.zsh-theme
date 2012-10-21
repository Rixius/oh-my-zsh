#!/bin/zsh
# /|/ Code by Stephen
# /|/ "Rixius" Middleton
# 
# name in folder (github)
# ± if in github repo, or ≥ if otherwise Time in 24-hour format is on right.
function collapse_pwd {
    echo $(pwd | sed -e "s,^$HOME,~,")
}
function prompt_char {

    git branch >/dev/null 2>&1 && echo -n "%{$bg[white]%}%{$fg[red]%}>%{$reset_color%}" && return
    echo -n "%{$bg[white]%}%{$fg[red]%}$%{$reset_color%}"
    return
    # Keep the old version... for now.
    echo -n "%{$bg[white]%}%{$fg[red]%}"
    git branch >/dev/null 2>/dev/null && echo "±%{$reset_color%}" && return
    echo "≥%{$reset_color%}"
}
function rvmUsage {
  if rvm >/dev/null 2>/dev/null; then
    echo -n "$RIXIUS_PRE"
    echo -n `rvm current`
    echo -n "%{$reset_color%}"  
  fi
}


RIXIUS_PRE="%{$bg[white]%}%{$fg[red]%}"
PROMPT='
%{$RIXIUS_PRE%}%n%{$reset_color%} in %{$fg_bold[green]%}$(collapse_pwd)%{$reset_color%}$(git_prompt_info) $(rvmUsage)
$(prompt_char) '
RPROMPT='%{$RIXIUS_PRE%}%T%{$reset_color%}'

ZSH_THEME_GIT_PROMPT_PREFIX="(%{$fg[magenta]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%})"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$RIXIUS_PRE%}X%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$RIXIUS_PRE%}O%{$reset_color%}"
