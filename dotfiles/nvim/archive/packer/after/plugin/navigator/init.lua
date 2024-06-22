local utils = require("ik1614.functions.utils")
local map = require("ik1614.functions.mapping")
local plugin = utils:load_plugin("Navigator")

if not plugin then
  return
end

plugin.setup({
  -- When you want to save the modified buffers when moving to tmux
  -- nil - Don't save (default)
  -- 'current' - Only save the current modified buffer
  -- 'all' - Save all the buffers
  auto_save = "all",

  -- Disable navigation when tmux is zoomed in
  disable_on_zoom = true,
})

-- TODO: Somehow move keybindings to a central place.
map:n({ "<S-Left>", "<CMD>NavigatorLeft<CR>" })
map:n({ "<S-Right>", "<CMD>NavigatorRight<CR>" })
map:n({ "<S-Up>", "<CMD>NavigatorUp<CR>" })
map:n({ "<S-Down>", "<CMD>NavigatorDown<CR>" })
map:n({ "<C-\\>", "<CMD>NavigatorPrevious<CR>" })

map:i({ "<S-Left>", "<C-c><CMD>NavigatorLeft<CR>" })
map:i({ "<S-Right>", "<C-c><CMD>NavigatorRight<CR>" })
map:i({ "<S-Up>", "<C-c><CMD>NavigatorUp<CR>" })
map:i({ "<S-Down>", "<C-c><CMD>NavigatorDown<CR>" })
map:i({ "<C-\\>", "<C-c><CMD>NavigatorPrevious<CR>" })
