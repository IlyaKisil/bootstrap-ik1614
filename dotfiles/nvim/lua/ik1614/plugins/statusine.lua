return {
  {
    "https://github.com/nvim-lualine/lualine.nvim",
    enabled = true,
    dependencies = {
      "https://github.com/nvim-tree/nvim-web-devicons",
    },
    config = function()
      local empty_section = {}

      local function dap_status()
        return "DAP: TODO"
      end

      local function lsp_status(msg)
        --[[
            References:
            * https://github.com/alpha2phi/neovim-for-beginner/blob/14-null-ls/lua/config/lualine.lua
            * https://github.com/alpha2phi/neovim-for-beginner/blob/383bf9a7b655ef0da604e88773940a636ee3fae4/lua/config/lualine.lua#L22
          --]]
        msg = msg or ""

        local buf_ft = vim.bo.filetype
        local buf_client_names = {}
        local buf_clients = vim.lsp.get_clients()
        if next(buf_clients) == nil then
          if type(msg) == "boolean" or #msg == 0 then
            return ""
          end
          return msg
        end

        for _, client in pairs(buf_clients) do
          if client.name ~= "null-ls" then
            table.insert(buf_client_names, client.name)
          end
        end

        if next(buf_client_names) == nil then
          return ""
        end

        return "LSP: " .. table.concat(buf_client_names, ", ")
      end

      local lualine_a = {
        active = {
          {
            "mode",
            fmt = function(str)
              return str:sub(1, 1)
            end,
            padding = {
              left = 1,
              right = 1,
            },
          },
        },
        inactive = {
          {
            "filename",
            path = 1,
          },
        },
      }

      local lualine_c = {
        active = {
          {
            "filename",
            path = 1,
          },
        },
        inactive = empty_section,
      }

      require("lualine").setup({
        options = {
          icons_enabled = false,
          disabled_filetypes = {
            "NvimTree",
          },
        },
        sections = {
          lualine_a = lualine_a.active,
          lualine_b = {
            "branch",
            "diff",
          },
          lualine_c = lualine_c.active,
          lualine_x = empty_section,
          lualine_y = {
            { dap_status },
            { lsp_status },
            "diagnostics",
            "filetype",
          },
          lualine_z = {
            "location",
          },
        },
        inactive_sections = {
          lualine_a = lualine_a.inactive,
          lualine_c = lualine_c.inactive,
          lualine_x = empty_section,
        },
        extensions = {
          "fugitive",
          "quickfix",
        },
      })
    end,
  },
}
