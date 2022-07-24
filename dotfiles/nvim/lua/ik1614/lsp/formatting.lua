local util = require("ik1614.utils")

local M = {}

-- vim.lsp.handlers["textDocument/hover"] = function(_, method, result)
--   print(vim.inspect(result))
-- end

M.autoformat = true

function M.toggle()
  M.autoformat = not M.autoformat
  if M.autoformat then
    util.info("enabled format on save", "Formatting")
  else
    util.warn("disabled format on save", "Formatting")
  end
end

function M.format()
  if M.autoformat then
    -- vim.lsp.buf.formatting_sync()
    vim.lsp.buf.format({
      async = false,
    })
  end
end

function M.organize_go_imports(timeout_ms)
  -- NOTE: taken from https://github.com/golang/tools/blob/master/gopls/doc/vim.md#imports
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

function M.setup(client, buf)
  local ft = vim.api.nvim_buf_get_option(buf, "filetype")
  local nls = require("ik1614.lsp.null-ls")

  local enable = false
  if nls.has_formatter(ft) then
    enable = client.name == "null-ls"
  else
    enable = not (client.name == "null-ls")
  end

  -- client.resolved_capabilities.document_formatting = enable
  -- format on save
  if client.server_capabilities.documentFormattingProvider then
    vim.cmd([[
    augroup LspFormat
      autocmd! * <buffer>
      autocmd BufWritePre <buffer> lua require("ik1614.lsp.formatting").format()
      autocmd BufWritePre *.go execute('lua require("ik1614.lsp.formatting").organize_go_imports(1000)')
    augroup END
    ]])
  end
end

return M
