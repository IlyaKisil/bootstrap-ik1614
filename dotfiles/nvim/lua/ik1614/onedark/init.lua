local utils = require("ik1614.utils")
local plugin_name = "onedark"

if not utils.plugin_installed(plugin_name) then
  return
end

local plugin = require(plugin_name)

-- Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
local style = "warm"

local colors = require('onedark.palette')[style]
plugin.setup({
  style = style,
  transparent = true,  -- Show/hide background, i.e. use background of the terminal colorsheme
  term_colors = true, -- Change terminal color as per the selected theme style
  ending_tildes = false, -- Show the end-of-buffer tildes. By default they are hidden
  cmp_itemkind_reverse = false, -- reverse item kind highlights in cmp menu
  toggle_style_key = nil, -- '<leader>ts', -- Default keybinding to toggle
  toggle_style_list = {}, -- List of styles to toggle between

  -- Change code style ---
  -- Options are italic, bold, underline, none
  -- You can configure multiple style with comma seperated, For e.g., keywords = 'italic,bold'
  code_style = {
    comments = 'italic',
    keywords = 'none',
    functions = 'none',
    strings = 'none',
    variables = 'none'
  },

  -- Custom Highlights --
  colors = { -- Override default colors
    diff_add = '#294436',
    diff_change = '#294436',
    diff_delete = '#484A4A',
    diff_text = '#385570',
  },
  highlights = { -- Override/extend highlight groups
    ErrorMessage   = {fg = "#CC666E"},
    WarningMessage = {fg = "#BE9117"},
    InfoMessage    = {fg = "#A4A3A3"},
    HintMessage    = {fg = "#606366"},

    NonText    = {fg = "#373c43"},
    Whitespace = {fg = "#373c43"},
    Visual = {bg = '#214283'},
    Search    = {fg = '$none', bg = '#32593D'},
    IncSearch = {fg = '$none', bg = '#214283'},
    MatchParen = {bg = '$none'},
    Todo = {fg = '#A35F96'},

    -- Make the same as CursorLine
    VertSplit      = {bg = colors.bg1, fg = colors.bg1},
    LineNr         = {bg = colors.bg1},
    SignColumn     = {bg = colors.bg1},
    ColorColumn    = {bg = colors.bg1},
    CursorColumn   = {bg = colors.bg1},
    CursorLineNr   = {bg = colors.bg1},
    GitSignsAdd    = {bg = colors.bg1},
    GitSignsChange = {bg = colors.bg1},
    GitSignsDelete = {bg = colors.bg1},
    GitSignsChange = {bg = colors.bg1},

    -- This is to make active buffer more visible. Used as a part of autocommand
    IlyaInactiveBuffer = {bg = colors.bg1},
  },

  -- Plugins Config --
  diagnostics = {
    darker = true, -- darker colors for diagnostic
    undercurl = true,   -- use undercurl instead of underline for diagnostics
    background = true,    -- use background color for virtual text
  },

})

plugin.load()

-- Custom function based on the plugin
local M = {}
return M
