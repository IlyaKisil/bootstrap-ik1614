return {
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      --[[ 
        =================================================================================
        Generic settings
        =================================================================================
      --]]
      opts.diagnostics.underline = false
      -- opts.diagnostics.virtual_text.current_line = true

      --[[ 
        =================================================================================
        GOPLS
        =================================================================================
      --]]
      opts.servers.gopls.settings.gopls.hints.assignVariableTypes = false
      opts.servers.gopls.settings.gopls.hints.compositeLiteralFields = false
      opts.servers.gopls.settings.gopls.hints.compositeLiteralTypes = false
      -- opts.servers.gopls.settings.gopls.hints.constantValues = false
      -- opts.servers.gopls.settings.gopls.hints.functionTypeParameters = false
      opts.servers.gopls.settings.gopls.hints.parameterNames = false
      opts.servers.gopls.settings.gopls.hints.rangeVariableTypes = false

      --[[
        =================================================================================
        PYRIGHT — uv inline script support, i.e.when have this 

          #!/usr/bin/env -S uv run --script
          # /// script
          # requires-python = ">=3.13"
          # dependencies = [
          #     "click",
          #     "requests",
          # ]
          # ///

        NOTE: 
        * This works only if such script is the first Python file that you open.
        * In reality we don't use the same venv as the script would be at run time.
          Instead, we just replicate it by constracting an equivalent `uv` command.
          This is because we can't get `uv` to print the location of the venv that
          will be used at runtime.
        =================================================================================
      --]]
      opts.servers.pyright = opts.servers.pyright or {}
      opts.servers.pyright.on_new_config = function(config, _)
        if vim.fn.exepath("uv") == "" then
          return
        end

        local bufnr = vim.fn.bufnr("%")
        if bufnr == -1 then
          return
        end

        local first_line = (vim.api.nvim_buf_get_lines(bufnr, 0, 1, false))[1] or ""
        if not first_line:match("uv run.*%-%-script") then
          return
        end

        local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
        local in_block, metadata = false, {}
        for _, line in ipairs(lines) do
          if line == "# /// script" then
            in_block = true
          elseif in_block and line == "# ///" then
            break
          elseif in_block then
            table.insert(metadata, line:match("^# ?(.*)$") or "")
          end
        end

        local deps, python_req, in_deps = {}, nil, false
        for _, line in ipairs(metadata) do
          if line:match("^requires%-python") then
            python_req = line:match('"(.-)"') or line:match("'(.-)'")
          elseif line:match("^dependencies%s*=") then
            in_deps = true
          elseif in_deps and line:match("^%]") then
            in_deps = false
          elseif in_deps then
            local dep = line:match('"(.-)"') or line:match("'(.-)'")
            if dep then
              table.insert(deps, dep)
            end
          end
        end

        local cmd = { "uv", "run", "--no-project" }
        for _, dep in ipairs(deps) do
          vim.list_extend(cmd, { "--with", dep })
        end
        if python_req then
          vim.list_extend(cmd, { "--python", python_req })
        end
        vim.list_extend(cmd, { "python", "-c", "import sys, os; print(os.path.join(sys.prefix, 'bin', 'python3'))" })

        local result = vim.fn.system(cmd)
        if vim.v.shell_error == 0 then
          config.settings = vim.tbl_deep_extend("force", config.settings or {}, {
            python = { pythonPath = vim.trim(result) },
          })
        end
      end
      -- ================================================================================
    end,
  },
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "LspAttach",
    priority = 1000, -- needs to be loaded in first
    config = function()
      require("tiny-inline-diagnostic").setup({
        preset = "powerline",
        options = {
          show_all_diags_on_cursorline = true,
        },
      })
      vim.diagnostic.config({ virtual_text = false }) -- Only if needed in your configuration, if you already have native LSP diagnostics
    end,
  },
}
