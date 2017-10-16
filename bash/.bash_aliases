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

# Based on "cd global" bookmarks from: https://dmitryfrank.com/articles/shell_shortcuts
#
cdg_file="${HOME}/.cdg_paths"
unalias cdg 2> /dev/null
cdg() {
   local dest_dir=$(cat $cdg_file | sed '/^\s*$/d' | fzf )
   if [[ $dest_dir != '' ]]; then
      cd $dest_dir
   fi
}
export -f cdg > /dev/null

unalias cdg-add 2> /dev/null
cdg-add () {
    local curr_dir="${PWD} # $*"
    if ! grep -Fxq "$curr_dir" $cdg_file; then
        echo "$curr_dir" >> $cdg_file
    fi
}
export -f cdg-add > /dev/null

