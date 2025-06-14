--[[
=========================================================================================


Default options that are set by LazyVim distro
* https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua


-----------------------------------------------------------------------------------------
Some settings that I used to have myself, but now they came as a part of LazyVim
* Continue where you left off upon reopening vim session, e.g. command or search history
* Location of the backup/tmp/undo dirs
* Copy to system wide clipboard
* Allow unrestricted backspacing in insert mode, e.g. linebreaks, autoindent etc.
* Don't bother updating screen during macro playback
* Global toggle for autoformat on save


=========================================================================================
-- ]]

vim.g.python3_host_prog = vim.fn.expand("~/.pyenv/versions/3.13.2/bin/python3")

--
vim.opt.autoread = true
vim.opt.autowrite = true

-- ----------- Indents
vim.opt.expandtab = true -- always use spaces instead of tabs
vim.opt.shiftwidth = 2 -- spaces per tab (when shifting)
vim.opt.softtabstop = 2 -- use 'shiftwidth' for tab/bs at end of line
vim.opt.tabstop = 2 -- spaces per tab

vim.opt.pumheight = 7 -- Determines the maximum number of items to show in the popup menu (auto-completion). Better to keep it less then 'scrolloff'
vim.opt.scrolloff = 8 -- When scrolling, keep cursor N lines away from screen border. Better to keep greater then 'pumheight'
vim.opt.sidescroll = 10 -- Same as 'scrolloff'

-- Show special characters
vim.opt.listchars = {
  nbsp = "⦸", -- CIRCLED REVERSE SOLIDUS (U+29B8, UTF-8: E2 A6 B8)
  extends = "»", -- RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK (U+00BB, UTF-8: C2 BB)
  precedes = "«", -- LEFT-POINTING DOUBLE ANGLE QUOTATION MARK (U+00AB, UTF-8: C2 AB)
  tab = "-->",
  space = ".",
}

vim.opt.fillchars = {
  diff = " ", -- Don't display symbols for deleted lines in the diff mode
  eob = " ", -- Don't display end of buffer symbol
}

vim.filetype.add({
  extension = {
    -- brewfile = "brewfile",
    -- mk = "make",
    -- tf = "terraform",
  },
  filename = {
    ["environment.template"] = "env-tmpl",
    ["configuration.template.meta"] = "json",
  },
  pattern = {
    ["%.env%.[%w_.-]+"] = "sh",
  },
})

vim.treesitter.language.register("gotmpl", { "env-tmpl" })
