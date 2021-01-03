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

Plug 'https://github.com/sheerun/vim-polyglot'
Plug 'https://github.com/vim-airline/vim-airline'
Plug 'https://github.com/vim-airline/vim-airline-themes'
" Adds file type icons to Vim plugins such as: NERDTree, vim-airline. Requires additional fonts to be installed
Plug 'https://github.com/ryanoasis/vim-devicons'


" ---------- File and content browsers
Plug 'https://github.com/preservim/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'https://github.com/junegunn/fzf'
Plug 'https://github.com/junegunn/fzf.vim'
" Search the file for FIXME, TODO, and XXX (or a custom list) and put them in a handy list for you to browse
" Plug 'https://github.com/fisadev/FixedTaskList.vim'


" ---------- IntelliSense, Completion and Linting
Plug 'https://github.com/neoclide/coc.nvim', {'branch': 'release'}
" Plug 'https://github.com/ycm-core/YouCompleteMe'
" Plug 'https://github.com/neomake/neomake'
" Plug 'https://github.com/vim-syntastic/syntastic'


" ---------- Formatting
Plug 'https://github.com/editorconfig/editorconfig-vim'


" ---------- Navigation with a file
Plug 'https://github.com/justinmk/vim-sneak'
" Plug 'https://github.com/easymotion/vim-easymotion'


" ---------- GO
Plug 'https://github.com/fatih/vim-go', { 'do': ':GoUpdateBinaries', 'for': 'go' }


" ---------- Python
" Provides an easy way to browse the tags of the current file and get an
" overview of its structure. I think, CoC has similar functionality, although
" not as nice.
" Plug 'https://github.com/majutsushi/tagbar'

" Docstring generator. NOTE: might be able to do this with ultisnips
" Plug 'https://github.com/heavenshell/vim-pydocstring', {'for': 'python'}


" ---------- Salt
Plug 'https://github.com/Glench/Vim-Jinja2-Syntax', {'for': 'sls'}
Plug 'https://github.com/saltstack/salt-vim', {'for': 'sls'}


" ---------- Latex
Plug 'https://github.com/lervag/vimtex', {'for': 'tex'}
" Plug 'https://github.com/xuhdev/vim-latex-live-preview', {'for': 'tex'}


" ---------- Git
Plug 'https://github.com/airblade/vim-gitgutter'
Plug 'https://github.com/tpope/vim-fugitive'
" Open current file/selection on GitHub
Plug 'https://github.com/tpope/vim-rhubarb'


" ---------- Misc
Plug 'https://github.com/Townk/vim-autoclose'
Plug 'https://github.com/tpope/vim-surround'
" Comment out lines with ease
Plug 'https://github.com/tpope/vim-commentary'
Plug 'https://github.com/SirVer/ultisnips'
Plug 'https://github.com/honza/vim-snippets'
Plug 'https://github.com/machakann/vim-highlightedyank'
Plug 'https://github.com/christoomey/vim-tmux-navigator'
" Dim inactive buffer
Plug 'https://github.com/TaDaa/vimade'
Plug 'https://github.com/liuchengxu/vim-which-key'
Plug 'https://github.com/tpope/vim-dotenv'
" Plug 'https://github.com/dbeniamine/cheat.sh-vim'

" Profile startup time
Plug 'https://github.com/tweekmonster/startuptime.vim', {'on': 'StartupTime'}

call plug#end()
