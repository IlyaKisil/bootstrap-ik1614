" ############################################
" ###       THIS CONFIG IS SYMLINKED       ###
" ###    DONT' ENTER ANY SENSITIVE INFO    ###
" ###                                      ###
" ###  USE LOCAL CONFIG FOR MODIFICATIONS  ###
" ### UNLESS CHANGES WILL BECOME PERMANENT ###
" ############################################

" ============================================================================
" GENERAL SETTINGS (not related to plugins)
" ============================================================================
"----------- Syntax
"syntax on
syntax enable
set encoding=UTF-8
set nocompatible
" Allow plugins by file type (required for plugins!)
filetype plugin indent on


"----------- Indents
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
" Keep the same indent when there is no file type specific instructions
set autoindent


"----------- Wrapping
" Don't wrap lines by default
set nowrap


"----------- Line num and position
set number
set relativenumber
set cursorline
set signcolumn=yes
set colorcolumn=90
" When scrolling, keep cursor N lines away from screen border
" Better to keep greater then 'pumheight'
set scrolloff=10
set sidescroll=10


"----------- Search and native auto-completion
" Incremental search
set incsearch
" Highlighted search results
set hlsearch
" Use case insensitive search
set ignorecase
" Except when using capital letters
set smartcase
" Determines the maximum number of items to show in the popup menu (auto-completion)
set pumheight=9


"----------- Splits, Windows, Buffers
" Open vsplit and split on the right and below respectively
set splitright
set splitbelow
" Allow switching to another buffer without saving current one
set hidden
" Reload files changed outside vim
set autoread


"----------- Command line/mode
" Always show status bar
set ls=2
" Give more space for displaying messages he
set cmdheight=2
" Show partial commands in the last line of the screen
set showcmd
" Better command-line completion
set wildmenu


"----------- Misc
set lazyredraw
set mouse=a
" Allow backspacing over autoindent, line breaks and start of insert action
set backspace=indent,eol,start
" Copy to system wide clipboard
set clipboard=unnamed
" Show special characters
set list
set listchars=space:.,tab:->
" Enable folding
set foldmethod=indent
set foldlevel=99


" ---------- Better backup, swap and undos storage for vim default
" Directory to place swap files in
set directory=$__VIM_DOTFILES_HOME/dirs/tmp
if !isdirectory(&directory)
    call mkdir(&directory, "p")
endif
" Make backup files and where to put them
set backup
set backupdir=$__VIM_DOTFILES_HOME/dirs/backups
if !isdirectory(&backupdir)
    call mkdir(&backupdir, "p")
endif
" Persistent undos - undo after you re-open the file
set undofile
set undodir=$__VIM_DOTFILES_HOME/dirs/undos
if !isdirectory(&undodir)
    call mkdir(&undodir, "p")
endif
" Continue where you left off upon reopening vim session
set viminfo+=n$__VIM_DOTFILES_HOME/dirs/viminfo
