local utils = require("ik1614.functions.utils")
local plugin_name = "refactoring"

if not utils:plugin_installed(plugin_name) then
  return
end

local plugin = require(plugin_name)
plugin.setup({})
