-- References:
-- * https://github.com/tjdevries/config_manager/blob/627eb44c5324b9f6f0014abb995f8b29b548b7d7/xdg_config/nvim/lua/tj/globals/init.lua
-- * Some where in this video TJ DeVries goes over about this stuff https://www.youtube.com/watch?v=u6EKq6z0CRU

-- Utility to print stuff
P = function(v)
  print(vim.inspect(v))
  return v
end

-- Utility to hot reload/require stuff
if pcall(require, "plenary") then
  RELOAD = require("plenary.reload").reload_module

  R = function(name)
    RELOAD(name)
    return require(name)
  end
end

-- NOTE: not sure about this, but :shrug:
DATA_PATH = vim.fn.stdpath("data")
CACHE_PATH = vim.fn.stdpath("cache")
