
PATH=${HOME}/bin:${PATH}

if [[ -f "${HOME}/.bash_profile_local" ]]; then
    source ${HOME}/.bash_profile_local
fi

source ${HOME}/.bashrc
