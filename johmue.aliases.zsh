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

ealiasnw afu="sudo apt full-up"

ealias scrs="sudo systemctl restart"
ealias scst="sudo systemctl start"
ealias scst="sudo syscemctl stop"
ealias scss="sudo systemctl status"

bindkey " " expand-ealias-space


alias gr='cd `git rev-parse --show-toplevel`'
