return {
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    config = function()
      local formatting = require("ik1614.functions.formatting")
      require("conform").setup({
        notify_on_error = true,
        format_on_save = function(bufnr)
          -- Disable with a global-like variable
          if not formatting.enabled_on_save then
            return
          end

          -- Disable "format_on_save lsp_fallback" for languages that don't
          -- have a well standardized coding style.
          local disable_filetypes = { c = true, cpp = true }

          return {
            -- NOTE: There is an option to auto-detect slow running formatters and run them async:
            -- * https://github.com/stevearc/conform.nvim/blob/master/doc/recipes.md
            timeout_ms = 500,
            lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
          }
        end,
        formatters_by_ft = {
          lua = { "stylua" },
          python = {
            "ruff_fix", -- To fix auto-fixable lint errors
            "ruff_format",
            "ruff_organize_imports",
          },
          hcl = { "hcl" },
          go = { "goimports-reviser", "gofumpt" },
        },
      })

      vim.api.nvim_create_user_command("FormatToggle", function(_)
        formatting:toggle()
      end, { desc = "Toggle autoformat on save" })
    end,
  },
}
