-- ============================================================================
-- GENERAL SETTINGS (not related to plugins)
-- ============================================================================

-- ---------- Syntax
-- vim.cmd('syntax on')
vim.cmd('syntax enable')
vim.o.fileencoding = "utf-8"

vim.cmd('set nocompatible')
-- Allow plugins by file type (required for plugins!)
vim.cmd('filetype plugin indent on')

-- NOTE: For some reason 'nvim' doesn't respect/sources 'ftdetect' :shrug:
-- Maybe this was handled by some other plugin???
vim.cmd([[
    augroup filetypedetect
      for f in split(glob('~/.config/nvim/ftdetect/*.vim'), '\n')
        exe 'source' f
      endfor
    augroup END
]])

-- Support for 256 colors
vim.o.t_Co = "256"
vim.o.termguicolors = true



-- ----------- Indents
-- Converts tabs to spaces
vim.bo.expandtab = true

vim.cmd([[
  set tabstop=4
  set softtabstop=4
  set shiftwidth=4
  set autoindent
]])


-- ----------- Wrapping
-- Don't wrap lines by default
vim.wo.wrap = false

-- "----------- Line num and position
vim.wo.number = true
vim.wo.cursorline = true
vim.wo.signcolumn = "yes"
vim.wo.relativenumber = true
vim.cmd('set colorcolumn=90')

-- When scrolling, keep cursor N lines away from screen border
-- Better to keep greater then 'pumheight'
vim.o.scrolloff = 8
vim.o.sidescroll = 10


-- ---------- Search and native auto-completion
-- Incremental search
vim.cmd('set incsearch')
-- Highlighted search results
vim.cmd('set hlsearch')
-- Use case insensitive search
vim.cmd('set ignorecase')
-- Except when using capital letters
vim.cmd('set smartcase')

-- Determines the maximum number of items to show in the popup menu (auto-completion)
-- Better to keep it less then 'scrolloff'
vim.o.pumheight = 7

-- FIXME: Sort out autoinsert upon autocompletion
vim.o.completeopt = "menuone,noinsert,noselect"


-- "----------- Splits, Windows, Buffers
-- " Open vsplit and split on the right and below respectively
vim.o.splitbelow = true
vim.o.splitright = true

-- " Allow switching to another buffer without saving current one
vim.o.hidden = true

-- " Reload files changed outside vim
vim.cmd('set autoread')
vim.cmd('set autowrite')


-- "----------- Command line/mode
-- " Always show status bar
vim.cmd('set ls=2')
-- " Give more space for displaying messages he
vim.o.cmdheight = 2

-- " Show partial commands in the last line of the screen
vim.cmd('set showcmd')
-- " Better command-line completion
vim.cmd('set wildmenu')


-- "----------- Misc
vim.o.mouse = "a"

-- " don't bother updating screen during macro playback
vim.cmd('set lazyredraw')
-- " Allow backspacing over autoindent, line breaks and start of insert action
vim.cmd('set backspace=indent,eol,start')

-- Copy to system wide clipboard
-- vim.o.clipboard = "unnamed"
vim.o.clipboard = "unnamedplus"

-- " Show special characters
vim.cmd('set list')
vim.cmd('set listchars=space:.,tab:-->')

-- " Arrow pointing downwards then curving rightwards (U+2937, UTF-8: E2 A4 B7)
-- if has('linebreak')
--   let &showbreak='⤷ '
-- endif

-- " Enable folding
vim.cmd('set foldmethod=indent')
vim.cmd('set foldlevel=99')
-- Use treesitter for folding
vim.cmd([[
  set foldmethod=expr
  set foldexpr=nvim_treesitter#foldexpr()
]])
