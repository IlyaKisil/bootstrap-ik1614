local gl = require('galaxyline')
local condition = require('galaxyline.condition')
local gls = gl.section

local function file_readonly()
  if vim.bo.filetype == 'help' then return '' end
  if vim.bo.readonly == true then return '  ' end
  return ''
end

local function get_current_file_name()
  -- local file = vim.api.nvim_exec([[
  --   if winwidth(0) > 100
  --     echo expand('%')
  --   else
  --     echo pathshorten(expand('%'))
  --   endif
  --   ]], true)
  local file = vim.api.nvim_exec([[
      echo expand('%')
    ]], true)
  if vim.fn.empty(file) == 1 then return '' end
  if string.len(file_readonly()) ~= 0 then return file .. file_readonly() end
  if vim.bo.modifiable then
    if vim.bo.modified then return file .. '  ' end
  end
  return file .. ' '
end

-- TODO: get colors from the official theme
local colors = {
    bg = GET_COLOR('statusLine'),
    yellow = '#DCDCAA',
    dark_yellow = '#D7BA7D',
    cyan = '#4EC9B0',
    green = '#608B4E',
    light_green = '#B5CEA8',
    string_orange = '#CE9178',
    orange = '#FF8800',
    purple = '#C586C0',
    magenta = '#D16D9E',
    grey = '#858585',
    blue = '#569CD6',
    light_blue = '#9CDCFE',
    red = '#D16969',
    error = GET_COLOR('error'),
    warn = GET_COLOR('warning'),
    info = GET_COLOR('info'),
    hint = GET_COLOR('hint'),
}

gl.short_line_list = {
    'NvimTree',
    'vista',
    'dbui',
    'packer',
}

gls.left[1] = {
    ViMode = {
        provider = function()
            -- auto change color according the vim mode
            local mode_color = {
                n = colors.blue,
                i = colors.green,
                v = colors.purple,
                [''] = colors.purple,
                V = colors.purple,
                c = colors.magenta,
                no = colors.blue,
                s = colors.orange,
                S = colors.orange,
                [''] = colors.orange,
                ic = colors.yellow,
                R = colors.red,
                Rv = colors.red,
                cv = colors.blue,
                ce = colors.blue,
                r = colors.cyan,
                rm = colors.cyan,
                ['r?'] = colors.cyan,
                ['!'] = colors.blue,
                t = colors.blue
            }
            vim.api.nvim_command('hi GalaxyViMode guifg=' .. mode_color[vim.fn.mode()])
            return '▊ '
        end,
        highlight = {colors.red, colors.bg}
    }
}

gls.left[2] = {
    GitIcon = {
        provider = function()
            return ' '
        end,
        condition = condition.check_git_workspace,
        separator = ' ',
        separator_highlight = {'NONE', colors.bg},
        highlight = {colors.orange, colors.bg}
    }
}

gls.left[3] = {
    GitBranch = {
        provider = 'GitBranch',
        condition = condition.check_git_workspace,
        separator = ' ',
        separator_highlight = {'NONE', colors.bg},
        highlight = {colors.grey, colors.bg}
    }
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
    highlight = {colors.grey, colors.bg},
    separator = " ",
    separator_highlight = {colors.section_bg, colors.bg},
  }
}

gls.right[1] = {
  DiagnosticError = {
    provider = 'DiagnosticError',
    -- icon = '  ',
    icon = ' E ',
    highlight = {colors.error, colors.bg}
  }
}
gls.right[2] = {
  DiagnosticWarn = {
    provider = 'DiagnosticWarn',
    -- icon = '  ',
    icon = ' W ',
    highlight = {colors.warn, colors.bg}
  }
}

gls.right[3] = {
  DiagnosticInfo = {
    provider = 'DiagnosticInfo',
    -- icon = '  ',
    icon = ' I ',
    highlight = {colors.info_yellow, colors.bg}
  }
}

gls.right[4] = {
  DiagnosticHint = {
    provider = 'DiagnosticHint',
    -- icon = '  ',
    icon = ' H ',
    highlight = {colors.hint, colors.bg}
  }
}

gls.right[5] = {
  ShowLspClient = {
    provider = 'GetLspClient',
    condition = function()
      local tbl = {['dashboard'] = true, [' '] = true}
      if tbl[vim.bo.filetype] then return false end
      return true
    end,
    icon = ' ',
    highlight = {colors.grey, colors.bg}
  }
}

gls.right[6] = {
  LineInfo = {
    provider = 'LineColumn',
    separator = '  ',
    separator_highlight = {'NONE', colors.bg},
    highlight = {colors.grey, colors.bg}
  }
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
        provider = 'FileEncode',
        condition = condition.hide_in_width,
        separator = ' ',
        separator_highlight = {'NONE', colors.bg},
        highlight = {colors.grey, colors.bg}
    }
}

gls.right[11] = {
    Space = {
        provider = function()
            return ''
        end,
        separator = ' ',
        separator_highlight = {'NONE', colors.bg},
        highlight = {colors.orange, colors.bg}
    }
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
        highlight = {colors.grey, colors.bg}
    }
}

gls.short_line_right[1] = {
  BufferIcon = {
    provider = 'BufferIcon',
    highlight = {colors.grey, colors.bg}
  }
}
