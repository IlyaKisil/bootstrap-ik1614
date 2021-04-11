-- npm install -g typescript typescript-language-server

require'lspconfig'.tsserver.setup {
    -- cmd = {DATA_PATH .. "/lspinstall/typescript/node_modules/.bin/typescript-language-server", "--stdio"},
    on_attach = require'ik1614.lsp'.common_on_attach,
    filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
    root_dir = require('lspconfig.util').root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git"),
    settings = {
        documentFormatting = true
    },
    handlers = {
        ["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
            virtual_text = O.tsserver.diagnostics.virtual_text,
            signs = O.tsserver.diagnostics.signs,
            underline = O.tsserver.diagnostics.underline,
            update_in_insert = true
        })
    }
}