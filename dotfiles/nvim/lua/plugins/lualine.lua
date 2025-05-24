return {
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
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

        if next(buf_clients) == nil then
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

        if next(info) == nil then
          return ""
        end

        return table.concat(info, " | ")
      end

      local function remove_components_if_exist(components, names_to_remove)
        local filtered = {}
        for _, comp in ipairs(components or {}) do
          local name = type(comp) == "string" and comp or type(comp) == "table" and comp[1]
          if not vim.tbl_contains(names_to_remove, name) then
            table.insert(filtered, comp)
          end
        end
        return filtered
      end

      local empty_section = {}

      opts.options.disabled_filetypes.winbar = { "snacks_dashboard", "snacks_picker_list" }

      vim.list_extend(opts.extensions, {
        "fugitive",
        "nvim-dap-ui",
        "quickfix",
      })

      opts.sections.lualine_a = {
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
      }
      opts.sections.lualine_b = { "branch", "diff" }
      opts.sections.lualine_c = remove_components_if_exist(opts.sections.lualine_c, { "diagnostics", "filetype" })
      opts.sections.lualine_x = {
        Snacks.profiler.status(),
        -- NOTE: This displays key maps of some sort
        -- {
        --   function() return require("noice").api.status.command.get() end,
        --   cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
        --   color = function() return { fg = Snacks.util.color("Statement") } end,
        -- },
        -- stylua: ignore
        -- NOTE: Not sufe what this actually does
        {
          function() return require("noice").api.status.mode.get() end,
          cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
          color = function() return { fg = Snacks.util.color("Constant") } end,
        },
        -- stylua: ignore
        {
          function() return "  " .. require("dap").status() end,
          cond = function() return package.loaded["dap"] and require("dap").status() ~= "" end,
          color = function() return { fg = Snacks.util.color("Debug") } end,
        },
      }
      opts.sections.lualine_y = {
        {
          "diagnostics",
          symbols = { error = "E:", warn = "W:", info = "I:", hint = "H:" },
        },
      }
      opts.sections.lualine_z = { { "location", padding = { left = 0, right = 1 } } }

      opts.winbar = {
        lualine_a = {
          {
            "filename",
            path = 1,
          },
        },
        lualine_b = empty_section,
        lualine_c = empty_section,
        lualine_x = empty_section,
        lualine_y = {
          { lsp_status },
        },
        lualine_z = {
          {
            "filetype",
            fmt = function(str)
              return "ft=" .. str
            end,
            icons_enabled = false,
            padding = {
              left = 0,
              right = 1,
            },
          },
        },
      }
      opts.inactive_winbar = {
        lualine_a = empty_section,
        lualine_b = {
          {
            "filename",
            path = 1,
          },
        },
        lualine_c = empty_section,
        lualine_x = empty_section,
        lualine_y = empty_section,
        lualine_z = empty_section,
      }
    end,
  },
}
