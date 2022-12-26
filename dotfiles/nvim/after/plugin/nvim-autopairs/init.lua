local f = require("ik1614.functions")
local plugin_name = "nvim-autopairs"

if not f.utils:plugin_installed(plugin_name) then
  return
end

local plugin = require(plugin_name)
plugin.setup({})

