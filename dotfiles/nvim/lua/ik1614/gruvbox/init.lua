local utils = require("ik1614.utils")
local plugin_name = "gruvbox"

if not utils.plugin_installed(plugin_name) then
  return
end

vim.o.background = "dark" -- or "light" for light mode

local plugin = require(plugin_name)
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