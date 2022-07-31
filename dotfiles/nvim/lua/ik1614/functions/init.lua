--[[
* Register collection of custom functions.

* Each of them can be accessed as either option
    require("ik1614.functions").__KEY__:__FUNCTION_NAME__()
    require("ik1614.functions")["__KEY__"]:__FUNCTION_NAME__()

--]]


local M = {
  fzf = require("ik1614.functions.fzf-lua"),
  refactoring = require("ik1614.functions.refactoring"),
}


return M
