return {
  {
    "https://github.com/nvim-lualine/lualine.nvim",
    enabled = true,
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "https://github.com/nvim-tree/nvim-web-devicons",
    },
    config = function()
      local formatting = require("ik1614.functions.formatting")

      local empty_section = {}

      local function dap_status()
        local dap = require("dap")
        local status = dap.status()
        if status == "" then
          return ""
        end

        return "DAP: " .. status
      end

      local function lsp_status(msg)
        --[[
            References:
            * https://github.com/alpha2phi/neovim-for-beginner/blob/14-null-ls/lua/config/lualine.lua
            * https://github.com/alpha2phi/neovim-for-beginner/blob/383bf9a7b655ef0da604e88773940a636ee3fae4/lua/config/lualine.lua#L22
          --]]
        msg = msg or ""
        local cur_buf = 0

        local info = {}
        local buf_clients = vim.lsp.get_clients({ bufnr = cur_buf })
        local buf_formatters = require("conform").list_formatters(cur_buf)
        local buf_linters = require("lint").get_running(cur_buf)

        if next(buf_clients) == nil and next(buf_formatters) == nil and next(buf_linters) == nil then
          if type(msg) == "boolean" or #msg == 0 then
            return ""
          end
          return msg
        end

        local lsp_info = {}
        for _, client in pairs(buf_clients) do
          table.insert(lsp_info, client.name)
        end

        if next(lsp_info) ~= nil then
          table.insert(info, "LSP: " .. table.concat(lsp_info, ", "))
        end

        -- NOTE: This feels a bit useless as we get linters only while they are running
        local linter_info = {}
        for _, linter in pairs(buf_linters) do
          table.insert(linter_info, linter.name)
        end

        if next(linter_info) ~= nil then
          table.insert(info, "Lint: " .. table.concat(lsp_info, ", "))
        end

        local formatter_info = {}
        if formatting.enabled_on_save then
          for _, formatter in pairs(buf_formatters) do
            if string.sub(formatter.name, 1, #"ruff") == "ruff" then
              local name = "ruff"
              if not formatter_info[name] then
                table.insert(formatter_info, name)
                formatter_info[name] = true
              end
            else
              table.insert(formatter_info, formatter.name)
            end
          end
        end

        if next(formatter_info) ~= nil then
          table.insert(info, "Format: " .. table.concat(formatter_info, ", "))
        end

        if next(info) == nil then
          return ""
        end

        return table.concat(info, " | ")
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
          "nvim-dap-ui",
        },
      })
    end,
  },
}
