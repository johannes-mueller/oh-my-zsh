
__conda_setup=`($HOME/.miniconda3/bin/conda 'shell.zsh' 'hook' 2> /dev/null)`
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "${HOME}/.miniconda3/etc/profile.d/conda.sh" ]; then
        . "${HOME}/.miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="${HOME}/.miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup

conda config --set changeps1 false

activate_local_conda_env() {
    if [[ -d ./.venv/conda-meta ]] && [[ $CONDA_PREFIX != "$(pwd)/.venv" ]] ; then
	conda activate ./.venv
    fi
}

activate_local_conda_env

autoload -U add-zsh-hook
add-zsh-hook chpwd activate_local_conda_env

precmd_conda_info() {
    if [[ -n $CONDA_PREFIX ]]; then
       if [[ $(basename $CONDA_PREFIX) == ".miniconda3" ]]; then
          CONDA_ENV="(base) "
       else
         CONDA_ENV="($(echo $CONDA_PREFIX | sed s%$HOME/.miniconda3/envs/%%\;s%$PWD%.%\;s%$HOME%~% )) "
       fi
    else
      CONDA_ENV=""
    fi
}

precmd_functions+=( precmd_conda_info )
