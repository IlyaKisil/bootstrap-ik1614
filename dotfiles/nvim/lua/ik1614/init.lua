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

./lua/ik1614/functions/*
  * This is where all custom functions live. This includes when I need to build something
    using some functionality from the installed plugins.
--]]


-- Setup globals that I expect to be always available.
-- Basically this is config for (N)vim without batteries. Well for 99% of cases :wink:
require('ik1614.globals')
require('ik1614.globals.settings')
require("ik1614.globals.mappings")

-- Hookup plugins
require("ik1614.plugins")

vim.cmd('luafile ~/.config/nvim/init-local.lua')
