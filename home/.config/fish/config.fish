if status is-interactive
# Commands to run in interactive sessions can go here
    export EDITOR='/usr/bin/vim'
    export LANG=en_US.UTF-8
    export FZF_DEFAULT_OPTS='--height 100% --layout=reverse --border'
    set -U fish_greeting ""
    set -x LS_COLORS (cat ~/.zsh/snazzy.txt)
    if test -d /usr/local/opt/coreutils/libexec/gnubin
        alias ls="/usr/local/opt/coreutils/libexec/gnubin/ls --color"
    end
    bass source ~/.profile
    if type zoxide > /dev/null 2>&1
        zoxide init fish | source
        bind \ed zi
    end
    function cd
        builtin cd $argv[1]; and ls
    end
    if type ghq > /dev/null 2>&1
        export GHQ_ROOT="$HOME/projects"
        function ghqcd
            ghq list | eval (__fzfcmd) "$FZF_DEFAULT_OPTS $flags" | read select
            if [ "$select" ]
                builtin cd "$GHQ_ROOT"/"$select"
                commandline -f repaint
            end
        end
        bind \eg ghqcd
        function ghqcode
            ghq list | eval (__fzfcmd) "$FZF_DEFAULT_OPTS $flags" | read select
            if [ "$select" ]
                code "$GHQ_ROOT"/"$select"
            end
        end
    end
end
