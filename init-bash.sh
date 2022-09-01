#!/bin/bash

mkdir -p ~/.bash
cd ~/.bash
curl -O https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh
curl -O https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash
curl -O https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/plugins/git/git.plugin.zsh

grep "^alias" git.plugin.zsh | grep -v "\\$" > ~/.bash_aliases
