local utils = require("ik1614.functions.utils")
local mapping = require("ik1614.functions.mapping")
local logging = require("ik1614.functions.logging")
local f = require("ik1614.functions")

local required_plugins = {
  "mason",
  "mason-lspconfig",
  "lspconfig",
  "lsp-status",
  "null-ls",
}

for _, plugin_name in pairs(required_plugins) do
  if not utils:plugin_installed(plugin_name) then
    logging:warn("LSP is disabled as it requires [" .. plugin_name .. "] plugin")
    return
  end
end

local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")
local lspconfig = require("lspconfig")
local lsp_status = require("lsp-status")
local path = require "mason-core.path"
local null_ls = require("null-ls")

vim.diagnostic.config({
  severity_sort = true,
  signs = true,
  underline = true,
  update_in_insert = false,
  virtual_text = {
    spacing = 4,
    prefix = "●"
  },
})

lsp_status.config {
  indicator_ok = "",
  status_symbol = "LSP",
  spinner_frames = { "⣾", "⣽", "⣻", "⢿", "⡿", "⣟", "⣯", "⣷" },
  diagnostics = false,
  current_function = false,
}
lsp_status.register_progress()

mason.setup({
  ui = {
    border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
  },
  install_root_dir = path.concat({DATA_PATH, 'mason'}),
})


mason_lspconfig.setup({
  ensure_installed = {
    "sumneko_lua",
    "pyright",
    "gopls",
    "bashls",
  },
  automatic_installation = true
})

--[[
      Define all augroups here
--]]
local augroup_format = vim.api.nvim_create_augroup("lsp_format", { clear = true })


--[[
      Define everything that should be done when on attach of LSP client
--]]
local filetype_on_attach = setmetatable({
  go = function()
    -- TODO: there are some issues with formatting, e.g. it might truncate begining of the line where there are extra tabs :shrug:
    -- f.format:autocmd_format(augroup_format, false)
    f.format:autocmd_organise_go_imports(augroup_format)
  end,
}, {
  __index = function()
    return function() end
  end,
})

local custom_on_attach = function(client)
  local filetype = vim.api.nvim_buf_get_option(0, "filetype")

  lsp_status.on_attach(client)

  --[[
       Define mappings only for buffers with have LSP client attached to them
  --]]
  mapping:buf_nnoremap({ "K", ':lua vim.lsp.buf.hover()<CR>' })
  mapping:buf_inoremap({ "<C-k>", '<cmd>lua vim.lsp.buf.signature_help()<CR>' })
  mapping:buf_nnoremap({ "gd", ':lua require("ik1614.functions.fzf-lua"):lsp_definitions()<CR>zz' })
  mapping:buf_nnoremap({ "gD", vim.lsp.buf.declaration }) -- TODO: switch to Fzf-Lua implementation
  mapping:buf_nnoremap({ "gT", ':lua require("ik1614.functions.fzf-lua"):lsp_typedefs()<CR>' })
  mapping:buf_nnoremap({ "<leader>sl", ':lua vim.diagnostic.open_float()<CR>' })
  mapping:buf_nnoremap({ "<leader>sn", ':lua vim.diagnostic.goto_next()<CR>' })
  mapping:buf_nnoremap({ "<leader>se", ':lua vim.diagnostic.goto_prev()<CR>' })
  mapping:buf_nnoremap({ "<leader>rn", ':lua vim.lsp.buf.rename()<CR>' })
  -- TODO: create general mapping for fzf spefic stuff
  mapping:buf_nnoremap({ "<leader>sa", ':lua require("ik1614.functions.fzf-lua"):lsp_code_actions()<CR>' })
  mapping:buf_nnoremap({ "<leader>ss", ':lua require("ik1614.functions.fzf-lua"):lsp_document_symbols()<CR>' })
  mapping:buf_nnoremap({ "<leader>sS", ':lua require("ik1614.functions.fzf-lua"):lsp_live_workspace_symbols()<CR>'})
  mapping:buf_nnoremap({ "<leader>sd", ':lua require("ik1614.functions.fzf-lua"):lsp_document_diagnostics()<CR>' })
  mapping:buf_nnoremap({ "<leader>sD", ':lua require("ik1614.functions.fzf-lua"):lsp_workspace_diagnostics()<CR>' })
  mapping:buf_nnoremap({ "<leader>sr", ':lua require("ik1614.functions.fzf-lua"):lsp_references()<CR>' })
  mapping:buf_nnoremap({ "<leader>si", ':lua require("ik1614.functions.fzf-lua"):lsp_implementations()<CR>' })

  vim.bo.omnifunc = "v:lua.vim.lsp.omnifunc"

  --[[
       Set autocommands conditional on server_capabilities
  --]]
  if client.server_capabilities.documentHighlightProvider then
    -- NOTE: Sometimes shadows yank highlight area. Typically this happens if you
    -- need to yank the same thing again without cursor being moved :shrug:
    -- vim.cmd [[
    --   augroup lsp_document_highlight
    --     autocmd! * <buffer>
    --     autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
    --     autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
    --   augroup END
    -- ]]
  end

  if client.server_capabilities.codeLensProvider then
    if filetype ~= "elm" then
      -- vim.cmd [[
      --   augroup lsp_document_codelens
      --     au! * <buffer>
      --     autocmd BufEnter ++once         <buffer> lua vim.lsp.codelens.refresh()
      --     autocmd BufWritePost,CursorHold <buffer> lua vim.lsp.codelens.refresh()
      --   augroup END
      -- ]]
    end
  end

  --[[
       Attach any filetype specific options to the client
  --]]
  filetype_on_attach[filetype](client)
