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

      local function lsp_status()
        return "LSP: TODO"
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
        inactive = empty_section
      }

      require("lualine").setup({
        options = {
          icons_enabled = false,
          disabled_filetypes = {
            'NvimTree'
          },
        },
        sections = {
          lualine_a = lualine_a.active,
          lualine_c = lualine_c.active,
          lualine_x = empty_section,
          lualine_y = {
            { dap_status },
            { lsp_status },
            'diagnostics',
            'filetype',
          },
          lualine_z = {
            'location'
          }
        },
        inactive_sections = {
          lualine_a = lualine_a.inactive,
          lualine_c = lualine_c.inactive,
          lualine_x = empty_section,
        },
        extensions = {
          "fugitive",
          "quickfix",
        }
      })
    end
  }
}
