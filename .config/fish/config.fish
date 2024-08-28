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
        [ -e $src ] && bass source $src
    end
    # Set `alias`es as `abbr`s
    for src in ~/.bash_aliases ~/.alias.sh
        [ -e $src ] && cat $src | perl -pe 's/^alias ([^\'\"]*)=/abbr -a $1 /g' | source
    end
    test "$TERM" = xterm-kitty && test "$SESSION_TYPE" != remote/ssh && abbr -a ssh "kitty +kitten ssh"
    if type -q zoxide
        zoxide init fish | source
        function zi_repaint
            zi
            commandline -f repaint
        end
        bind \ed zi_repaint
    end
    if type -q wanna_ls
        function cd
            builtin cd $argv[1]; and wanna_ls;  and ls
        end
    end
    function zip
        command zip $argv[1..-1] -x "*/.DS_Store"
    end

    if type -q lsd
        if type -q wanna_ls
            function cd
                builtin cd $argv[1]; and wanna_ls;  and lsd
            end
        end
        abbr -a ls lsd
        abbr -a la 'lsd -a'
        abbr -a ll 'lsd -lh'
        abbr -a lt 'lsd --tree --depth 2 --ignore-glob node_modules --ignore-glob .git --ignore-glob .cache'
        abbr -a lta 'lsd -a --tree --depth 2 --ignore-glob node_modules --ignore-glob .git --ignore-glob .cache'
    end

    function vicd
        set dst "$(command vifm --choose-dir - $argv[2..-1])"
        if [ -z "$dst" ]
            echo 'Directory picking cancelled/failed'
            return 1
        end
        cd "$dst"
    end
    if type -q ghq
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

    # zsh's push-line
    # https://github.com/fish-shell/fish-shell/issues/6973#issuecomment-1379827312
    function push-line
        set -g __fish_pushed_line (commandline)
        commandline ""
        commandline -f repaint
        function after-next-prompt --on-event fish_postexec
            commandline $__fish_pushed_line
            set -e __fish_pushed_line
            functions --erase after-next-prompt
        end
    end
    # bind ctrl-q to push-line
    bind \cq push-line
    # print pushed line to the right prompt
    if functions -q fish_right_prompt
        if not functions -q __fish_right_prompt_push_line_orig
            functions -c fish_right_prompt __fish_right_prompt_push_line_orig
        end
        functions -e fish_right_prompt
    else
        function __fish_right_prompt_push_line_orig
        end
    end
    function fish_right_prompt
        if set -q __fish_pushed_line
            set_color 996699
            echo $__fish_pushed_line " "
            set_color normal
        end
        __fish_right_prompt_push_line_orig
    end

    # conda and mamba
    for cp in /opt/miniconda3/bin/conda ~/.miniforge3/bin/conda ~/.miniconda/bin/conda ~/.miniconda3/bin/conda ~/miniconda3/bin/conda ~/miniconda/bin/conda
        if [ -e $cp ]
            set -x CONDA_PATH $cp
            break
        end
    end
    function conda-init
        eval $CONDA_PATH "shell.fish" hook $argv | source
    end
    for cp in ~/.mambaforge/bin/conda ~/mambaforge/bin/conda
        if [ -e $cp ]
            set -x MAMBA_PATH $cp
            break
        end
    end
    function mamba-init
        eval $MAMBA_PATH "shell.fish" hook $argv | source
    end
end
