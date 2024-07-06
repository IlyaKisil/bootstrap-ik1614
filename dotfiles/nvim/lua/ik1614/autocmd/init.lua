-- Change highlight groups within of active/inactive windows
-- https://caleb89taylor.medium.com/customizing-individual-neovim-windows-4a08f2d02b4e
-- Alternative approach would be to just use
--
--    set nocursorline
--    set cursorline
--
-- which is a bit more native but it doesn't do anything with the colorcolumn.
vim.api.nvim_create_autocmd("WinLeave", {
  group = vim.api.nvim_create_augroup("CustomiseInactiveWindow", { clear = true }),
  callback = function()
    vim.cmd([[
      setlocal winhighlight=CursorLine:InactiveBufferNoBackground,ColorColumn:InactiveBufferNoBackground,CursorLineNr:InactiveBufferCursorLineNr
    ]])
  end,
})

vim.api.nvim_create_autocmd("WinEnter", {
  group = vim.api.nvim_create_augroup("CustomiseActiveWindow", { clear = true }),
  callback = function()
    vim.cmd([[
      setlocal winhighlight=CursorLine:CursorLine,ColorColumn:ColorColumn,CursorLineNr:CursorLineNr
    ]])
  end,
})
