" ############################################
" ###       THIS CONFIG IS SYMLINKED       ###
" ###    DONT' ENTER ANY SENSITIVE INFO    ###
" ###                                      ###
" ###  USE LOCAL CONFIG FOR MODIFICATIONS  ###
" ### UNLESS CHANGES WILL BECOME PERMANENT ###
" ############################################

call plug#begin("$__VIM_DOTFILES_HOME/plugged")
" ---------- Themes and styling
"Plug 'https://github.com/joshdick/onedark.vim'
"Plug 'https://github.com/christianchiarulli/onedark.vim'
Plug 'https://github.com/morhetz/gruvbox'
" Plug 'https://github.com/NLKNguyen/papercolor-theme'
" Plug 'https://github.com/mhartington/oceanic-next'
" Plug 'https://github.com/rakr/vim-one'
" Plug 'https://github.com/jacoborus/tender.vim'

Plug 'https://github.com/sheerun/vim-polyglot'              " A collection of language packs for Vim.
Plug 'https://github.com/vim-airline/vim-airline'           " Lean & mean status/tabline for vim
Plug 'https://github.com/vim-airline/vim-airline-themes'
Plug 'https://github.com/ryanoasis/vim-devicons'            " Adds file type icons to Vim plugins such as: NERDTree, vim-airline. Requires additional fonts to be installed


" ---------- File and content browsers
Plug 'https://github.com/preservim/nerdtree'                " File system explorer. NOTE: try to use fzf for locating files
"Plug 'https://github.com/preservim/nerdcommenter'           " Code commenter. TODO: Still need to figure out what this one is doing
Plug 'https://github.com/junegunn/fzf'                      " Code and files fuzzy finder (Assumes that fzf is installed on a machine)
Plug 'https://github.com/junegunn/fzf.vim'
"Plug 'https://github.com/fisadev/FixedTaskList.vim'         " Search the file for FIXME, TODO, and XXX (or a custom list) and put them in a handy list for you to browse
Plug 'https://github.com/google/vim-searchindex'            " Shows how many times a search pattern occurs and your current position


" ---------- Autocompletion. TODO: Still need to figure out how to install everything...
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Plug 'https://github.com/Shougo/deoplete.nvim'              " Async autocompletion
" Plug 'https://github.com/roxma/nvim-yarp'
" Plug 'https://github.com/roxma/vim-hug-neovim-rpc'
" Plug 'https://github.com/deoplete-plugins/deoplete-jedi'    " Python autocompletion
" Plug 'https://github.com/Shougo/context_filetype.vim'       " Completion from other opened files
" Plug 'https://github.com/davidhalter/jedi-vim'              " Add the python go-to-definition and similar features, Might require to disable autocompletion
" Plug 'https://github.com/ycm-core/YouCompleteMe'            " A code-completion engine for Vim. Uses a few different auto-completers (including Jedi)


" ---------- Python specific
" Plug 'https://github.com/majutsushi/tagbar'                 " Provides an easy way to browse the tags of the current file and get an overview of its structure
Plug 'https://github.com/heavenshell/vim-pydocstring'   " Docstring generator"

" ---------- Salt
Plug 'https://github.com/Glench/Vim-Jinja2-Syntax'          " Jinja2 syntax file for vim with the ability to detect either HTML or Jinja
Plug 'https://github.com/saltstack/salt-vim'                " Vim files for editing Salt files


" ---------- Misc
Plug 'https://github.com/Townk/vim-autoclose'               " Enable an auto-close chars feature
Plug 'https://github.com/tpope/vim-surround'                " Surroundings: parentheses, brackets, quotes, XML tags, and more
"Plug 'https://github.com/michaeljsmith/vim-indent-object'   " Defines a new text object representing lines of code at the same indent level. Useful for python/vim scripts, etc.
"Plug 'https://github.com/jeetsukumaran/vim-indentwise'      " Provides for motions based on indent depths or levels in normal, visual, and operator-pending modes.
Plug 'https://github.com/tpope/vim-fugitive'                " Git integration
"Plug 'https://github.com/terryma/vim-multiple-cursors'      " Support for multiple cursors
" Plug 'https://github.com/mhinz/vim-signify'                 " Git/mercurial/others diff icons on the side of the file lines
" Plug 'https://github.com/neomake/neomake'                   " Asynchronous linting and make framework for Neovim/Vim
" Plug 'https://github.com/vim-syntastic/syntastic'           " Syntax checking hacks for vim
Plug 'editorconfig/editorconfig-vim'
Plug 'https://github.com/machakann/vim-highlightedyank'
Plug 'https://github.com/tpope/vim-commentary'
Plug 'justinmk/vim-sneak'
Plug 'https://github.com/easymotion/vim-easymotion'
call plug#end()
