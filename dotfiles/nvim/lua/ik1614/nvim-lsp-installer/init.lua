local lsp_installer = require("nvim-lsp-installer")
local lsp_installer_servers = require'nvim-lsp-installer.servers'

local servers = {
    "pyright",
    "bashls",
    "gopls",
    "sumneko_lua",
}
-- for k,v in pairs(servers) do
--     print(k,v)
-- end
-- P(servers)


-- local ok, rust_analyzer = lsp_installer_servers.get_server("rust_analyzer")
-- if ok then
--     if not rust_analyzer:is_installed() then
--         rust_analyzer:install()
--     end
-- end


lsp_installer.on_server_ready(function(server)
    local opts = {}

    -- (optional) Customize the options passed to the server
    -- if server.name == "tsserver" then
    --     opts.root_dir = function() ... end
    -- end

    -- This setup() function is exactly the same as lspconfig's setup function (:help lspconfig-quickstart)
    -- server:setup(opts)
    vim.cmd [[ do User LspAttachBuffers ]]
end)
