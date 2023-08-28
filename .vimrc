"config
set number
set ruler
"set cursorline
set title
set showmatch
syntax on
set expandtab
set tabstop=4
set shiftwidth=4
set smartindent
set mouse=a
set scrolloff=3
filetype indent on
set wildmenu
set lazyredraw
set iskeyword-=_

"config for search
set incsearch
set hlsearch
set ignorecase
set smartcase
set wrapscan

"change cursor shape in the insert mode
let &t_ti .= "\e[1 q"
let &t_SI .= "\e[5 q"
let &t_EI .= "\e[1 q"
let &t_te .= "\e[0 q"

" Set the filetype for vifmrc files to vim
au BufNewFile,BufRead vifmrc set filetype=vim

"other
colorscheme koehler
set whichwrap=b,s,h,l,<,>,[,]
set backspace=start,eol,indent
"always show status line
set laststatus=2
"GUI config
if has("gui_running")
 language messages English_United States
 set langmenu=en_US.UTF-8
 "hide menu and tool bar
 set guioptions-=m
 set guioptions-=T
 "font config
 if has("gui_gtk2")
    set guifont=Monospace\ 12
  elseif has("gui_macvim")
    set guifont=Menlo\ Regular:h14
  elseif has("gui_win32")
    set guifont=Consolas:h11:cANSI
  endif
endif
