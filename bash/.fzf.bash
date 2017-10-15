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
# Using highlight (http://www.andre-simon.de/doku/highlight/en/highlight.html)
#   for code highlighting.
preview="--preview '(highlight -O xterm256 -t 4 {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null | head -200' \
         --preview-window right"
export FZF_CTRL_T_OPTS="-m --reverse --border --tabstop 4 ${preview}"

