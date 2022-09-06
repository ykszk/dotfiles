#!/bin/bash
SCRIPT_PATH="${BASH_SOURCE[0]}"
SCRIPT_DIR="$( cd "$(dirname "$SCRIPT_PATH")" >/dev/null 2>&1 ; pwd -P )"

cd ~

mkdir -p ~/.config
mkdir -p ~/.zsh
mkdir -p ~/.bash
# install oh-my-zsh
if [ ! -e ~/.zsh/oh-my-zsh ]
then
    git clone --depth 1 https://github.com/robbyrussell/oh-my-zsh.git ~/.zsh/oh-my-zsh
fi

# install zaw
if [ ! -e ~/.zsh/zaw ]
then
    echo Installing zaw
    git clone --depth 1 https://github.com/zsh-users/zaw.git ~/.zsh/zaw
fi

OS=$(bash $SCRIPT_DIR/which-os.sh)
if [[ $OS == Windows ]]
then
    # Ignore 'x' flag
    # Reset ow.
    echo "ow=0:$(sed "s/ex=[^:]*:/ex=0:/" ~/.dotfiles/home/snazzy.txt)" > ~/.zsh/snazzy.txt
else
    # https://github.com/sharkdp/vivid
    cp ~/.dotfiles/snazzy.txt ~/.zsh/snazzy.txt
fi
cp ~/.zsh/snazzy.txt ~/.bash

mkdir -p ~/.cache/shell

# bash
source ~/.dotfiles/init-bash.sh

# fish
if type fish >/dev/null 2>&1; then
    echo Setting up fish
    fish ~/.dotfiles/init-fish.fish
fi

echo All done.
