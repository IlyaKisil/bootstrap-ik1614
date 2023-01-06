local f = require("ik1614.functions")
local plugin = f.utils:load_plugin("lualine")

if not plugin then
  return
end

local function diff_source()
  -- Reuse git diff from 'gitsigns' if it exists
  if f.utils:plugin_installed("gitsigns") then
    -- TODO: I have a feeling there is some load dependency, race condition
    -- As at the moments this doesn't work on the start up but after that
    -- that dict is available :shrug:
    local gitsigns = vim.b.gitsigns_status_dict
    if gitsigns then
      return {
        added = gitsigns.added,
        modified = gitsigns.changed,
        removed = gitsigns.removed
      }
    end
  else
    return nil
  end
end

local function show_dap_status()
  local dap = f.utils:load_plugin("dap")
  if not dap then
    return ""
  end

  local status = dap.status()
  if status == "" then
    return status
  end

  return "DAP: " .. status
end


plugin.setup({
  options = {
    icons_enabled = false,
    theme = 'auto',
    disabled_filetypes = {
      'packer',
      'fugitive',
      'NvimTree'
    },
    -- always_divide_middle = true,
    globalstatus = false,
  },
  sections = {
    lualine_a = {
      {
        'mode',
        fmt = function(str) return str:sub(1,1) end,
        padding = {
          left = 1,
          right = 1,
        }
      }
    },
    lualine_b = {
      {'b:gitsigns_head'}, -- Reuse, branch info from 'gitsigns'
      {'diff', source = diff_source}, -- Reuse diff infom from 'gitsigns'
    },
    lualine_c = {
      {
        'filename',
        path = 1,
      }
    },
    lualine_x = {
      -- 'encoding',
      -- 'fileformat',
      -- 'filetype',
    },
    lualine_y = {
      { show_dap_status },
      'diagnostics',
      'filetype',
    },
    lualine_z = {
      'location'
    }
  },
  inactive_sections = {
    lualine_a = {
      {
        'filename',
        path = 1,
      }
    },
    -- Disable default settings for these sections
    lualine_c = {},
    lualine_x = {},
  },
  tabline = {},
  extensions = {}
})
