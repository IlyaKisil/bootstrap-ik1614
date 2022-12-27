local f = require("ik1614.functions")
local plugin = f.utils:load_plugin("gruvbox")

if not plugin then
  return
end

vim.o.background = "dark" -- or "light" for light mode

plugin.setup({
  undercurl = true,
  underline = true,
  bold = true,
  italic = true,
  strikethrough = true,
  invert_selection = false,
  invert_signs = false,
  invert_tabline = false,
  invert_intend_guides = false,
  inverse = true, -- invert background for search, diffs, statuslines and errors
  contrast = "soft", -- can be "hard", "soft" or empty string
  overrides = {},
})

-- Custom function based on the plugin
local M = {}
return M
