-- local f = require("ik1614.functions")
-- local plugin_name = "vim-fugitive"

-- if not f.utils:plugin_installed(plugin_name) then
--   return
-- end

vim.cmd([[
  command! GitInTab tabedit 'vim-fugitive'| Git | wincmd k | wincmd q
]])
