-- References:
-- * https://github.com/tjdevries/config_manager/blob/627eb44c5324b9f6f0014abb995f8b29b548b7d7/xdg_config/nvim/lua/tj/globals/init.lua
-- * Some where in this video TJ DeVries goes over about this stuff https://www.youtube.com/watch?v=u6EKq6z0CRU

-- Utility to print stuff
P = function(v)
  print(vim.inspect(v))
  return v
end

-- GET_COLOR = function (color_name)
--   local color = vim.api.nvim_get_var('ik1614_color_palette')[color_name][1]
--   return color
-- end


-- Utility to hot reload/require stuff
if pcall(require, 'plenary') then
  RELOAD = require('plenary.reload').reload_module

  R = function(name)
    RELOAD(name)
    return require(name)
  end
end
