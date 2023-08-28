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

# [How can I detect if the shell is controlled from SSH? - Unix & Linux Stack Exchange](https://unix.stackexchange.com/questions/9605/how-can-i-detect-if-the-shell-is-controlled-from-ssh)
if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
  SESSION_TYPE=remote/ssh
else
  case $(ps -o comm= -p "$PPID") in
    sshd|*/sshd) SESSION_TYPE=remote/ssh;;
  esac
fi
