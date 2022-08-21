local util = require("ik1614.utils")

local M = {}
M.__index = M

function M.new()
  local self = setmetatable({}, M)
  self.auto_format = true
  return self
end


-- Taken from https://github.com/golang/tools/blob/master/gopls/doc/vim.md#imports
function M:organise_go_imports(wait_ms)
  local params = vim.lsp.util.make_range_params()
  params.context = {only = {"source.organizeImports"}}
  local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, wait_ms)
  for cid, res in pairs(result or {}) do
    for _, r in pairs(res.result or {}) do
      if r.edit then
        local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
        vim.lsp.util.apply_workspace_edit(r.edit, enc)
      end
    end
  end
end


function M:toggle()
  self.auto_format = not self.auto_format
  if self.auto_format then
    util.info("Enabled format on save")
  else
    util.warn("Disabled format on save")
  end
end


function M:format(async, filter)
  if self.auto_format then
    vim.lsp.buf.format({
      async = async,
      filter = filter
    })
  end
end


-- Create autocommand to format things
function M:autocmd_format(augroup, async, filter)
  vim.api.nvim_clear_autocmds({ buffer = 0, group = augroup })
  vim.api.nvim_create_autocmd("BufWritePre", {
    buffer = 0,
    pattern = pattern,
    callback = function()
      self:format(async, filter)
    end
  })
end

function M:autocmd_organise_go_imports(augroup)
  vim.api.nvim_clear_autocmds({ buffer = 0, group = augroup })
  vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*.go",
    callback = function()
      self:organise_go_imports(1000)
    end
  })
end

return M.new()

