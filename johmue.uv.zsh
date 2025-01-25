
activate_local_uv_env() {
    if [[ -e ./.venv/pyvenv.cfg ]] && [[ $UV_PREFIX != "$(pwd)/.venv" ]] ; then
	source ./.venv/bin/activate
    fi
}

source $HOME/.pyenvs/base/bin/activate

activate_local_uv_env

autoload -U add-zsh-hook
add-zsh-hook chpwd activate_local_uv_env
