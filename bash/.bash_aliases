alias l='ls -F'
alias ll='ls -Fal'
alias pu=pushd
alias po=popd
alias dirs='dirs -v'
alias rmtil='rm *~'
alias em=emacsclient
alias emacs=emacsclient

calc () {
    bc -l <<< "$@"
}

# tmux stuff

# with this, can do things like:
#   $ nw python   # run python in a new tmux window
#   $ nw -n python python # run python in a new tmux window called "python"
alias nw='tmux new-window'

# Splits the current window vertically and edits a given file
# in the lower tmux window
function e {
    tmux split-window "emacsclient -c $@"
}
