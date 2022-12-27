local f = require("ik1614.functions")
local plugin = f.utils:load_plugin("tokyonight")

if not plugin then
  return
end

-- plugin.setup({})

vim.g.tokyonight_style = "night"
-- vim.g.tokyonight_italic_functions = true
-- vim.g.tokyonight_italic_keywords = true
-- vim.g.tokyonight_transparent_sidebar = true
-- vim.g.tokyonight_transparent = true
-- vim.g.tokyonight_sidebars = {
--     "qf",
--     "vista_kind",
--     "terminal",
--     "packer"
-- }

-- vim.cmd([[colorscheme tokyonight]])
-- plugin.colorscheme()

-- Custom function based on the plugin
local M = {}
return M
