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
syntax on                         " Syntax highlight on
filetype plugin on                " Allow plugins by file type (required for plugins!)
filetype indent on                " Allow plugins by file type (required for plugins!)
set encoding=UTF-8
set nocompatible                 " No vi-compatible
set ls=2                         " Always show status bar
set nu                           " Show line numbers
set rnu                          " Set relative numbering of line
set incsearch                    " Incremental search
set hlsearch                     " Highlighted search results
set expandtab                    " Tabs and spaces handling
set tabstop=4                    " Tabs and spaces handling
set softtabstop=4                " Tabs and spaces handling
set shiftwidth=4                 " Tabs and spaces handling
set scrolloff=5                  " When scrolling, keep cursor N lines away from screen border
set sidescroll=5
set nowrap                       " Don't wrap lines by default
set ignorecase                   " Use case insensitive search
set smartcase                    " Except when using capital letters
set autoindent                   " Keep the same indent when there is no file type specific instructions
set mouse=a                      " Enable use of the mouse for all modes
set wildmenu                     " Better command-line completion
set showcmd                      " Show partial commands in the last line of the screen
set cmdheight=2                  " Give more space for displaying messages he
set backspace=indent,eol,start   " Allow backspacing over autoindent, line breaks and start of insert action
set clipboard=unnamed            " Copy to system wide clipboard
set list
set listchars=space:.            " Show special characters
set splitright                   " Open vertical split on the right
set splitbelow                   " Opne horizontal split below
set hidden                       " Allow switching to another buffer without saving current one
set autoread                     " Reload files changed outside vim
set cursorline                   " highlight the current line
set colorcolumn=90

" Enable folding
set foldmethod=indent
set foldlevel=99


" ---------- Better backup, swap and undos storage for vim default
set directory=$__VIM_DOTFILES_HOME/dirs/tmp       " directory to place swap files in
set backup                                        " make backup files
set backupdir=$__VIM_DOTFILES_HOME/dirs/backups   " where to put backup files
set undofile                                      " persistent undos - undo after you re-open the file
set undodir=$__VIM_DOTFILES_HOME/dirs/undos
set viminfo+=n$__VIM_DOTFILES_HOME/dirs/viminfo
" create needed directories if they don't exist
if !isdirectory(&backupdir)
    call mkdir(&backupdir, "p")
endif
if !isdirectory(&directory)
    call mkdir(&directory, "p")
endif
if !isdirectory(&undodir)
    call mkdir(&undodir, "p")
endif
