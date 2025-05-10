local error = vim.diagnostic.severity.ERROR

local function setup_ruff(lint)
  local severities = {
    ["F821"] = error, -- undefined name `name`
    ["E902"] = error, -- `IOError`
    ["E999"] = error, -- `SyntaxError`
  }

  lint.linters.ruff = {
    cmd = "ruff",
    stdin = true,
    args = {
      "check",
      "--force-exclude",
      "--quiet",
      "--stdin-filename",
      vim.api.nvim_buf_get_name(0),
      "--no-fix",
      "--output-format",
      "json",
      "-",
    },
    ignore_exitcode = true,
    stream = "stdout",
    parser = function(output)
      local diagnostics = {}
      local ok, results = pcall(vim.json.decode, output)
      if not ok then
        return diagnostics
      end
      for _, result in ipairs(results or {}) do
        local diagnostic = {
          message = result.message,
          col = result.location.column - 1,
          end_col = result.end_location.column - 1,
          lnum = result.location.row - 1,
          end_lnum = result.end_location.row - 1,
          code = result.code,
          severity = severities[result.code] or vim.diagnostic.severity.WARN,
          source = "ruff",
        }
        table.insert(diagnostics, diagnostic)
      end
      return diagnostics
    end,
  }
end

return {
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local lint = require("lint")

      -- NOTE: For some reason `ruff` doesn't seem to work out of the box. Maybe because I have the old version of the plugin?
      setup_ruff(lint)

      lint.linters_by_ft = {
        dockerfile = { "hadolint" },
        python = { "ruff" },
      }

      local lint_augroup = vim.api.nvim_create_augroup("ik1614-linting", { clear = true })
      vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
        group = lint_augroup,
        callback = function()
          require("lint").try_lint()
        end,
      })
    end,
  },
}
