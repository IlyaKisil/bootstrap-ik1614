local utils = require("ik1614.utils")
local f = require("ik1614.functions")
local plugin_name = "hlargs"

if not utils.plugin_installed(plugin_name) then
  return
end

local plugin = require(plugin_name)

local colors = f.utils:get_color_pallet("onedark")
plugin.setup({
  color = colors.red,
  excluded_filetypes = {},
  -- disable = function(lang, bufnr) -- If changed, `excluded_filetypes` will be ignored
  --   return vim.tbl_contains(opts.excluded_filetypes, lang)
  -- end,
  paint_arg_declarations = true,
  paint_arg_usages = true,
  paint_catch_blocks = {
    declarations = false,
    usages = false
  },
  hl_priority = 10000,
  excluded_argnames = {
    declarations = {},
    usages = {
      python = {
        'self',
        'cls'
      },
      lua = {
        'self'
      }
    }
  },
  performance = {
    parse_delay = 1,
    slow_parse_delay = 50,
    max_iterations = 400,
    max_concurrent_partial_parses = 30,
    debounce = {
      partial_parse = 3,
      partial_insert_mode = 100,
      total_parse = 700,
      slow_parse = 5000
    }
  }
})