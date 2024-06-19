local utils = require("ik1614.functions.utils")
local plugin = utils:load_plugin("nvim-autopairs")

if not plugin then
  return
end

plugin.setup({})
