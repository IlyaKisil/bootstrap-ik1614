-- local f = require("ik1614.functions")
-- local plugin = f.utils:load_plugin("vim-fugitive")

-- if not plugin then
--   return
-- end

vim.cmd([[
  command! GitInTab tabedit 'vim-fugitive'| Git | wincmd k | wincmd q
]])
