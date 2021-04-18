-- :LspInstall go

require'lspconfig'.gopls.setup{
  cmd = {DATA_PATH .. "/lspinstall/go/gopls"},
  on_attach = require'ik1614.lsp'.common_on_attach,
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
    },
  }
}
