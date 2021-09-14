-- TODO figure out why this don't work
vim.fn.sign_define(
    "LspDiagnosticsSignError",
    {
        -- text = "",
        text = "E",
        texthl = "LspDiagnosticsSignError",
        numhl  = "LspDiagnosticsSignError"
    }
)

vim.fn.sign_define(
    "LspDiagnosticsSignWarning",
    {
        -- text = "",
        text = "W",
        texthl = "LspDiagnosticsSignWarning",
        numhl  = "LspDiagnosticsSignWarning"
    }
)
vim.fn.sign_define(
    "LspDiagnosticsSignHint",
    {
        -- text = "",
        text = "H",
        texthl = "LspDiagnosticsSignHint",
        numhl  = "LspDiagnosticsSignHint"
    }
)
vim.fn.sign_define(
    "LspDiagnosticsSignInformation",
    {
        -- text = "",
        text = "I",
        texthl = "LspDiagnosticsSignInformation",
        numhl  = "LspDiagnosticsSignInformation"
    }
)


vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    -- Enable underline, use default values
    underline = true,

    -- Turn on sings in gutter
    signs = true,

    -- Disable a feature
    update_in_insert = false,

    -- Use a function to dynamically turn virtual_text off
    -- and on, using buffer local variables. Example of setting it up
    --   vim.api.nvim_buf_set_var(
    --     0,
    --     'virtual_text',
    --     {
    --       spacing = 4,
    --       prefix = '~',
    --     }
    --   )
    virtual_text = function(bufnr, client_id)
      local ok, result = pcall(vim.api.nvim_buf_get_var, bufnr, 'virtual_text')
      -- No buffer local variable set, so just enable by default
      if not ok then
        return false
      end

      return result
    end,
  }
)

local function documentHighlight(client, bufnr)
    -- Set autocommands conditional on server_capabilities
    if client.resolved_capabilities.document_highlight then
        vim.api.nvim_exec([[
            augroup lsp_document_highlight
                autocmd! * <buffer>
                autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
                autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
            augroup END
        ]], false)
    end

end

-- Enable snippets integration
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    'documentation',
    'detail',
    'additionalTextEdits',
  }
}

local lsp_config = {}

function lsp_config.common_on_attach(client, bufnr)
    documentHighlight(client, bufnr)

    local opts = { noremap = true, silent = true }
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gI', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'ge', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gn', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>d', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)

    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    -- Mnemonic: show aciton
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>sa', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'v', '<leader>sa', '<cmd>lua vim.lsp.buf.range_code_action()<CR>', opts)

    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)

    -- Show errors/diagnostics
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>sd', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)

    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)

    -- Show symbols
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ss', [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]], opts)

    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)

end

function lsp_config.tsserver_on_attach(client, bufnr)
    lsp_config.common_on_attach(client, bufnr)
    client.resolved_capabilities.document_formatting = false
end

return lsp_config
