-- ============================================================================
-- GENERAL SETTINGS (not related to plugins)
-- ============================================================================

-- ---------- Syntax
-- vim.cmd('syntax on')
vim.cmd('syntax enable')
vim.o.fileencoding = "utf-8"

-- vim.cmd('set nocompatible')  -- Nvim is always 'nocompatible'
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
-- vim.o.t_Co = "256" -- This seems to be deprecated. For more info see https://github.com/neovim/neovim/issues/14662
vim.opt.termguicolors = true -- use guifg/guibg instead of ctermfg/ctermbg in terminal



-- ----------- Indents
vim.opt.expandtab = true -- always use spaces instead of tabs
vim.opt.autoindent     = true                              -- maintain indent of current line
vim.opt.tabstop       = 4                       -- spaces per tab
vim.opt.softtabstop = 4 -- use 'shiftwidth' for tab/bs at end of line
vim.opt.shiftwidth    = 2                       -- spaces per tab (when shifting)


-- ----------- Wrapping
-- Don't wrap lines by default
vim.wo.wrap = false

-- ----------- Line num and position
vim.opt.number         = true -- show line numbers in gutter
vim.opt.cursorline     = true                              -- highlight current line
vim.wo.signcolumn = "yes"
vim.opt.relativenumber = true -- show relative numbers in gutter
vim.opt.colorcolumn = '90'

vim.opt.scrolloff = 8  -- When scrolling, keep cursor N lines away from screen border. Better to keep greater then 'pumheight'
vim.opt.sidescroll = 10  -- Same as 'scrolloff'


-- ---------- Search and native auto-completion
vim.opt.incsearch = true -- Incremental search
vim.opt.hlsearch = true -- highlight all matches on previous search pattern
vim.opt.ignorecase = true -- ignore case in search patterns
vim.opt.smartcase = true -- Except when using capital letters


vim.o.pumheight = 7 -- Determines the maximum number of items to show in the popup menu (auto-completion). Better to keep it less then 'scrolloff'

vim.opt.completeopt = {
  "menu",
  "menuone",  -- show menu even if there is only one candidate (for nvim-compe)
  "noselect", -- don't automatically select canditate (for nvim-compe)
}


-- ----------- Splits, Windows, Buffers
vim.opt.splitbelow    = true                    -- open horizontal splits below current window
vim.opt.splitright    = true                    -- open vertical splits to the right of the current window

vim.opt.hidden         = true                              -- allows you to hide buffers with unsaved changes without being prompted

-- Reload files changed outside vim
vim.cmd('set autoread')
vim.cmd('set autowrite')


-- ----------- Command line/mode
-- vim.cmd('set ls=2')
vim.opt.laststatus     = 2                                 -- always show status line
vim.o.cmdheight = 1  -- height of the command mode

-- Show partial commands in the last line of the screen
vim.cmd('set showcmd')
vim.opt.wildmenu    = true -- Better command-line completion. show options as list when switching buffers etc


-- ----------- Misc
vim.opt.mouse = "a"

vim.opt.lazyredraw = true -- don't bother updating screen during macro playback

vim.opt.backspace      = 'indent,start,eol' -- allow unrestricted backspacing in insert mode, e.g. linebreaks, autoindent etc.

-- Copy to system wide clipboard
-- vim.o.clipboard = "unnamed"
vim.o.clipboard = "unnamedplus"

-- Show special characters
vim.opt.list           = true                              -- show whitespace
vim.opt.listchars      = {
  nbsp                 = '⦸',                              -- CIRCLED REVERSE SOLIDUS (U+29B8, UTF-8: E2 A6 B8)
  extends              = '»',                              -- RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK (U+00BB, UTF-8: C2 BB)
  precedes             = '«',                              -- LEFT-POINTING DOUBLE ANGLE QUOTATION MARK (U+00AB, UTF-8: C2 AB)
  tab                  = '-->',
  space                = '.',
}

-- Enable folding
vim.opt.foldmethod     = 'indent'
vim.opt.foldlevelstart = 99                                -- start unfolded
vim.opt.foldlevel      = 99                                -- start unfolded
-- Use treesitter for folding. FIXME: doesn't work currently :cry:
-- vim.opt.foldmethod     = 'expr'
-- vim.opt.foldtext       = 'nvim_treesitter#foldexpr()'

--
vim.opt.fillchars = {
  diff = ' ', -- Don't display symbols for deleted lines in the diff mode
  eob  = ' ', -- Don't display end of buffer symbol
}


vim.o.timeoutlen = 1000

-- Go to last location when opening a buffer and center it
vim.cmd([[
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g`\"zz" | endif
]])
