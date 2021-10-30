-- npm i -g bash-language-server
-- :LspInstall bashls

require'lspconfig'.bashls.setup {
    cmd = {DATA_PATH .. "/lsp_servers/bash/node_modules/.bin/bash-language-server", "start"},
    on_attach = require'ik1614.lsp'.common_on_attach,
    filetypes = { "sh", "zsh" }
}
