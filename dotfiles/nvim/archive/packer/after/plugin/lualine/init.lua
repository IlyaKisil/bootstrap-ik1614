local utils = require("ik1614.functions.utils")
local plugin = utils:load_plugin("lualine")

if not plugin then
  return
end

local function diff_source()
  -- Reuse git diff from 'gitsigns' if it exists
  if utils:plugin_installed("gitsigns") then
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
  local dap = utils:load_plugin("dap")
  if not dap then
    return ""
  end

  local status = dap.status()
  if status == "" then
    return status
  end

  return "DAP: " .. status
end

local function list_registered_providers_names(filetype)
  local s = require "null-ls.sources"
  local available_sources = s.get_available(filetype)
  local registered = {}
  for _, source in ipairs(available_sources) do
    for method in pairs(source.methods) do
      registered[method] = registered[method] or {}
      table.insert(registered[method], source.name)
    end
  end
  return registered
end

local function lsp_client(msg)
  -- TODO: Refactor into something more usable
  -- https://github.com/alpha2phi/neovim-for-beginner/blob/14-null-ls/lua/config/lualine.lua
  -- https://github.com/alpha2phi/neovim-for-beginner/blob/383bf9a7b655ef0da604e88773940a636ee3fae4/lua/config/lualine.lua#L22
  msg = msg or ""
  local buf_clients = vim.lsp.buf_get_clients()
  if next(buf_clients) == nil then
    if type(msg) == "boolean" or #msg == 0 then
      return ""
    end
    return msg
  end

  local buf_ft = vim.bo.filetype
  local buf_client_names = {}

  -- add client
  for _, client in pairs(buf_clients) do
    if client.name ~= "null-ls" then
      table.insert(buf_client_names, client.name)
    end
  end

  -- add linter
  local supported_linters = list_registered_providers_names(buf_ft)[require("null-ls").methods.DIAGNOSTICS] or {}
  vim.list_extend(buf_client_names, supported_linters)

  -- add formatter
  local supported_formatters = list_registered_providers_names(buf_ft)[require("null-ls").methods.FORMATTING] or {}
  vim.list_extend(buf_client_names, supported_formatters)

  if next(buf_client_names) == nil then
    return ""
  end

  return "LSP: " .. table.concat(buf_client_names, ", ")
end

local lualine_a = {
  active = {
    {
      'mode',
      fmt = function(str) return str:sub(1,1) end,
      padding = {
        left = 1,
        right = 1,
      }
    }
  },
  inactive = {
    {
      'filename',
      path = 1,
    },
  }
}

local lualine_c = {
  active = {
    {
      'filename',
      path = 1,
    },
  },
  inactive = {}
}

local minimal_info = {
  sections = {
    lualine_a = lualine_a.active,
    lualine_c = lualine_c.active,
  },
  inactive_sections = {
    lualine_a = lualine_a.inactive,
  },
  filetypes = {
    'dapui_watches',
    'dapui_scopes',
    'dapui_stacks',
    'dapui_console',
    'dapui_breakpoints',
    'dap-repl',
    'fugitive',
  }
}

plugin.setup({
  options = {
    icons_enabled = false,
    theme = 'auto',
    disabled_filetypes = {
      'packer',
      'NvimTree'
    },
    -- always_divide_middle = true,
    globalstatus = false,
  },
  sections = {
    lualine_a = lualine_a.active,
    lualine_b = {
      {'b:gitsigns_head'}, -- Reuse, branch info from 'gitsigns'
      {'diff', source = diff_source}, -- Reuse diff infom from 'gitsigns'
    },
    lualine_c = lualine_c.active,
    lualine_x = {
      -- 'encoding',
      -- 'fileformat',
      -- 'filetype',
    },
    lualine_y = {
      { show_dap_status },
      { lsp_client },
      'diagnostics',
      'filetype',
    },
    lualine_z = {
      'location'
    }
  },
  inactive_sections = {
    lualine_a = lualine_a.inactive,
    -- Disable default settings for these sections
    lualine_c = {},
    lualine_x = {},
  },
  tabline = {},
  extensions = {
    minimal_info,
    "quickfix",
  }
})
