-- Setup globals that I expect to be always available.
require('ik1614.globals')
require('ik1614.globals.settings')
require("ik1614.globals.mappings")

-- Setup config variables for plugins
require('ik1614.config')

-- Hookup plugins
require("ik1614.plugins")

require("ik1614.globals.colorscheme")

vim.cmd('luafile ~/.config/nvim/init-local.lua')
