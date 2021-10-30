-- :LspInstall latex

require'lspconfig'.texlab.setup{
    cmd = {DATA_PATH .. "/lsp_servers/latex/texlab"}
}
