--[[

Notes to people reading my configuration (including myself in a future :rofl:)

./after/plugin/*.[vim|lua]
  * This is where configuration for plugins live.

  * They get auto sourced on startup. In general, the name of the file configures
    the plugin with the corresponding name.

  * If plugin is written in Lua, then the corresponding config files should be with
    '.lua' extension.

  * If plugin is written in Vimscript, then the corresponding config files should be with
    '.vim' extension.

--]]


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
