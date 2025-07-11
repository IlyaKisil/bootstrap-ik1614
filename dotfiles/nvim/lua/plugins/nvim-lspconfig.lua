return {
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      --[[ 
        =================================================================================
        GOPLS
        =================================================================================
      --]]
      opts.servers.gopls.settings.gopls.hints.assignVariableTypes = false
      -- opts.servers.gopls.settings.gopls.hints.compositeLiteralFields = false
      -- opts.servers.gopls.settings.gopls.hints.compositeLiteralTypes = false
      -- opts.servers.gopls.settings.gopls.hints.constantValues = false
      -- opts.servers.gopls.settings.gopls.hints.functionTypeParameters = false
      opts.servers.gopls.settings.gopls.hints.parameterNames = false
      opts.servers.gopls.settings.gopls.hints.rangeVariableTypes = false
      -- ================================================================================
    end,
  },
}
