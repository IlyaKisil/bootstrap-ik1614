-- NOTE:
-- See `:help lspconfig-all` for a list of all the pre-configured LSPs
--
-- * Quick links related to LSP
--   * https://github.com/neovim/nvim-lspconfig/wiki
--   * https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
--
-- * References for this setup
--   * https://github.com/nvim-lua/kickstart.nvim/blob/5aeddfdd5/init.lua
--   * https://github.com/dam9000/kickstart-modular.nvim/blob/01a18a193/lua/kickstart/plugins/lspconfig.lua
--   * https://github.com/tjdevries/config.nvim/blob/46eeb58874/lua/custom/plugins/lsp.lua
--   * https://github.com/josean-dev/dev-environment-files/blob/2c12f439f.config/nvim/lua/josean/plugins/lsp/lspconfig.lua
return {
  {
    "https://github.com/neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "https://github.com/williamboman/mason.nvim", config = true, version = "^1.0.0" }, -- NOTE: Must be loaded before dependants
      { "https://github.com/williamboman/mason-lspconfig.nvim", version = "^1.0.0" },
      { "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim" },
      {
        "https://github.com/j-hui/fidget.nvim",
        enabled = false,
        opts = {}, -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      },
      { "https://github.com/folke/neodev.nvim", opts = {} },
    },
    config = function()
      local mason = require("mason")
      local mason_tool_installer = require("mason-tool-installer")
      local mason_lspconfig = require("mason-lspconfig")
      local utils = require("ik1614.functions.utils")
      local formatting = require("ik1614.functions.formatting")
      local path = require("mason-core.path")

      vim.diagnostic.config({
        severity_sort = true,
        signs = true,
        underline = true,
        update_in_insert = false,
        virtual_text = {
          spacing = 4,
          prefix = "●",
        },
        float = { border = "rounded" },
      })

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("ik1614-lsp-attach", { clear = true }),
        callback = function(event)
          local client = vim.lsp.get_client_by_id(event.data.client_id)

          if not client then
            return
          end

          -- Highlight references of the word under your cursor
          if client.server_capabilities.documentHighlightProvider then
            local highlight_augroup = vim.api.nvim_create_augroup("ik1614-lsp-highlight", { clear = false })
            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd("LspDetach", {
              group = vim.api.nvim_create_augroup("ik1614-lsp-detach", { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds({ group = "ik1614-lsp-highlight", buffer = event2.buf })
              end,
            })
          end

          local map = require("ik1614.functions.mapping")
          map:buf_n({ "K", "<cmd>lua vim.lsp.buf.hover()<CR>" })
          map:buf_i({ "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>" })
          map:buf_n({ "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>" })
          map:buf_n({ "<leader>sa", '<cmd>lua require("ik1614.functions.fzf-lua"):lsp_code_actions()<CR>' })
          map:buf_n({ "<leader>ss", '<cmd>lua require("ik1614.functions.fzf-lua"):lsp_document_symbols()<CR>' })
          map:buf_n({ "<leader>sS", '<cmd>lua require("ik1614.functions.fzf-lua"):lsp_live_workspace_symbols()<CR>' })
          map:buf_n({ "<leader>sr", '<cmd>lua require("ik1614.functions.fzf-lua"):lsp_references()<CR>' })
          map:buf_n({ "<leader>si", '<cmd>lua require("ik1614.functions.fzf-lua"):lsp_implementations()<CR>' })
          map:buf_n({ "gT", '<cmd>lua require("ik1614.functions.fzf-lua"):lsp_typedefs()<CR>' })
          map:buf_n({ "gd", '<cmd>lua require("ik1614.functions.fzf-lua"):lsp_definitions()<CR>' })
          map:buf_n({ "gD", vim.lsp.buf.declaration }) -- TODO: switch to Fzf-Lua implementation

          if client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
            -- [T]oggle Inlay [H]ints
            map:buf_n({
              "<leader>th",
              function()
                vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
              end,
            })
          end

          if client.supports_method("textDocument/formatting") then
            local formatting_augroup = vim.api.nvim_create_augroup("ik1614-lsp-formatting", { clear = true })
            formatting:organise_go_imports_on_save(formatting_augroup)
          end

          utils:show_most_sever_diagnostics_sign()
        end,
      })

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

      --  Enable LSP and override configuration. Available keys are:
      --  * cmd (table):
      --      Override the default command used to start the server
      --
      --  * filetypes (table):
      --      Override the default list of associated filetypes for the server
      --
      --  * capabilities (table):
      --      Override fields in capabilities. Can be used to disable certain LSP features.
      --
      --  * settings (table):
      --      Override the default settings passed when initializing the server.
      --      For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
      local servers = {
        pyright = {
          before_init = function(_, config)
            -- Make LSP server to use virtual environment
            local p
            if vim.env.VIRTUAL_ENV then
              -- NOTE: Not sure if this is working :shrug:
              p = path.concat(vim.env.VIRTUAL_ENV, "bin", "python3")
            else
              p = utils:find_cmd("python3", ".venv/bin", config.root_dir)
              -- p = f.utils:find_cmd("python3", ".venv/bin", vim.fn.getcwd())
            end
            -- TODO: implement fall back to the system defaults
            config.settings.python.pythonPath = p
          end,
          python = {
            settings = {
              reportUnusedImport = true,
              reportUnusedVariable = true,
              reportDuplicateImport = true,
              reportDeprecated = true,
              reportUnnecessaryTypeIgnoreComment = true,
            },
          },
        },
        lua_ls = {
          settings = {
            Lua = {
              completion = {
                callSnippet = "Replace",
              },
              diagnostics = { disable = { "missing-fields" } },
            },
          },
        },
        gopls = {
          settings = { -- https://github.com/golang/tools/blob/master/gopls/doc/settings.md
            gopls = {
              completeUnimported = true,
              usePlaceholders = true, -- add placeholders for function parameters/struct fields
              gofumpt = false, -- Formatting is done by 'conform.nvim'
              analyses = { -- https://github.com/golang/tools/blob/master/gopls/doc/analyzers.md
                unusedparams = true,
                unusedwrite = true,
                shadow = true,
              },
            },
          },
        },
        ts_ls = {},
      }

      -- Ensure the servers and tools above are installed and ready to be used.
      -- This could also include some additional things used for formatting/linting.
      mason.setup({
        install_root_dir = path.concat({ DATA_PATH, "mason" }),
      })

      mason_tool_installer.setup({
        ensure_installed = {
          "black",
          "debugpy",
          "delve",
          "doctoc",
          "eslint_d",
          "flake8",
          "gofumpt",
          "goimports-reviser",
          "gopls",
          "hadolint",
          "hclfmt",
          "isort",
          "lua_ls",
          "prettier",
          "pylint",
          "pyright",
          "stylua",
          "typescript-language-server",
        },
      })

      mason_lspconfig.setup({
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            -- This handles overriding only values explicitly passed
            -- by the server configuration above. Useful when disabling
            -- certain features of an LSP (for example, turning off formatting for tsserver)
            server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
            require("lspconfig")[server_name].setup(server)
          end,
        },
      })
    end,
  },
}
