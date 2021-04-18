-- Setup globals that I expect to be always available.
require('ik1614.globals')
require('ik1614.globals.settings')
require("ik1614.globals.mappings")
require("ik1614.globals.colorscheme")

-- Setup config variables for plugins
require('ik1614.config')

-- Hookup plugins
require("ik1614.plugins")


-- Plugin configs
require("ik1614.nvim-compe")
require("ik1614.galaxyline")
require("ik1614.dashboard-nvim")

require("ik1614.gitsigns")

require("ik1614.telescope")
require("ik1614.telescope.mappings")
require("ik1614.treesitter")

require("ik1614.vim-tmux-navigator")

-- LSP
-- require("ik1614.nvim-lspinstall")
require("ik1614.lsp")
require("ik1614.lsp.typescript")
require("ik1614.lsp.lua")
-- require("ik1614.lsp.python")
require("ik1614.lsp.bash")
-- require("ik1614.lsp.terraform")


vim.cmd('luafile ~/.config/nvim/init-local.lua')
