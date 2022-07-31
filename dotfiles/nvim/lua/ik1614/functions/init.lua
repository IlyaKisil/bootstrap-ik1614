--[[
* Register collection of custom functions.

* Each of them can be accessed as
   require("ik1614.functions")["__KEY__"]:__FUNCTION_NAME__()

--]]


local M = {
  ["fzf"] = require("ik1614.functions.fzf-lua"),
  ["refactoring"] = require("ik1614.functions.refactoring")
}


return M
