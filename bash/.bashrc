export CLICOLOR=1
export ALTERNATE_EDITOR=''
export EDITOR="emacsclient -nw"
export VISUAL="emacsclient -nw"
export LESS="-R"

if [ "$(uname -s)" == "Darwin" ]; then

    if [[ ${TERM_PROGRAM} == "iTerm.app" ]]; then
        # Base16 Shell
        BASE16_SHELL="$HOME/.config/base16-shell/base16-default.dark.sh"
        [[ -s $BASE16_SHELL ]] && source $BASE16_SHELL

        export LSCOLORS=gacacxdxbxegedabagacad
    fi

    [[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"

    if [ -f "$(/opt/homebrew/bin/brew --prefix)/opt/bash-git-prompt/share/gitprompt.sh" ]; then

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
        GIT_PROMPT_ONLY_IN_REPO=0
        __GIT_PROMPT_DIR=$(brew --prefix)/opt/bash-git-prompt/share
        source "$(brew --prefix)/opt/bash-git-prompt/share/gitprompt.sh"
    fi

elif [ "$(uname -s)" == "Linux" ]; then

    # Use bash-completion, if available
    [[ $PS1 && -f /usr/share/bash-completion/bash_completion ]] && \
    . /usr/share/bash-completion/bash_completion

    # Git prompt
    # GIT_PROMPT_SHOW_UNTRACKED_FILES=no
    GIT_PROMPT_ONLY_IN_REPO=0
    source ${HOME}/.bash-git-prompt/gitprompt.sh

fi

if [ -f "/usr/local/bin/aws_completer" ]; then
    complete -C '/usr/local/bin/aws_completer' aws
fi

if [ -f "${HOME}/.git-completion.bash" ]; then
    source ${HOME}/.git-completion.bash
fi

# export PIPENV_VENV_IN_PROJECT=1

# Chage the color for dates in `exa`. The default blue
# is unreadable with a black background. See https://the.exa.website/docs/colour-themes
# for more info
export EXA_COLORS="da=1;34"

# Load aliases
if [[ -f "${HOME}/.bash_aliases" ]]; then
    source "${HOME}/.bash_aliases"
fi

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

. "$HOME/.cargo/env"
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
