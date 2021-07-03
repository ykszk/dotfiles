#!/bin/bash
SCRIPT_PATH="${BASH_SOURCE[0]}"
SCRIPT_DIR="$( cd "$(dirname "$SCRIPT_PATH")" >/dev/null 2>&1 ; pwd -P )"

cd ~
mkdir -p ~/.bash
cd ~/.bash
curl -O https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh
curl -O https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash
curl -O https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/plugins/git/git.plugin.zsh

grep "^alias" git.plugin.zsh > git-aliases.sh

OS=$(bash $SCRIPT_DIR/which-os.sh)
lsc=$SCRIPT_DIR/home/snazzy.txt
if [ $OS = Windows ]
then
    echo LS_COLOR for Windows
	# Ignore 'x' flag
	# Reset ow.
	echo "ow=0:$(sed "s/ex=[^:]*:/ex=0:/" $lsc)" > ~/.bash/snazzy.txt
else
    echo LS_COLOR for Unix
	# https://github.com/sharkdp/vivid
	cp $lsc ~/.bash
fi
