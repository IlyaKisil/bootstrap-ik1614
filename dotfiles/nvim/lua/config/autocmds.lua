--[[
=========================================================================================


Default autocmds that are set by LazyVim distro
* https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua

To remove existing autocmds by their group name with

  vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

All of the defaults are prefixed `lazyvim_`


-----------------------------------------------------------------------------------------
Useful 'autocmds' that I used to have myself, but now they come as part of LazyVim:

* Highlight yank
* Trim whitespace
* Go to last loc when opening a buffer
* Close some filetypes with <q>
* Auto create dir when saving a file, in case some intermediate directory does not exist


=========================================================================================
-- ]]

local exclude_cursorline = {
  snacks_dashboard = true,
  snacks_picker_input = true,
}

local exclude_colorcolumn = {
  snacks_dashboard = true,
  snacks_picker_input = true,
  snacks_picker_list = true,
  snacks_picker_preview = true,
  NvimTree = true,
}

local function should_skip_cursorline()
  return exclude_cursorline[vim.bo.filetype]
end

local function should_skip_colorcolumn()
  return exclude_colorcolumn[vim.bo.filetype]
end

vim.api.nvim_create_autocmd({ "BufEnter", "WinEnter" }, {
  desc = "Customise active window",
  pattern = "*",
  group = vim.api.nvim_create_augroup("ik1614-customise-active-window", { clear = true }),
  callback = function()
    if not should_skip_cursorline() then
      vim.wo.cursorline = true
    else
      vim.wo.cursorline = false
    end

    if not should_skip_colorcolumn() then
      vim.wo.colorcolumn = "90"
    else
      vim.wo.colorcolumn = "0"
    end
  end,
})

vim.api.nvim_create_autocmd({ "WinLeave" }, {
  desc = "Customise in-active window",
  pattern = "*",
  group = vim.api.nvim_create_augroup("ik1614-customise-inactive-window", { clear = true }),
  callback = function()
    vim.wo.colorcolumn = "0"
    vim.wo.cursorline = false
  end,
})
