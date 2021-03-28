-- Setup globals that I expect to be always available.
require('ik1614.globals')
require('ik1614.settings')
require("ik1614.mappings")

require("ik1614.plugins")



require("ik1614.telescope")
require("ik1614.telescope.mappings")


-- require("ik1614.lsp")
-- require("ik1614.lsp.bash")
-- require("ik1614.lsp.terraform")


vim.cmd('luafile ~/.config/nvim/init-local.lua')
