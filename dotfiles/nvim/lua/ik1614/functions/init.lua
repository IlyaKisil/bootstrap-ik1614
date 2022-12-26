--[[
* Register collection of custom functions.

* Each of them can be accessed as either option
    require("ik1614.functions").__KEY__:__FUNCTION_NAME__()
    require("ik1614.functions")["__KEY__"]:__FUNCTION_NAME__()

--]]

local M = {
  format = require("ik1614.functions.format"),
  fzf = require("ik1614.functions.fzf-lua"),
  logging = require("ik1614.functions.logging"),
  mapping = require("ik1614.functions.mapping"),
  refactoring = require("ik1614.functions.refactoring"),
  utils = require("ik1614.functions.utils"),
}


return M
