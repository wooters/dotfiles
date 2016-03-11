# Base16 Shell
BASE16_SHELL="$HOME/.config/base16-shell/base16-default.dark.sh"
[[ -s $BASE16_SHELL ]] && source $BASE16_SHELL

export CLICOLOR=1
export LSCOLORS=gacacxdxbxegedabagacad

export ALTERNATE_EDITOR=emacs EDITOR=emacsclient VISUAL=emacsclient

# virtualenv/virtualenvwrapaper
venv_sh=/usr/local/bin/virtualenvwrapper.sh
if [[ -f ${venv_sh} ]]; then
    source ${venv_sh}
fi

# Load aliases
if [[ -f "${HOME}/.bash_aliases" ]]; then
    source "${HOME}/.bash_aliases"
fi



