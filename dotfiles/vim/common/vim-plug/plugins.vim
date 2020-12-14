" ############################################
" ###       THIS CONFIG IS SYMLINKED       ###
" ###    DONT' ENTER ANY SENSITIVE INFO    ###
" ###                                      ###
" ###  USE LOCAL CONFIG FOR MODIFICATIONS  ###
" ### UNLESS CHANGES WILL BECOME PERMANENT ###
" ############################################

call plug#begin("$__VIM_DOTFILES_HOME/plugged")
" ---------- Themes and styling
Plug 'https://github.com/morhetz/gruvbox'

Plug 'https://github.com/sheerun/vim-polyglot'              " A collection of language packs for Vim.
Plug 'https://github.com/vim-airline/vim-airline'           " Lean & mean status/tabline for vim
Plug 'https://github.com/vim-airline/vim-airline-themes'
Plug 'https://github.com/ryanoasis/vim-devicons'            " Adds file type icons to Vim plugins such as: NERDTree, vim-airline. Requires additional fonts to be installed


" ---------- File and content browsers
Plug 'https://github.com/preservim/nerdtree'                " File system explorer. NOTE: try to use fzf for locating files
Plug 'https://github.com/junegunn/fzf'                      " Code and files fuzzy finder (Assumes that fzf is installed on a machine)
Plug 'https://github.com/junegunn/fzf.vim'
"Plug 'https://github.com/fisadev/FixedTaskList.vim'         " Search the file for FIXME, TODO, and XXX (or a custom list) and put them in a handy list for you to browse


" ---------- IntelliSense, Completion and Linting
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Plug 'https://github.com/ycm-core/YouCompleteMe'            " A code-completion engine for Vim. Uses a few different auto-completers (including Jedi)
" Plug 'https://github.com/neomake/neomake'                   " Asynchronous linting and make framework for Neovim/Vim
" Plug 'https://github.com/vim-syntastic/syntastic'           " Syntax checking hacks for vim


" ---------- Formatting
Plug 'editorconfig/editorconfig-vim'


" ---------- Navigation with a file
Plug 'justinmk/vim-sneak'
" Plug 'https://github.com/easymotion/vim-easymotion'


" ---------- GO specific
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }


" ---------- Python specific
" Plug 'https://github.com/majutsushi/tagbar'                 " Provides an easy way to browse the tags of the current file and get an overview of its structure
Plug 'https://github.com/heavenshell/vim-pydocstring'   " Docstring generator. FIXME: might be able to do this with ultisnips


" ---------- Salt
Plug 'https://github.com/Glench/Vim-Jinja2-Syntax'          " Jinja2 syntax file for vim with the ability to detect either HTML or Jinja
Plug 'https://github.com/saltstack/salt-vim'                " Vim files for editing Salt files


" ---------- Latex
Plug 'https://github.com/lervag/vimtex'
" Plug 'https://github.com/xuhdev/vim-latex-live-preview'


" ---------- Git
Plug 'https://github.com/airblade/vim-gitgutter'
Plug 'https://github.com/tpope/vim-fugitive'                " Git integration


" ---------- Misc
Plug 'https://github.com/Townk/vim-autoclose'               " Enable an auto-close chars feature
Plug 'https://github.com/tpope/vim-surround'                " Surroundings: parentheses, brackets, quotes, XML tags, and more
Plug 'https://github.com/tpope/vim-commentary'              " Comment out lines with ease
Plug 'SirVer/ultisnips'
Plug 'https://github.com/honza/vim-snippets'
Plug 'https://github.com/machakann/vim-highlightedyank'
Plug 'https://github.com/christoomey/vim-tmux-navigator'
Plug 'https://github.com/TaDaa/vimade'                      " Dim inactive buffer
call plug#end()
