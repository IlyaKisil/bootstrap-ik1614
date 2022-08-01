local utils = require("ik1614.utils")

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



local updated_capabilities = vim.lsp.protocol.make_client_capabilities()
-- if nvim_status then
--   updated_capabilities = vim.tbl_deep_extend("keep", updated_capabilities, nvim_status.capabilities)
-- end
-- updated_capabilities.textDocument.codeLens = { dynamicRegistration = false }
updated_capabilities = require("cmp_nvim_lsp").update_capabilities(updated_capabilities)

-- TODO: check if this is the problem.
-- updated_capabilities.textDocument.completion.completionItem.insertReplaceSupport = false


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


local setup_server = function(server, config)
  if not config then
    utils.warn("Skipped [" .. server .. "] as no config was provided")
    return
  end

  if type(config) ~= "table" then
    config = {}
  end

  config = vim.tbl_deep_extend("force", {
    -- on_init = custom_init,
    -- on_attach = custom_attach,
    capabilities = updated_capabilities,
    flags = {
      debounce_text_changes = nil,
    },
  }, config)

  lspconfig[server].setup(config)
end

for server, config in pairs(servers) do
  setup_server(server, config)
end
