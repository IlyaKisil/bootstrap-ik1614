-- TODO Convert to native NVIM api/LUA
-- These are also temporary mappings
vim.cmd([[
  nnoremap <leader>oo :lua require('ik1614.telescope').search_dotfiles()<CR>
  nnoremap <leader>tt :lua require('telescope.builtin').find_files()<CR>
]])
