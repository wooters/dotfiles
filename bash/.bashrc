
if [[ ${TERM_PROGRAM} == "iTerm.app" ]]; then
    # Base16 Shell
    BASE16_SHELL="$HOME/.config/base16-shell/base16-default.dark.sh"
    [[ -s $BASE16_SHELL ]] && source $BASE16_SHELL

    export LSCOLORS=gacacxdxbxegedabagacad
fi

export CLICOLOR=1
export ALTERNATE_EDITOR=''
export EDITOR="emacsclient -c"
export VISUAL="emacsclient -c"
export LESS="-R"

if [ -f "$(brew --prefix bash-completion)/etc/bash_completion" ]; then
    source "$(brew --prefix bash-completion)/etc/bash_completion"
fi

if [ -f "${HOME}/projects/codalab_bash/codalab_bash.sh" ]; then
    source "${HOME}/projects/codalab_bash/codalab_bash.sh"
fi

if [ -f "$(brew --prefix)/opt/bash-git-prompt/share/gitprompt.sh" ]; then
    
    function prompt_callback {
        local cl_prompt
        if [ -z ${HAVE_CL_BASH+x} ]; then
            echo ""
        else
            if ! cl_prompt=$(CL_PROMPT_INFO); then
                echo ""
            else
                if ! CL_WS_IS_CONSISTENT; then
                    echoc " [${BoldRed}${cl_prompt}${ResetColor}]"
                else
                    echo " [${cl_prompt}]"
                fi
            fi
        fi
    }
    
    # For customization info see: https://github.com/magicmonty/bash-git-prompt
    __GIT_PROMPT_DIR=$(brew --prefix)/opt/bash-git-prompt/share
    source "$(brew --prefix)/opt/bash-git-prompt/share/gitprompt.sh"
fi

if [ -f "${HOME}/.git-completion.bash" ]; then
    source ${HOME}/.git-completion.bash
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




[ -f ~/.fzf.bash ] && source ~/.fzf.bash
