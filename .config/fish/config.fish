if status is-interactive
# Commands to run in interactive sessions can go here
    export FZF_DEFAULT_OPTS='--height 100% --layout=reverse --border'
    set -U fish_greeting ""
    set -x GPG_TTY (tty)
    set -x LS_COLORS (cat ~/.zsh/snazzy.txt)
    if [ -e /usr/local/opt/coreutils/libexec/gnubin/ls ]
        alias ls="/usr/local/opt/coreutils/libexec/gnubin/ls --color"
    end
    for src in ~/.profile
        if [ -e $src ]
            bass source $src
        end
    end
    for src in ~/.bash_aliases ~/.alias.sh
        if [ -e $src ]
            cat $src | perl -pe 's/^alias ([^\'\"]*)=/abbr -a $1 /g' | source
        end
    end
    test "$TERM" = "xterm-kitty" && abbr -a ssh "kitty +kitten ssh"
    if type zoxide > /dev/null 2>&1
        zoxide init fish | source
        bind \ed zi
    end
    function cd
        builtin cd $argv[1]; and ls
    end
    function zip
        command zip $argv[1..-1] -x "*/.DS_Store"
    end

    if type exa > /dev/null 2>&1
        abbr -a e 'exa'
        abbr -a ea 'exa -a'
        abbr -a ee 'exa -aahl'
        abbr -a et 'exa -T -L 3 -I "node_modules|.git|.cache"'
        abbr -a eta 'exa -T -L 3 -a -I "node_modules|.git|.cache"'
    end
	function vicd
		set dst "$(command vifm --choose-dir - $argv[2..-1])"
		if [ -z "$dst" ]; 
			echo 'Directory picking cancelled/failed'
			return 1
		end
		cd "$dst"
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
    for cp in /opt/miniconda3/bin/conda ~/.miniconda/bin/conda ~/miniconda/bin/conda
        if [ -e $cp ]
            set -x CONDA_PATH $cp
            break
        end
    end
    function conda-init
        eval $CONDA_PATH "shell.fish" "hook" $argv | source
    end
    for cp in  ~/.mambaforge/bin/conda ~/mambaforge/bin/conda
        if [ -e $cp ]
            set -x MAMBA_PATH $cp
            break
        end
    end
    function mamba-init
        eval $MAMBA_PATH "shell.fish" "hook" $argv | source
    end
end
