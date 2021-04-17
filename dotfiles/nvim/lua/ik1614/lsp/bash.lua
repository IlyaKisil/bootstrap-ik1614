-- npm i -g bash-language-server
-- :LspInstall bash

require'lspconfig'.bashls.setup {
    cmd = {DATA_PATH .. "/lspinstall/bash/node_modules/.bin/bash-language-server", "start"},
    on_attach = require'ik1614.lsp'.common_on_attach,
    filetypes = { "sh", "zsh" }
}
