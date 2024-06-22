--[[

Notes to people reading my configuration (including myself in a future :rofl:)

./after/plugin/*.lua
  * This is where configuration for plugins live.

  * They get auto sourced on startup. In general, the name of the file configures
    the plugin with the corresponding name.

  * Configuration of any plugin should be written in a file with '.lua' extension.

  * Use plugins that are written in Vimscript only if there is no good alternative
    written in Lua, in which case configuration of such plugin should still be written
    in Lua. You can use 'vim.cmd(...)' to do that with an intention to convert it to
    Lua at some point.

./lua/ik1614/functions/*
  * This is where all custom functions live. This includes when I need to build something
    using some functionality from the installed plugins.
--]]

-- Setup globals that I expect to be always available.
-- Basically this is config for (N)vim without batteries. Well for 99% of cases :wink:
require("ik1614.core.globals")
require("ik1614.core.settings")
require("ik1614.core.mappings")
require("ik1614.core.vim-backport")

-- Hookup plugins
require("ik1614.packer-plugins")

-- Setup all things related to LSP
require("ik1614.lsp")

-- Setup all autocommands
require("ik1614.autocmd")

vim.cmd("luafile ~/.config/nvim/init-local.lua")
