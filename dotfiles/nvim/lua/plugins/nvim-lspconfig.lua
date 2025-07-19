return {
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      --[[ 
        =================================================================================
        Generic settings
        =================================================================================
      --]]
      opts.diagnostics.underline = false
      -- opts.diagnostics.virtual_text.current_line = true

      --[[ 
        =================================================================================
        GOPLS
        =================================================================================
      --]]
      opts.servers.gopls.settings.gopls.hints.assignVariableTypes = false
      -- opts.servers.gopls.settings.gopls.hints.compositeLiteralFields = false
      opts.servers.gopls.settings.gopls.hints.compositeLiteralTypes = false
      -- opts.servers.gopls.settings.gopls.hints.constantValues = false
      -- opts.servers.gopls.settings.gopls.hints.functionTypeParameters = false
      opts.servers.gopls.settings.gopls.hints.parameterNames = false
      opts.servers.gopls.settings.gopls.hints.rangeVariableTypes = false
      -- ================================================================================
    end,
  },
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy", -- Or `LspAttach`
    priority = 1000, -- needs to be loaded in first
    config = function()
      require("tiny-inline-diagnostic").setup({
        preset = "powerline",
        options = {
          show_all_diags_on_cursorline = true,
        },
      })
      vim.diagnostic.config({ virtual_text = false }) -- Only if needed in your configuration, if you already have native LSP diagnostics
    end,
  },
}
