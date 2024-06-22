local gl = require("galaxyline")
local condition = require("galaxyline.condition")
local gls = gl.section

local function file_readonly()
  if vim.bo.filetype == "help" then
    return ""
  end
  if vim.bo.readonly == true then
    return "  "
  end
  return ""
end

local function get_current_file_name()
  -- local file = vim.api.nvim_exec([[
  --   if winwidth(0) > 100
  --     echo expand('%')
  --   else
  --     echo pathshorten(expand('%'))
  --   endif
  --   ]], true)
  local file = vim.api.nvim_exec(
    [[
      echo expand('%')
    ]],
    true
  )
  if vim.fn.empty(file) == 1 then
    return ""
  end
  if string.len(file_readonly()) ~= 0 then
    return file .. file_readonly()
  end
  if vim.bo.modifiable then
    if vim.bo.modified then
      return file .. "  "
    end
  end
  return file .. " "
end

-- -- TODO: get colors from the official theme
local colors = {
  bg = GET_COLOR("statusLine"),
  yellow = "#DCDCAA",
  dark_yellow = "#D7BA7D",
  cyan = "#4EC9B0",
  green = "#608B4E",
  light_green = "#B5CEA8",
  string_orange = "#CE9178",
  orange = "#FF8800",
  purple = "#C586C0",
  magenta = "#D16D9E",
  grey = "#858585",
  blue = "#569CD6",
  light_blue = "#9CDCFE",
  red = "#D16969",
  error = GET_COLOR("error"),
  warn = GET_COLOR("warning"),
  info = GET_COLOR("info"),
  hint = GET_COLOR("hint"),
}

gl.short_line_list = {
  "NvimTree",
  "vista",
  "dbui",
  "packer",
  "fugitive",
}

gls.left[1] = {
  ViMode = {
    provider = function()
      -- auto change color according the vim mode
      local mode_color = {
        n = colors.blue, --
        i = colors.green, --
        v = colors.purple, --
        [""] = colors.purple, --
        V = colors.purple, --
        c = colors.magenta, --
        no = colors.blue,
        s = colors.orange, --
        S = colors.orange, --
        [""] = colors.orange, --
        ic = colors.yellow,
        R = colors.red, --
        Rv = colors.red,
        cv = colors.blue,
        ce = colors.blue,
        r = colors.cyan, --
        rm = colors.cyan,
        ["r?"] = colors.cyan,
        ["!"] = colors.blue, --
        t = colors.blue, --
      }
      vim.api.nvim_command("hi GalaxyViMode guifg=" .. mode_color[vim.fn.mode()])
      return "▊ "
    end,
    highlight = { colors.red, colors.bg },
  },
}

gls.left[2] = {
  GitIcon = {
    provider = function()
      return " "
    end,
    condition = condition.check_git_workspace,
    separator = " ",
    separator_highlight = { "NONE", colors.bg },
    highlight = { colors.orange, colors.bg },
  },
}

gls.left[3] = {
  GitBranch = {
    provider = "GitBranch",
    condition = condition.check_git_workspace,
    separator = " ",
    separator_highlight = { "NONE", colors.bg },
    highlight = { colors.grey, colors.bg },
  },
}

-- I don't see a point in them
-- gls.left[4] = {
--     DiffAdd = {
--         provider = 'DiffAdd',
--         condition = condition.hide_in_width,
--         icon = '  ',
--         highlight = {colors.green, colors.bg}
--     }
-- }
-- gls.left[5] = {
--     DiffModified = {
--         provider = 'DiffModified',
--         condition = condition.hide_in_width,
--         icon = ' 柳',
--         highlight = {colors.blue, colors.bg}
--     }
-- }
-- gls.left[6] = {
--     DiffRemove = {
--         provider = 'DiffRemove',
--         condition = condition.hide_in_width,
--         icon = '  ',
--         highlight = {colors.red, colors.bg}
--     }
-- }
gls.left[7] = {
  FileName = {
    provider = get_current_file_name,
    condition = buffer_not_empty,
    highlight = { colors.grey, colors.bg },
    separator = " ",
    separator_highlight = { colors.section_bg, colors.bg },
  },
}

gls.right[1] = {
  DiagnosticError = {
    provider = "DiagnosticError",
    -- icon = '  ',
    icon = " E ",
    highlight = { colors.error, colors.bg },
  },
}
gls.right[2] = {
  DiagnosticWarn = {
    provider = "DiagnosticWarn",
    -- icon = '  ',
    icon = " W ",
    highlight = { colors.warn, colors.bg },
  },
}

