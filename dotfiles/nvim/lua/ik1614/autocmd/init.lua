vim.api.nvim_create_autocmd('BufReadPost', {
  group = vim.api.nvim_create_augroup("ReopenFileOnTheSamePosition", {clear=true}),
  callback = function()
    -- Continue where you left off upon reopening vim
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Change highlight groups within of active/inactive windows
-- https://caleb89taylor.medium.com/customizing-individual-neovim-windows-4a08f2d02b4e
-- Alternative approach would be to just use
--
--    set nocursorline
--    set cursorline
--
-- which is a bit more native but it doesn't do anything with the colorcolumn.
vim.api.nvim_create_autocmd("WinLeave", {
  group = vim.api.nvim_create_augroup("CustomiseInactiveWindow", {clear=true}),
  callback = function()
    vim.cmd([[
      setlocal winhighlight=CursorLine:InactiveBufferNoBackground,ColorColumn:InactiveBufferNoBackground,CursorLineNr:InactiveBufferCursorLineNr
    ]])
  end,
})

vim.api.nvim_create_autocmd("WinEnter", {
  group = vim.api.nvim_create_augroup("CustomiseActiveWindow", {clear=true}),
  callback = function()
    vim.cmd([[
      " setlocal winhighlight=Normal:MdraculaNormal,NormalNC:IlyaInactiveBuffer
      setlocal winhighlight=CursorLine:CursorLine,ColorColumn:ColorColumn,CursorLineNr:CursorLineNr
    ]])
  end,
})
