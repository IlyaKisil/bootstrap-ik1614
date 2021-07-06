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
end

function lsp_config.tsserver_on_attach(client, bufnr)
    lsp_config.common_on_attach(client, bufnr)
    client.resolved_capabilities.document_formatting = false
end

return lsp_config
