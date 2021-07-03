alias cd="cdls"
alias ..="cd .."
alias ..2="cd ../../"
alias ..3="cd ../../../"
alias ..4="cd ../../../../"
alias ..5="cd ../../../../../"

function groot() {
if [ "$(git rev-parse --is-inside-work-tree 2> /dev/null)" = "true" ]
  then
    cd $(git rev-parse --show-toplevel)
  else
	echo Not a git repository.
  fi
}
function pd() {
    pushd $1 > /dev/null
    ls
}
function cdls() {
    # add "\" to aboid from recursive call
    \cd $1 && ls;
}
function mkcd() {
	mkdir $1 && \cd
}

local_alias_file=~/.alias_local.sh
if [ -f $local_alias_file ]
then
    source $local_alias_file
fi

# suffix alias
function extract() {
    case $1 in
        *.tar.gz|*.tgz) tar xzvf $1 ;;
        *.tar.xz) tar Jxvf $1 ;;
        *.zip) unzip $1 ;;
        *.lzh) lha e $1 ;;
        *.tar.bz2|*.tbz) tar xjvf $1 ;;
        *.tar.Z) tar zxvf $1 ;;
        *.gz) gzip -dc $1 ;;
        *.bz2) bzip2 -dc $1 ;;
        *.Z) uncompress $1 ;;
        *.tar) tar xvf $1 ;;
        *.arj) unarj $1 ;;
    esac
}
alias -s {gz,tgz,zip,lzh,bz2,tbz,Z,tar,arj,xz}=extract

alias gd="git diff --color-words"
