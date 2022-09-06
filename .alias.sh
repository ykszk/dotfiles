alias config='git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
alias configui='gitui -d=$HOME/.cfg/ -w=$HOME'
alias configtig='GIT_DIR=$HOME/.cfg GIT_WORK_TREE=$HOME tig'

alias ..="cd .."
alias ..2="cd ../../"
alias ..3="cd ../../../"
alias ..4="cd ../../../../"
alias ..5="cd ../../../../../"

[[ "$TERM" == "xterm-kitty" ]] && alias ssh="kitty +kitten ssh"
