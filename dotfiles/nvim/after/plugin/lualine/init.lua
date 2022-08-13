local utils = require("ik1614.utils")
local plugin_name = "lualine"

if not utils.plugin_installed(plugin_name) then
  return
end

local function diff_source()
  -- Reuse git diff from 'gitsigns' if it exists
  if utils.plugin_installed("gitsigns") then
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

local plugin = require(plugin_name)

plugin.setup({
  options = {
    icons_enabled = false,
    theme = 'auto',
    -- component_separators = { left = '', right = ''},
    -- section_separators = { left = '', right = ''},
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
      -- 'branch',
      {'b:gitsigns_head'}, -- Reuse, branch info from 'gitsigns'
      -- 'diff',
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
      {
        function()
          local plugin_name = 'lsp-status'
          if not utils.plugin_installed(plugin_name) then
            return ""
          end
          return require(plugin_name).status()
        end
      },
      'diagnostics',
      -- {
      --   -- This only helps with LSP clients that take some time to initialise
      --   -- Requires: https://github.com/arkav/lualine-lsp-progress
      --   'lsp_progress',
      --   timer = {
      --     progress_enddelay = 1000,
      --     spinner = 100,
      --     lsp_client_name_enddelay = -1,  -- Always show LSP client name
      --   },
      --   display_components = { { 'title', 'percentage', 'message' }, 'spinner',  'lsp_client_name'},
      --   spinner_symbols = { "⣾", "⣽", "⣻", "⢿", "⡿", "⣟", "⣯", "⣷" },
      --   separators = {
      --     component = ' ',
      --     progress = ' | ',
      --     percentage      = { pre = '',  post = '%% ' },
      --     title           = { pre = '',  post = ': ' },
      --     lsp_client_name = { pre = '',  post = '' },
      --     spinner         = { pre = '',  post = '' },
      --     message         = { pre = '(', post =')', commenced = 'In Progress', completed = 'Completed', },
      --   },
      -- },
      'filetype',
      -- 'progress',
    },
    lualine_z = {
      {
        'location', -- TODO: remove padding
      }
    }
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {
      {
        'filename',
        path = 1,
      }
    },
    lualine_x = {},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {}
})

-- Custom function based on the plugin
local M = {}
return M
