local utils = require("ik1614.utils")
local mapping = require("ik1614.functions.mapping")

local required_plugins = {
  "mason",
  "mason-lspconfig",
  "lspconfig",
}

for _, plugin_name in pairs(required_plugins) do
  if not utils.plugin_installed(plugin_name) then
    utils.warn("LSP is disabled as it requires [" .. plugin_name .. "] plugin")
    return
  end
end

local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")
local lspconfig = require("lspconfig")
local path = require "mason-core.path"


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
  },
  automatic_installation = true
})


-- NOTE: not sure what this does exactly.
-- Take from https://github.com/tjdevries/config_manager/blob/cf973aa85234d0b9fb8b81b2652b87a304440c1c/xdg_config/nvim/lua/tj/lsp/init.lua#L32
local custom_on_init = function(client)
  client.config.flags = client.config.flags or {}
  client.config.flags.allow_incremental_sync = true
end

local custom_on_attach = function(client)
  local filetype = vim.api.nvim_buf_get_option(0, "filetype")

  mapping:buf_nnoremap({ "K", ':lua vim.lsp.buf.hover()<CR>' })
  mapping:buf_inoremap({ "<C-k>", '<cmd>lua vim.lsp.buf.signature_help()<CR>' })

  mapping:buf_nnoremap({ "gd", ':lua require("ik1614.functions.fzf-lua"):lsp_definitions()<CR>' })
  -- TODO: switch to Fzf-Lua implementation
  mapping:buf_nnoremap({ "gD", vim.lsp.buf.declaration })
  mapping:buf_nnoremap({ "gT", ':lua require("ik1614.functions.fzf-lua"):lsp_typedefs()<CR>' })

  mapping:buf_nnoremap({ "<leader>sl", ':lua vim.diagnostic.open_float()<CR>' })
  mapping:buf_nnoremap({ "<leader>sn", ':lua vim.diagnostic.goto_next()<CR>' })
  mapping:buf_nnoremap({ "<leader>se", ':lua vim.diagnostic.goto_prev()<CR>' })

  -- TODO: create general mapping for fzf spefic stuff
  mapping:buf_nnoremap({ "<leader>sa", ':lua require("ik1614.functions.fzf-lua"):lsp_code_actions()<CR>' })
  mapping:buf_nnoremap({ "<leader>ss", ':lua require("ik1614.functions.fzf-lua"):lsp_document_symbols()<CR>' })
  mapping:buf_nnoremap({ "<leader>sS", ':lua require("ik1614.functions.fzf-lua"):lsp_live_workspace_symbols()<CR>'})
  mapping:buf_nnoremap({ "<leader>sd", ':lua require("ik1614.functions.fzf-lua"):lsp_document_diagnostics()<CR>' })
  mapping:buf_nnoremap({ "<leader>sD", ':lua require("ik1614.functions.fzf-lua"):lsp_workspace_diagnostics()<CR>' })
  mapping:buf_nnoremap({ "<leader>sr", ':lua require("ik1614.functions.fzf-lua"):lsp_references()<CR>' })
  mapping:buf_nnoremap({ "<leader>si", ':lua require("ik1614.functions.fzf-lua"):lsp_implementations()<CR>' })

  mapping:buf_nnoremap({ "<leader>rn", ':lua vim.lsp.buf.rename()<CR>' })

  vim.bo.omnifunc = "v:lua.vim.lsp.omnifunc"

  -- Set autocommands conditional on server_capabilities
  if client.server_capabilities.documentHighlightProvider then
    vim.cmd [[
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]]
  end

end


local custom_capabilities = vim.lsp.protocol.make_client_capabilities()
-- if nvim_status then
--   updated_capabilities = vim.tbl_deep_extend("keep", updated_capabilities, nvim_status.capabilities)
-- end
-- updated_capabilities.textDocument.codeLens = { dynamicRegistration = false }
custom_capabilities = require("cmp_nvim_lsp").update_capabilities(custom_capabilities)

-- TODO: check if this is the problem.
-- updated_capabilities.textDocument.completion.completionItem.insertReplaceSupport = false


local setup_server = function(server, config)
  if not config then
    utils.warn("Skipped [" .. server .. "] as no config was provided")
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

return {
  on_init = custom_on_init,
  on_attach = custom_on_attach,
  capabilities = custom_capabilities,
}
