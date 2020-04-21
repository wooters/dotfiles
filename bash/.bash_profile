PATH="$HOME/.cargo/bin:${PATH}"
PATH="/usr/local/opt/python/libexec/bin:${PATH}"
PATH="/usr/local/opt/sbt@0.13/bin:${PATH}"
PATH="${HOME}/bin:${PATH}"

if [[ -f "${HOME}/.bash_profile_local" ]]; then
    source ${HOME}/.bash_profile_local
fi

if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

source ${HOME}/.bashrc
