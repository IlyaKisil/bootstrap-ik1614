local utils = require("ik1614.utils")
local lsp_util = require("lspconfig/util")

require("ik1614.lsp.diagnostics")
require("ik1614.lsp.kind").setup()

local function on_attach(client, bufnr)
  require("ik1614.lsp.formatting").setup(client, bufnr)
  -- require("ik1614.lsp.keys").setup(client, bufnr)
  -- require("ik1614.lsp.completion").setup(client, bufnr)
  require("ik1614.lsp.highlighting").setup(client)

  -- TypeScript specific stuff
  if client.name == "typescript" or client.name == "tsserver" then
    require("ik1614.lsp.ts-utils").setup(client)
  end
end

-- NOTE:
-- * All LSP servers specified bellow will be auto-installed
-- * For the list of available LSP servers you can use ':LspInstallInfo'
-- * Put specific settings for an LSP server, which will be merged with common options
local servers = {
  bashls = {
    filetypes = {"sh", "zsh"}
  },

  cssls = {},
  dockerls = {},
  gopls = {},
  html = {},
  jsonls = {},

  pyright = {
    before_init = function(_, config)
      -- Make LSP server to use virtual environment
      local p
      if vim.env.VIRTUAL_ENV then
        p = lsp_util.path.join(vim.env.VIRTUAL_ENV, "bin", "python3")
      else
        p = utils.find_cmd("python3", ".venv/bin", config.root_dir)
      end
      config.settings.python.pythonPath = p
    end,
  },

  sumneko_lua = {
    settings = {
      Lua = {
        diagnostics = {
          globals = {
            'vim'
          },
          disable = {
            "trailing-space",
          },
        }
      }
    }
  },
  tsserver = {},
  vimls = {},
}

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())


require("lua-dev").setup() -- Not sure that this works :shrug:

local options = {
  on_attach = on_attach,
  capabilities = capabilities,
  flags = {
    debounce_text_changes = 150,
  },
}
-- require("ik1614.lsp.null-ls").setup(options) -- TODO: better understand how this works etc
require("ik1614.lsp.install").setup(servers, options)
