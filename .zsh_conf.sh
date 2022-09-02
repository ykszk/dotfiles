export LANG=en_US.UTF-8

case $OSTYPE in
    darwin*)
        gnubin=/usr/local/opt/coreutils/libexec/gnubin
        if [ -e $gnubin ]; then
            export PATH=$gnubin:$PATH
            alias ls="/usr/local/opt/coreutils/libexec/gnubin/ls --color"
        fi
esac

if [ -e ~/.zsh/snazzy.txt ]
then
    # https://github.com/sharkdp/vivid
    if [[ $(uname -r) == *Microsoft ]]
    then
        export LS_COLORS="ow=0:$(sed "s/ex=[^:]*:/ex=0:/"  ~/.zsh/snazzy.txt)"
    else
        export LS_COLORS="$(cat ~/.zsh/snazzy.txt)"
    fi
else
    eval `dircolors ~/.dir_colors -b`
fi

## Command history configuration
HISTFILE=${HOME}/.zsh_history
HISTSIZE=50000
SAVEHIST=50000
# ignore duplication command history list
setopt hist_ignore_dups
# share command history data
setopt share_history
# avoid dupuricating directory stack
setopt pushd_ignore_dups
# ignore command whose head is space
setopt hist_ignore_space


## historical backward/forward search with linehead string binded to ^P/^N
#
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^p" history-beginning-search-backward-end
bindkey "^n" history-beginning-search-forward-end
bindkey "\\ep" history-beginning-search-backward-end
bindkey "\\en" history-beginning-search-forward-end

## HISTIGNORE
zshaddhistory() {
    local line=${1%%$'\n'}
    local cmd=${line%% *}

    #Only add items matching condition below to history
    [[ ${#line} -ge 5
	    && ${cmd} != (l|l[sal])
	    && ${cmd} != (cd|dirs|ds|pd|af|afr)
	    && ${cmd} != (history)
	    && ${cmd} != (m|man)
	    && ${cmd} != (fg|bg|jobs|ps)
	    && ${cmd} != (screen)
	    ]]
}


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
