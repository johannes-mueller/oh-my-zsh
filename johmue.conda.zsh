
conda config --set changeps1 false

precmd_conda_info() {
    if [[ -d ./.venv/conda-meta ]] && [[ $CONDA_PREFIX != "$(pwd)/.venv" ]] ; then
	conda activate ./.venv
    fi
    if [[ -n $CONDA_PREFIX ]]; then
       if [[ $(basename $CONDA_PREFIX) == "miniconda3" ]]; then
          CONDA_ENV="(base) "
       else
         CONDA_ENV="($(echo $CONDA_PREFIX | sed s%$PWD%.% | sed s%$HOME%~%)) "
       fi
    else
      CONDA_ENV=""
    fi
}

precmd_functions+=( precmd_conda_info )
