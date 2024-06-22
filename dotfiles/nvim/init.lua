require("ik1614.core.globals")
require("ik1614.core.settings")
require("ik1614.core.mappings")
require("ik1614.core.vim-backport")

require("ik1614.lazy")
require("ik1614.autocmd")

vim.cmd("luafile ~/.config/nvim/init-local.lua")
