
if [[ ${TERM_PROGRAM} == "iTerm.app" ]]; then
    # Base16 Shell
    BASE16_SHELL="$HOME/.config/base16-shell/base16-default.dark.sh"
    [[ -s $BASE16_SHELL ]] && source $BASE16_SHELL

    export LSCOLORS=gacacxdxbxegedabagacad
fi

export CLICOLOR=1
export ALTERNATE_EDITOR=emacs EDITOR=emacsclient VISUAL=emacsclient

if [[ -d "${HOME}/.bash-git-prompt" ]]; then
    source "${HOME}/.bash-git-prompt/gitprompt.sh"
    GIT_PROMPT_ONLY_IN_REPO=1
fi

# virtualenv/virtualenvwrapaper
venv_sh=/usr/local/bin/virtualenvwrapper.sh
if [[ -f ${venv_sh} ]]; then
    source ${venv_sh}
    # pip should only run if there is a virtualenv currently activated
    export PIP_REQUIRE_VIRTUALENV=true
    gpip2(){
	PIP_REQUIRE_VIRTUALENV="" /usr/local/bin/pip2 "$@"
    }
    gpip3(){
	PIP_REQUIRE_VIRTUALENV="" /usr/local/bin/pip3 "$@"
    }
fi

# Load aliases
if [[ -f "${HOME}/.bash_aliases" ]]; then
    source "${HOME}/.bash_aliases"
fi



