# Setup fzf
# ---------
if [[ ! "$PATH" == */usr/local/opt/fzf/bin* ]]; then
  export PATH="$PATH:/usr/local/opt/fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/usr/local/opt/fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "/usr/local/opt/fzf/shell/key-bindings.bash"

# Options to fzf command
export FZF_DEFAULT_OPTS="-m --reverse --border --tabstop 4"

# Setting ag as the default source for fzf (when you just run 'fzf')
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'

# For CTRL-T (find files) command
preview="--preview '[[ \$(file --mime {}) =~ binary ]] && echo {} no preview || \
                 (highlight -O xterm256 -t 4 {} || cat {}) 2> /dev/null | head -500' \
         --preview-window right"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="-m --reverse --border --tabstop 4 ${preview}"

