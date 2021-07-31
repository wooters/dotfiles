PATH="/usr/local/sbin:${PATH}"
PATH="$HOME/.cargo/bin:${PATH}"
PATH="/usr/local/opt/python/libexec/bin:${PATH}"
PATH="${HOME}/bin:${PATH}"
PATH="${PATH}:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

# put AWS credentials (or any other secrets) in ".bash_profile_local"
# and do NOT check this file into github
if [[ -f "${HOME}/.bash_profile_local" ]]; then
    source ${HOME}/.bash_profile_local
fi

source ${HOME}/.bashrc

if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init --path)"
fi

