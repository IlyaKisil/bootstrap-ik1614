-- Automatically update diagnostics
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = true,
    update_in_insert = false,
    virtual_text = false,
    -- virtual_text = {
    --   spacing = 4,
    --   prefix = "●"
    -- },
    severity_sort = true,
    signs = true,
  }
)

local signs = {
  Error = "E",
  -- Error = "",
  -- Error = " ",
  Warn = "W",
  -- Warn = "",
  -- Warn = " ",
  Info = "I",
  -- Info = "",
  -- Info = " ",
  Hint = "H",
  -- Hint = "",
  -- Hint = " ",
}

for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end