gls.right[3] = {
  DiagnosticInfo = {
    provider = "DiagnosticInfo",
    -- icon = '  ',
    icon = " I ",
    highlight = { colors.info_yellow, colors.bg },
  },
}

gls.right[4] = {
  DiagnosticHint = {
    provider = "DiagnosticHint",
    -- icon = '  ',
    icon = " H ",
    highlight = { colors.hint, colors.bg },
  },
}

gls.right[5] = {
  ShowLspClient = {
    provider = "GetLspClient",
    condition = function()
      local tbl = { ["dashboard"] = true, [" "] = true }
      if tbl[vim.bo.filetype] then
        return false
      end
      return true
    end,
    icon = " ",
    highlight = { colors.grey, colors.bg },
  },
}

gls.right[6] = {
  LineInfo = {
    provider = "LineColumn",
    separator = "  ",
    separator_highlight = { "NONE", colors.bg },
    highlight = { colors.grey, colors.bg },
  },
}

-- gls.right[7] = {
--     PerCent = {
--         provider = 'LinePercent',
--         separator = ' ',
--         separator_highlight = {'NONE', colors.bg},
--         highlight = {colors.grey, colors.bg}
--     }
-- }

-- gls.right[8] = {
--     Tabstop = {
--         provider = function()
--             return "Spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth") .. " "
--         end,
--         condition = condition.hide_in_width,
--         separator = ' ',
--         separator_highlight = {'NONE', colors.bg},
--         highlight = {colors.grey, colors.bg}
--     }
-- }

-- gls.right[9] = {
--     BufferType = {
--         provider = 'FileTypeName',
--         condition = condition.hide_in_width,
--         separator = ' ',
--         separator_highlight = {'NONE', colors.bg},
--         highlight = {colors.grey, colors.bg}
--     }
-- }

gls.right[10] = {
  FileEncode = {
    provider = "FileEncode",
    condition = condition.hide_in_width,
    separator = " ",
    separator_highlight = { "NONE", colors.bg },
    highlight = { colors.grey, colors.bg },
  },
}

gls.right[11] = {
  Space = {
    provider = function()
      return ""
    end,
    separator = " ",
    separator_highlight = { "NONE", colors.bg },
    highlight = { colors.orange, colors.bg },
  },
}

-- gls.short_line_left[1] = {
--     BufferType = {
--         provider = 'FileTypeName',
--         separator = ' ',
--         separator_highlight = {'NONE', colors.bg},
--         highlight = {colors.grey, colors.bg}
--     }
-- }

gls.short_line_left[2] = {
  FileName = {
    provider = get_current_file_name,
    condition = condition.buffer_not_empty,
    highlight = { colors.grey, colors.bg },
  },
}

gls.short_line_right[1] = {
  BufferIcon = {
    provider = "BufferIcon",
    highlight = { colors.grey, colors.bg },
  },
}

-- local galaxyline = require('galaxyline')
-- local get_filename = function()
--   return vim.fn.expand("%:h:t") .. "/" .. vim.fn.expand("%:t")
-- end

-- local colors = {
-- bg = GET_COLOR('statusLine'),
--   base00 = GET_COLOR('statusLine'),
--   base01 = "#cdd3de",
--   base02 = "#c0c5ce",
--   base03 = "#a7adba",
--   base04 = "#65737e",
--   base05 = "#4f5b66",
--   base06 = "#343d46",
--   base07 = "#1b2b34",
-- red = '#D16969',
-- orange = '#FF8800',
-- yellow = '#DCDCAA',
-- green = '#608B4E',
-- cyan = '#4EC9B0',
-- blue = '#569CD6',
-- purple = '#C586C0',
--   brown = "#9a806d",
--   white = "#ffffff",
--   light01 = "#E8EBF0",

--   error = GET_COLOR('error'),
--   warn = GET_COLOR('warning'),
--   info = GET_COLOR('info'),
--   hint = GET_COLOR('hint'),

-- }
-- colors.base00 = colors.bg
-- colors.bg_active = colors.base00

