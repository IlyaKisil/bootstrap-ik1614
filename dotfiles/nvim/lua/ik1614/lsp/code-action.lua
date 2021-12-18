local M = {}

local lsp_util = vim.lsp.util

function M.code_action_listener()
  local context = { diagnostics = vim.lsp.diagnostic.get_line_diagnostics() }
  local params = lsp_util.make_range_params()
  params.context = context
  vim.lsp.buf_request(0, 'textDocument/codeAction', params, function(err, _, result)
    -- do something with result - e.g. check if empty and show some indication such as a sign
    -- NOTE: there are quite a few options come from 'null-ls'
    require('ik1614.utils').info("popup code action when it is available")
  end)
end

-- NOTE: there are quite a few options come from 'null-ls'
-- To show a sign when a code action is available
-- vim.cmd([[
--   augroup LspCodeAction
--     autocmd! * <buffer>
--     autocmd CursorHold,CursorHoldI * lua require('ik1614.lsp.code-action').code_action_listener()
--   augroup END
-- ]])

return M
