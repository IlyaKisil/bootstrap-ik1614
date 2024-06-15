-- local utils = require("ik1614.functions.utils")
-- local plugin = utils:load_plugin("vim-fugitive")

-- if not plugin then
--   return
-- end

vim.cmd([[
  command! GitInTab tabedit 'vim-fugitive'| Git | wincmd k | wincmd q
]])
