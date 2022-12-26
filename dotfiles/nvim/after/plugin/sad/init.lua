local f = require("ik1614.functions")
local plugin_name = "sad"

if not f.utils:plugin_installed(plugin_name) then
  return
end

local plugin = require(plugin_name)
plugin.setup({
  diff = 'delta', -- you can use `diff`, `diff-so-fancy`
  ls_file = 'fd', -- also git ls_file
  exact = false, -- exact match
  vsplit = false,
})
