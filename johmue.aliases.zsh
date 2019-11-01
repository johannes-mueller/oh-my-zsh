typeset -a expanded_aliases
expanded_aliases=()

typeset -a expanded_aliases_no_whitespace
expanded_aliases_no_whitespace=()

ealias() {
    alias $@
    args="$@"
    args=${args%%\=*}
    expanded_aliases+=(${args##* })
}

ealiasnw() {
    alias $@
    args="$@"
    args=${args%%\=*}
    expanded_aliases_nw+=(${args##* })
}

expand-ealias-space() {
    if [[ $LBUFFER =~ "\<(${(j:|:)expanded_aliases_nw})\$" ]]; then
	zle _expand_alias
	zle backward-delete-char
    elif [[ $LBUFFER =~ "\<(${(j:|:)expanded_aliases})\$" ]]; then
	zle _expand_alias
	zle self-insert
    else
	zle self-insert
    fi
}
zle -N expand-ealias-space

bindkey " " expand-ealias-space


alias afu="sudo apt full-upgrade"
alias apu="sudo apt update"
ealias api="sudo apt install"
ealias apr="sudo apt remove"


ealias scrs="sudo systemctl restart"
ealias scst="sudo systemctl start"
ealias scsp="sudo syscemctl stop"
ealias scss="sudo systemctl status"


alias gr='cd `git rev-parse --show-toplevel`'
alias gs='git status'
alias gl='git glog'
alias gd='git diff'
