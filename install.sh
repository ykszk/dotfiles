#!/bin/bash
SCRIPT_PATH="${BASH_SOURCE[0]}"
SCRIPT_DIR="$( cd "$(dirname "$SCRIPT_PATH")" >/dev/null 2>&1 ; pwd -P )"

cd ~

if [[ $SCRIPT_DIR != ~/.dotfiles ]]
then
    mv $SCRIPT_DIR ~/.dotfiles 
fi

mkdir_w_check() {
if [ ! -e $1 ]
then
    mkdir -p $1
fi
}

# install oh-my-zsh
if [ ! -e ~/.zsh/oh-my-zsh ]
then
    git clone --depth 1 https://github.com/robbyrussell/oh-my-zsh.git ~/.zsh/oh-my-zsh
fi

echo Making symbolic links
mkdir_w_check ~/.dotfiles/.backup
mkdir_w_check ~/.config
for f in .zshrc .zsh_conf.sh .vimrc .dir_colors .gitconfig .alias.sh .Xdefaults .screenrc .git_commit_msg .tmux.conf .emacs.d .config/fish
do
    if [ \( -f $f -o \( -d ~/$f \) \) -a \( ! -L ~/$f \) ] # regular file exists and it's not a symlink
    then
        echo Backing up $f
        mv $f ~/.dotfiles/.backup/$f
    fi
    if [ ! -L ~/$f ]
    then
        ln -s ~/.dotfiles/home/$f ~/$f
    fi
done

# install zaw
if [ ! -e ~/.zsh/zaw ]
then
    echo Installing zaw
    mkdir_w_check ~/.zsh
    cd ~/.zsh
    git clone --depth 1 https://github.com/zsh-users/zaw.git
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

cd ~
mkdir_w_check ~/.cache/shell

# fish
if type fish >/dev/null 2>&1; then
    echo Setting up fish
    mkdir -p ~/.config/fish/conf.d/
    curl -sL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/plugins/git/git.plugin.zsh | grep "^alias" | grep -v '\$' > ~/.config/fish/conf.d/git-aliases.fish
    fish -c "curl -sL https://git.io/fisher | source && fisher update"
    fish -c "set -U FZF_LEGACY_KEYBINDINGS 0"
    git clone --depth 1 https://github.com/yeseni-today/ays-fish-theme.git ~/.dotfiles/ays >/dev/null 2>&1
    cp ~/.dotfiles/ays/*.fish ~/.config/fish/functions && rm -rf ~/.dotfiles/ays
fi

echo All done.

if [[ $SHELL != $(which zsh) ]]
then
    echo Now execute
    echo chsh -s $(which zsh)
    echo Optional binaries are below
    echo fzf
    echo cargo install zoxide
fi
