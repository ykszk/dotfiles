export LANG='ja_JP.UTF-8'
#eval `dircolors ~/.dir_colors -b`
export LS_COLORS="$(cat ~/.bash/snazzy.txt)"
source ~/.bash/git-prompt.sh
source ~/.bash/git-completion.bash
for f in ~/.bash/git-prompt.sh ~/.bash/git-completion.bash ~/.bash/git-aliases.sh
do
	if [ -e $f ]
	then
		source $f
	fi
done

# prompt
export PS1='\[\033[36m\]\u \[\033[0m\]@ \[\033[32m\]\h\[\e[m\] in \[\e[33m\]\w\[\e[m\]$(__git_ps1)'$'\n\[\e[31m\]\\$\[\e[m\] '
GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWUNTRACKEDFILES=
GIT_PS1_SHOWSTASHSTATE=
GIT_PS1_SHOWUPSTREAM=

# Set hostname as window name for screen
case "$TERM" in
	screen)
	PROMPT_COMMAND='echo -ne "\ek`echo ${HOSTNAME%%.*}`\e\\"'
	;;
esac

alias ls='ls --color'
