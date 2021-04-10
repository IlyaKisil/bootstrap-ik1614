-- Setup globals that I expect to be always available.
require('ik1614.globals')
require('ik1614.settings') -- TODO: Move to globals
require("ik1614.mappings") -- TODO: Move to globals

require('ik1614.config')
require("ik1614.colorscheme")

require("ik1614.plugins")


require("ik1614.nvim-compe")
require("ik1614.galaxyline")

require("ik1614.telescope")
require("ik1614.telescope.mappings")

require("ik1614.vim-tmux-navigator")

require("ik1614.lsp")
require("ik1614.lsp.typescript")
-- require("ik1614.lsp.python")
-- require("ik1614.lsp.bash")
-- require("ik1614.lsp.terraform")


vim.cmd('luafile ~/.config/nvim/init-local.lua')
