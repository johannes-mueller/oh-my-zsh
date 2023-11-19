# vim:ft=zsh ts=2 sw=2 sts=2

PROMPT='${CONDA_ENV}
%(?.${fg[green]}✔.${fg[red]}✘ [%?]) %{$fg[blue]%}${PWD/#$HOME/~}
%{%(!.$fg_bold[red].$fg[green])%}%n@${HOST}%{$reset_color%}$(git_super_status) ⌚ \
%{$fg[blue]%}%*%{$reset_color%} <%j> %(!.$fg_bold[red]#$reset_color.%%) '

# Must use Powerline font, for \uE0A0 to render.
ZSH_THEME_GIT_PROMPT_PREFIX=" on %{$fg[magenta]%}\uE0A0 "
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}!"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[green]%}?"
ZSH_THEME_GIT_PROMPT_CLEAN=""

RPROMPT_TEMPLATE="%(?.%{$fg[green]%}✔ .%{$fg[red]%}✘ [%?])%{$reset_color%} "

function preexec() {
  timer=$(($(date +%s%0N)/1000000))
}

function precmd() {
  if [ $timer ]; then
    now=$(($(date +%s%0N)/1000000))
    elapsed=$(($now/1000-$timer/1000))

    export RPROMPT=$RPROMPT_TEMPLATE
    if [ $elapsed -gt 0 ] ; then \
    	export RPROMPT="${RPROMPT}⌛ %{$fg[cyan]%}${elapsed}s%{$reset_color%}"
    fi
    unset timer
  fi
}
