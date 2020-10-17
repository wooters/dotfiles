PATH="/usr/local/sbin:${PATH}"
PATH="$HOME/.cargo/bin:${PATH}"
PATH="/usr/local/opt/python/libexec/bin:${PATH}"
PATH="${HOME}/bin:${PATH}"
PATH="${PATH}:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

if [[ -f "${HOME}/.bash_profile_local" ]]; then
    source ${HOME}/.bash_profile_local
fi

if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

source ${HOME}/.bashrc
