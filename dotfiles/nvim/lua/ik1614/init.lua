-- Setup globals that I expect to be always available.
require('ik1614.globals')
require('ik1614.globals.settings')
require("ik1614.globals.mappings")
require("ik1614.globals.colorscheme")

-- Setup config variables for plugins
require('ik1614.config')

-- Hookup plugins
require("ik1614.plugins")


vim.cmd('luafile ~/.config/nvim/init-local.lua')
