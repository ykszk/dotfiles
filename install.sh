#!/bin/bash
SCRIPT_PATH="${BASH_SOURCE[0]}"
SCRIPT_DIR="$( cd "$(dirname "$SCRIPT_PATH")" >/dev/null 2>&1 ; pwd -P )"

cd ~

if [[ $SCRIPT_DIR != ~/.dotfiles ]]
then
    mv $SCRIPT_DIR ~/.dotfiles 
fi

mkdir -p ~/.config
mkdir -p ~/.zsh
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
    cp ~/.dotfiles/home/snazzy.txt ~/.zsh/snazzy.txt
fi

mkdir -p ~/.cache/shell

# fish
if type fish >/dev/null 2>&1; then
    echo Setting up fish
    curl -sL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/plugins/git/git.plugin.zsh | grep "^alias" | grep -v '\$' > ~/.config/fish/conf.d/git-aliases.fish
    fish -c "curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher"
    fish -c "fisher update && set -U FZF_LEGACY_KEYBINDINGS 0"
    git clone --depth 1 https://github.com/yeseni-today/ays-fish-theme.git ~/.dotfiles/ays >/dev/null 2>&1
    cp ~/.dotfiles/ays/*.fish ~/.config/fish/functions && rm -rf ~/.dotfiles/ays
fi

echo All done.

if [[ $SHELL != $(which zsh) ]]
then
    echo Now execute
    echo chsh -s $(which zsh)
fi
