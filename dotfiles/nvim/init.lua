require('ik1614.globals')
require('ik1614.globals.settings')
require("ik1614.globals.mappings")
require("ik1614.globals.vim-backport")

require('ik1614.lazy')

-- Setup all autocommands
-- require("ik1614.autocmd")

vim.cmd('luafile ~/.config/nvim/init-local.lua')
