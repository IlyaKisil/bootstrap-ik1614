local utils = require("ik1614.utils")
local plugin_name = "nvim-autopairs"

if not utils.plugin_installed(plugin_name) then
  return
end

local plugin = require(plugin_name)
plugin.setup({})

