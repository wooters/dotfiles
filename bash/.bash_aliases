alias l='exa -F'
alias ll='exa -l -F --git --color-scale -s modified'
alias pu=pushd
alias po=popd
alias dirs='dirs -v'
alias rmtil='rm *~'
alias em='emacsclient -c'

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

# Directory "book marks" (based on "cd global" from: https://dmitryfrank.com/articles/shell_shortcuts)
# Requires 'fzf', which can be installed using: brew install fzf
#

# Where to store the list of book marks
marks_file="${HOME}/.marks_paths"

# Show the list of book marks in `fzf`. If a mark is selected in `fzf`
# then cd to that dir.
marks() {
   local dest_dir=$(cat $marks_file | sed '/^\s*$/d' | fzf )
   if [[ $dest_dir != '' ]]; then
      cd $dest_dir
   fi
}

# Add to the list of book marks
# Examples:
#   `marks_add`                   # add the current dir
#   `marks_add project base dir`  # add the current dir and the comment "project base dir"
marks_add() {
    echo "${PWD} # $*" | cat $marks_file - | sort -u > ${marks_file}.new && mv ${marks_file}.new $marks_file
}


