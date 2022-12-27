local f = require("ik1614.functions")
local plugin = f.utils:load_plugin("sad")

if not plugin then
  return
end

plugin.setup({
  diff = 'delta', -- you can use `diff`, `diff-so-fancy`
  ls_file = 'fd', -- also git ls_file
  exact = false, -- exact match
  vsplit = false,
})
