local logging = require("ik1614.functions.logging")

local M = {}
M.__index = M

function M.new()
  local self = setmetatable({}, M)
  self.enabled_on_save = true
  return self
end

-- Taken from https://github.com/golang/tools/blob/master/gopls/doc/vim.md#imports
function M:organise_go_imports(wait_ms)
  local params = vim.lsp.util.make_range_params()
  params.context = { only = { "source.organizeImports" } }
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
  self.enabled_on_save = not self.enabled_on_save
  if self.enabled_on_save then
    logging:info("Enabled format on save")
  else
    logging:warn("Disabled format on save")
  end
end

function M:format(async, filter)
  if self.enabled_on_save then
    vim.lsp.buf.format({
      async = async,
      filter = filter,
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
    end,
  })
end

function M:autocmd_organise_go_imports(augroup)
  vim.api.nvim_clear_autocmds({ buffer = 0, group = augroup })
  vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*.go",
    callback = function()
      self:organise_go_imports(1000)
    end,
  })
end

return M.new()
