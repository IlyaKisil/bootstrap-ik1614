local utils = require("ik1614.functions.utils")
local plugin = utils:load_plugin("onedark")

if not plugin then
  return
end

local colors = utils:get_color_pallet("onedark")
plugin.setup({
  style = utils:get_color_pallet_style("onedark"),
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
  colors = {
    -- Override default colors
    diff_add = '#294436',
    diff_change = '#294436',
    diff_delete = '#484A4A',
    diff_text = '#385570',

    -- Add custom names for default colors
    error = colors.red,
    warn = colors.orange,
    info = colors.blue,
    debug = colors.light_grey,
    trace = colors.grey,

    -- Add test color for highlight groups that I don't what they do
    unknown_fg = "#BBB529",
    unknown_bg = "#EB4034",
  },
  highlights = { -- Override/extend highlight groups
    ErrorMessage = {fg = "$error"},
    WarnMessage  = {fg = "$warn"},
    InfoMessage  = {fg = "$info"},
    DebugMessage = {fg = "$debug"},
    TraceMessage = {fg = "$trace"},

    NonText    = {fg = "#373c43"},
    Whitespace = {fg = "#373c43"},
    Visual = {bg = '#214283'},
    Search    = {fg = '$none', bg = '#32593D'},
    IncSearch = {fg = '$none', bg = '#214283'},
    MatchParen = {bg = '$none'},
    Todo = {fg = '#A35F96'},

    -- Make the same as CursorLine
    VertSplit      = {bg = colors.bg1},
    -- VertSplit      = {bg = colors.bg1, fg = colors.bg1},
    LineNr         = {bg = colors.bg1},
    SignColumn     = {bg = colors.bg1},
    ColorColumn    = {bg = colors.bg1},
    CursorColumn   = {bg = colors.bg1},
    CursorLineNr   = {bg = colors.bg1},
    GitSignsAdd    = {bg = colors.bg1},
    GitSignsChange = {bg = colors.bg1},
    GitSignsDelete = {bg = colors.bg1},

    DiagnosticError = {bg = colors.bg1},
    DiagnosticWarn  = {bg = colors.bg1},
    DiagnosticInfo  = {bg = colors.bg1},
    DiagnosticHint  = {bg = colors.bg1, fg = colors.grey},

    DiagnosticVirtualTextError = {bg = "$none", fg = colors.grey},
    DiagnosticVirtualTextWarn  = {bg = "$none", fg = colors.grey},
    DiagnosticVirtualTextInfo  = {bg = "$none", fg = colors.grey},
    DiagnosticVirtualTextHint  = {bg = "$none", fg = colors.grey},

    -- Thes are basically headings within corresponding buffer
    DapUIWatchesEmpty    = {fg = colors.blue},
    DapUIScope           = {fg = colors.blue},
    DapUIStoppedThread   = {fg = colors.blue},
    DapUIBreakpointsPath = {fg = colors.blue},

    -- Related to stacks section
    DapUIThread           = {fg = colors.cyan},
    DapUIFrameName        = {fg = colors.light_grey},
    DapUICurrentFrameName = {fg = colors.yellow, fmt = "bold"},
    DapUISource           = {fg = colors.grey}, -- Name of a file
    DapUILineNumber       = {fg = colors.grey}, -- Line within that file

    DapUIWatchesValue = {fg = colors.green},
    DapUIWatchesError = {fg = "$error"},

    DapUIType          = {fg = colors.grey},
    DapUIValue         = {fg = colors.light_grey},
    DapUIVariable      = {fg = colors.fg},
    DapUIModifiedValue = {fg = colors.yellow, fmt = "bold"},

    DapUIBreakpointsLine        = {fg = colors.grey},
    DapUIBreakpointsInfo        = {fg = colors.cyan}, -- This is when a break point has a condition
    DapUIBreakpointsCurrentLine = {fg = colors.yellow, fmt = "bold"},

    DapUIFloatBorder = {fg = colors.grey, bg = colors.bg1},
    -- DapUINormalFloat = {fg = colors.grey, bg = colors.bg},

    -- DapUIBreakpointsDisabledLine = {fg = "$unknown_fg", bg = "$unknown_bg"}, -- :shrug:
    -- DapUIUnavailable             = {fg = "$unknown_fg", bg = "$unknown_bg"}, -- :shrug:
    -- DapUIDecoration              = {fg = "$unknown_fg", bg = "$unknown_bg"}, -- :shrug:

    DapSignDefault             = {bg = colors.bg1, fg = colors.red },

    -- This is for fugitive
    gitcommitSummary  = {fg = colors.fg},
    gitcommitOverflow = {fg = colors.red},

    -- nvim-notify plugin
    NotifyERRORBorder = {fg = '$error'},
    NotifyERRORIcon   = {fg = '$error'},
    NotifyERRORTitle  = {fg = '$error'},
    NotifyWARNBorder  = {fg = '$warn'},
    NotifyWARNIcon    = {fg = '$warn'},
    NotifyWARNTitle   = {fg = '$warn'},
    NotifyINFOBorder  = {fg = '$info'},
    NotifyINFOIcon    = {fg = '$info'},
    NotifyINFOTitle   = {fg = '$info'},
    NotifyDEBUGBorder = {fg = '$debug'},
    NotifyDEBUGIcon   = {fg = '$debug'},
    NotifyDEBUGTitle  = {fg = '$debug'},
    NotifyTRACEBorder = {fg = '$trace'},
    NotifyTRACEIcon   = {fg = '$trace'},
    NotifyTRACETitle  = {fg = '$trace'},

    -- This is to make active buffer more visible. Used as a part of autocommand
    -- IlyaInactiveBuffer = {bg = colors.bg1},
    InactiveBufferNoBackground = {bg = "$none"},
    InactiveBufferCursorLineNr = {fg = colors.grey, bg=colors.bg1}
  },

  -- Plugins Config --
  diagnostics = {
    darker = true, -- darker colors for diagnostic
    undercurl = true,   -- use undercurl instead of underline for diagnostics
    background = true,    -- use background color for virtual text
  },

})

plugin.load()
