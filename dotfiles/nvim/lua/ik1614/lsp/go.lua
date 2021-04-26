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

local M = {}

function M.organize_imports(timeout_ms)
    local context = { source = { organizeImports = true } }
    vim.validate { context = { context, "t", true } }

    local params = vim.lsp.util.make_range_params()
    params.context = context

    -- See the implementation of the textDocument/codeAction callback
    -- (lua/vim/lsp/handler.lua) for how to do this properly.
    local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, timeout_ms)
    if not result or next(result) == nil then return end
    local actions = result[1].result
    if not actions then return end
    local action = actions[1]

    -- textDocument/codeAction can return either Command[] or CodeAction[]. If it
    -- is a CodeAction, it can have either an edit, a command or both. Edits
    -- should be executed first.
    if action.edit or type(action.command) == "table" then
      if action.edit then
        vim.lsp.util.apply_workspace_edit(action.edit)
      end
      if type(action.command) == "table" then
        vim.lsp.buf.execute_command(action.command)
      end
    else
      vim.lsp.buf.execute_command(action)
    end
end

vim.cmd([[
    augroup ik1614_organize_imports
      autocmd BufWritePre *.go execute('lua require("ik1614.lsp.go").organize_imports(1000)')
      autocmd BufWritePre *.go execute('lua vim.lsp.buf.formatting_sync(nil, 1000)')
    augroup END
]])

return M
