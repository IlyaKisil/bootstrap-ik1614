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
require("ik1614.vim-vimsnip")
require("ik1614.galaxyline")

require("ik1614.gitsigns")
require("ik1614.gitlinker")

require("ik1614.telescope")
require("ik1614.telescope.mappings")
require("ik1614.treesitter")

require("ik1614.vim-tmux-navigator")

require("ik1614.nvim-colorizer")
require("ik1614.nvim-bqf")
require("ik1614.nvim-neoclip")


vim.cmd('luafile ~/.config/nvim/init-local.lua')
