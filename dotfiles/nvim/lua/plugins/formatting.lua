return {
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      opts.formatters_by_ft.python = {
        "ruff_fix", -- To fix auto-fixable lint errors
        "ruff_format",
        "ruff_organize_imports",
      }
      opts.formatters_by_ft.hcl = {
        "hcl",
      }
      -- NOTE: Apparently this is handled by LazyVim
      -- opts.format_on_save = function(bufnr)
      --   if not vim.g.autoformat then
      --     return
      --   end
      --
      --   -- Disable "format_on_save lsp_fallback" for languages that don't
      --   -- have a well standardized coding style.
      --   local disable_lsp_fallback_filetypes = { c = true, cpp = true }
      --
      --   return {
      --     -- NOTE: There is an option to auto-detect slow running formatters and run them async:
      --     -- * https://github.com/stevearc/conform.nvim/blob/master/doc/recipes.md
      --     timeout_ms = 500,
      --     lsp_fallback = not disable_lsp_fallback_filetypes[vim.bo[bufnr].filetype],
      --   }
      -- end
    end,
  },
}