end


-- NOTE: not sure what this does exactly.
-- Take from https://github.com/tjdevries/config_manager/blob/cf973aa85234d0b9fb8b81b2652b87a304440c1c/xdg_config/nvim/lua/tj/lsp/init.lua#L32
local custom_on_init = function(client)
  client.config.flags = client.config.flags or {}
  client.config.flags.allow_incremental_sync = true
end


local custom_capabilities = vim.lsp.protocol.make_client_capabilities()
custom_capabilities = vim.tbl_deep_extend("keep", custom_capabilities, lsp_status.capabilities)
custom_capabilities.textDocument.codeLens = { dynamicRegistration = false }
-- custom_capabilities = require("cmp_nvim_lsp").update_capabilities(custom_capabilities)
custom_capabilities = require("cmp_nvim_lsp").default_capabilities(custom_capabilities)
-- custom_capabilities = require("cmp_nvim_lsp").default_capabilities()

-- TODO: check if this is the problem.
-- custom_capabilities.textDocument.completion.completionItem.insertReplaceSupport = false


local function setup_server(server, config)
  if not config then
    logging:warn("Skipped [" .. server .. "] as no config was provided")
    return
  end

  if type(config) ~= "table" then
    config = {}
  end

  config = vim.tbl_deep_extend("force", {
    on_init = custom_on_init,
    on_attach = custom_on_attach,
    capabilities = custom_capabilities,
    flags = {
      debounce_text_changes = nil,
    },
  }, config)

  lspconfig[server].setup(config)
end


local servers = {
  -- bashls = true, -- Doesn't play ball with 'environment.template' which I have as 'sh' filetype
  pyright = true,
  -- pyright = {
  --   before_init = function(_, config)
  --     -- Make LSP server to use virtual environment
  --     local p
  --     if vim.env.VIRTUAL_ENV then
  --       p = path.concat(vim.env.VIRTUAL_ENV, "bin", "python3")
  --     else
  --       p = utils.find_cmd("python3", ".venv/bin", config.root_dir)
  --     end
  --     config.settings.python.pythonPath = p
  --   end,
  -- },
  gopls = {
    root_dir = function(fname)
      local Path = require "plenary.path"

      local absolute_cwd = Path:new(vim.loop.cwd()):absolute()
      local absolute_fname = Path:new(fname):absolute()

      if string.find(absolute_cwd, "/cmd/", 1, true) and string.find(absolute_fname, absolute_cwd, 1, true) then
        return absolute_cwd
      end

      return require("lspconfig.util").root_pattern("go.mod", ".git")(fname)
    end,

    settings = {
      gopls = {
        codelenses = { -- https://github.com/golang/tools/blob/master/gopls/doc/settings.md#code-lenses
          test = true,
        },
        gofumpt = false, -- NOTE: it won't format if there are errors
        -- staticcheck = true, -- NOTE: Requires Go > 1.17
        analyses = {
          unusedparams = true,
          unusedwrite = true,
          shadow = true,
        }
      },
    },

    flags = {
      debounce_text_changes = 200,
    },
  },
  sumneko_lua = {
    settings = {
      Lua = {
        diagnostics = {
          globals = {
            -- vim
            "vim",
            -- Custom
            "RELOAD",
            "P"
          },
          disable = {
            "trailing-space",
          },
        },
        workspace = {
          -- Make the server aware of Neovim runtime files
          library = vim.api.nvim_get_runtime_file("", true),
        },
      },
    },
  },
}


for server, config in pairs(servers) do
  setup_server(server, config)
end


-- null_ls.setup({
--   sources = {
--     null_ls.builtins.code_actions.gitsigns,
--     null_ls.builtins.code_actions.refactoring,
--     null_ls.builtins.code_actions.shellcheck.with({
--       runtime_condition = function()
--         -- Disable null-ls for 'environment.template' files
--         return not f.utils:is_environment_template()
--       end,
--     }),
--     -- null_ls.builtins.diagnostics.cspell,
--     null_ls.builtins.diagnostics.shellcheck.with({
--       runtime_condition = function()
--         -- Disable null-ls for 'environment.template' files
--         return not f.utils:is_environment_template()
--       end,
--     }),
--     -- NOTE: Some formatters might not trigger if there are errors in the code
--     null_ls.builtins.formatting.black,
--     null_ls.builtins.formatting.shfmt,
--     null_ls.builtins.formatting.terraform_fmt.with({
--       timeout = 10000,
--     }),

--   },
--   on_attach = custom_on_attach,
--   diagnostics_format = "#{m} (#{s})",
-- })

return {
  on_init = custom_on_init,
  on_attach = custom_on_attach,
  capabilities = custom_capabilities,
}
