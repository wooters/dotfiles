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
