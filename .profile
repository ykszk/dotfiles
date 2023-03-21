export EDITOR='/usr/bin/vim'
export LANG=en_US.UTF-8

export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_NO_GOOGLE_ANALYTICS=1

for bindir in "$HOME/.local/bin" "$HOME/.nodebrew/current/bin" "/opt/homebrew/bin/"
do
    if [ -d $bindir ] ; then
        PATH="$bindir:$PATH"
    fi
done
for srcdir in "$HOME/.profile.local" "$HOME/.cargo/env"
do
    if [ -e $srcdir ] ; then
        source $srcdir
    fi
done
