-- Handy utility to print stuff
P = function(v)
  print(vim.inspect(v))
  return v
end

-- Bootstraps lazy.nvim, LazyVim distro, things from `config` and `plugins` direcrotiers
require("config.lazy")

-- In case, there are things specific to a particular machine.
vim.cmd("luafile ~/.config/nvim/init-local.lua")