-- -- local default_mode_char = "▊"
-- local default_mode_char = "MODE"
-- local modes = {
-- n     = {default_mode_char, colors.blue},
-- v     = {default_mode_char, colors.purple},
-- V     = {default_mode_char, colors.purple},
-- [""] = {default_mode_char, colors.purple},
-- s     = {default_mode_char, colors.orange},
-- S     = {default_mode_char, colors.orange},
-- [""] = {default_mode_char, colors.orange},
-- i     = {default_mode_char, colors.green},
-- R     = {default_mode_char, colors.red},
-- c     = {default_mode_char, colors.magenta},
-- r     = {default_mode_char, colors.cyan},
-- ["!"] = {default_mode_char, colors.blue},
-- t     = {default_mode_char, colors.blue},

-- no     = {default_mode_char, colors.blue},
-- ic     = {default_mode_char, colors.blue},
-- Rv     = {default_mode_char, colors.blue},
-- cv     = {default_mode_char, colors.blue},
-- ce     = {default_mode_char, colors.blue},
-- rm     = {default_mode_char, colors.blue},
-- ['r?']     = {default_mode_char, colors.blue},
-- }

-- local get_vim_mode_style = function()
--   local vim_mode = vim.fn.mode()
--   return modes[vim_mode]
-- end
-- local icons = {
--   duck = "🦆",
--   goat = "🐐",
--   knight = "♞",
--   clubs = "♣︎",
--   sep = {
--     left = " ",
--     right = " ",
--     space = " "
--   },
--   diagnostic = {
--     error = "E ",
--     warn = "W ",
--     info = "I "
--   },
--   diff = {
--     add = " ",
--     modified = " ",
--     remove = " "
--   },
--   git = " ",
--   lsp = "⚡️"
-- }

-- local sectionCount = {
--   left = 0,
--   mid = 0,
--   right = 0,
--   short_line_left = 0,
--   short_line_right = 0
-- }

-- local nextSectionNum = function(sectionKind)
--   local num = sectionCount[sectionKind] + 1
--   sectionCount[sectionKind] = num
--   return num
-- end

-- local addSection = function(sectionKind, section)
--   local num = nextSectionNum(sectionKind)
--   local id = sectionKind .. "_" .. num .. "_" .. section.name
--   -- note: this is needed since id's get mapped to highlights name `Galaxy<Id>`
--   if (section.useNameAsId == true) then
--     id = section.name
--   end
--   galaxyline.section[sectionKind][num] = {
--     [id] = section
--   }
-- end

-- local addSections = function(sectionKind, sections)
--   for _, section in pairs(sections) do
--     addSection(sectionKind, section)
--   end
-- end

-- local string_provider = function(str)
--   return function()
--     return str
--   end
-- end

-- local createSpaceSection = function(color)
--   return {
--     name = "whitespace",
--     provider = string_provider(" "),
--     highlight = {color, color}
--   }
-- end
-- addSections(
--   "left",
--   {
--     createSpaceSection(colors.base04),
--     {
--       name = "ViMode",
--       useNameAsId = true,
--       provider = function()
--         -- auto change color according the vim mode
--         local modeStyle = get_vim_mode_style()
--         vim.api.nvim_command("hi GalaxyViMode guibg=" .. modeStyle[2])
--         return icons.sep.space .. modeStyle[1] .. icons.sep.space
--       end,
--       highlight = {colors.light01, colors.base02, "bold"}
--     },
--     -- {
--     --   name = "ViModeRightCap",
--     --   useNameAsId = true,
--     --   provider = function()
--     --     local modeStyle = get_vim_mode_style()
--     --     vim.api.nvim_command("hi GalaxyViModeRightCap guifg=" .. modeStyle[2])
--     --     return icons.sep.right
--     --   end,
--     --   highlight = {colors.base02, colors.bg_active}
--     -- },
--     createSpaceSection(colors.bg_active),
--     {
--       name = "fileLeftCap",
--       provider = string_provider(icons.sep.left),
--       condition = condition.buffer_not_empty,
--       highlight = {colors.base02, colors.bg_active},
--       separator = " ",
--       separator_highlight = {colors.base02, colors.base02}
--     },
--     {
--       name = "fileIcon",
--       provider = {"FileIcon"},
--       condition = condition.buffer_not_empty,
--       highlight = {colors.base07, colors.base02},
--       separator = " ",
--       separator_highlight = {colors.base07, colors.base02}
--     },
--     {
--       name = "fileName",
--       provider = current_file_name_provider,
--       condition = condition.buffer_not_empty,
--       highlight = {colors.base07, colors.base02},
--       separator = " ",
--       separator_highlight = {colors.base07, colors.base02}
--     },
--     {
--       name = "diagnostic",
--       provider = "DiagnosticError",
--       icon = icons.sep.space .. icons.diagnostic.error,
--       condition = condition.check_active_lsp,
--       highlight = {colors.light01, colors.orange}
--     },
--     {
--       icon = " ",
--       name = "lineColumn",
--       provider = "LineColumn",
--       condition = condition.buffer_not_empty,
--       highlight = {colors.light01, colors.base04, "bold"},
--       separator = " ",
--       separator_highlight = {colors.base04, colors.base04}
--     },
--     {
--       icon = " ",
--       name = "linePercent",
--       provider = "LinePercent",
--       condition = condition.buffer_not_empty,
--       highlight = {colors.light01, colors.yellow}
--     },
--     {
--       name = "fileRightCap",
--       provider = string_provider(icons.sep.right),
--       condition = condition.buffer_not_empty,
--       highlight = {colors.yellow, colors.bg_active}
--     },
--     createSpaceSection(colors.bg_active)
--   }
-- )

-- addSections(
--   "right",
--   {
--     {
--       name = "leftCap",
--       provider = string_provider(icons.sep.left),
--       highlight = {colors.base02, colors.bg_active}
--     },
--     {
--       name = "gitBranch",
--       icon = icons.git,
--       provider = "GitBranch",
--       condition = function()
--         local remainingWidth = vim.fn.winwidth(0) - get_filename():len()
--         return (remainingWidth >= 83) and condition.check_git_workspace()
--       end,
--       highlight = {colors.base07, colors.base02},
--       separator = " ",
--       separator_highlight = {colors.base07, colors.base02}
--     },
--     {
--       name = "lsp_status",
--       provider = string_provider(icons.lsp),
--       condition = condition.check_active_lsp,
--       highlight = {colors.base07, colors.base02},
--       separator = " ",
--       separator_highlight = {colors.base07, colors.base02}
--     },
--     createSpaceSection(colors.base02),
--     createSpaceSection(colors.base04)
--   }
-- )

-- addSections(
--   "short_line_left",
--   {
--     createSpaceSection(colors.base03),
--     {
--       name = "viMode",
--       provider = function()
--         local modeStyle = get_vim_mode_style()
--         return icons.sep.space .. modeStyle[1] .. icons.sep.space
--       end,
--       highlight = {colors.base05, colors.base02, "bold"}
--     },
--     {
--       name = "viModeRightCap",
--       provider = string_provider(icons.sep.right),
--       highlight = {colors.base02, colors.bg_active}
--     },
--     createSpaceSection(colors.bg_active),
--     {
--       name = "fileLeftCap",
--       provider = string_provider(icons.sep.left),
--       condition = condition.buffer_not_empty,
--       highlight = {colors.base02, colors.bg_active},
--       separator = " ",
--       separator_highlight = {colors.base02, colors.base02}
--     },
--     {
--       name = "fileIcon",
--       provider = {"FileIcon"},
--       condition = condition.buffer_not_empty,
--       highlight = {colors.base07, colors.base02},
--       separator = " ",
--       separator_highlight = {colors.base07, colors.base02}
--     },
--     {
--       name = "fileName",
--       provider = "FileName",
--       condition = condition.buffer_not_empty,
--       highlight = {colors.base07, colors.base02},
--       separator = " ",
--       separator_highlight = {colors.base07, colors.base02}
--     },
--     {
--       icon = " ",
--       name = "lineColumn",
--       provider = "LineColumn",
--       condition = condition.buffer_not_empty,
--       highlight = {colors.light01, colors.base04, "bold"},
--       separator = " ",
--       separator_highlight = {colors.base04, colors.base04}
--     },
--     {
--       name = "fileRightCap",
--       provider = string_provider(icons.sep.right),
--       condition = condition.buffer_not_empty,
--       highlight = {colors.base04, colors.bg_active}
--     },
--     createSpaceSection(colors.bg_active)
--   }
-- )

-- addSections(
--   "short_line_right",
--   {
--     {
--       name = "leftCap",
--       provider = string_provider(icons.sep.left),
--       highlight = {colors.base02, colors.bg_active}
--     },
--     createSpaceSection(colors.base02),
--     createSpaceSection(colors.base03)
--   }
-- )
