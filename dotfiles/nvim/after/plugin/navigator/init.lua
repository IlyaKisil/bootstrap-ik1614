local f = require("ik1614.functions")
local plugin_name = "Navigator"

if not f.utils:plugin_installed(plugin_name) then
  return
end

local plugin = require(plugin_name)
plugin.setup({
    -- When you want to save the modified buffers when moving to tmux
    -- nil - Don't save (default)
    -- 'current' - Only save the current modified buffer
    -- 'all' - Save all the buffers
    auto_save = 'all',

    -- Disable navigation when tmux is zoomed in
    disable_on_zoom = true
})

-- TODO: Somehow move keybindings to a central place.
-- And refactor to use utility functions
vim.keymap.set('n', "<S-Left>",  '<CMD>NavigatorLeft<CR>')
vim.keymap.set('n', "<S-Right>", '<CMD>NavigatorRight<CR>')
vim.keymap.set('n', "<S-Up>",    '<CMD>NavigatorUp<CR>')
vim.keymap.set('n', "<S-Down>",  '<CMD>NavigatorDown<CR>')
vim.keymap.set('n', "<C-\\>",    '<CMD>NavigatorPrevious<CR>')

vim.keymap.set('i', "<S-Left>",  '<C-c><CMD>NavigatorLeft<CR>')
vim.keymap.set('i', "<S-Right>", '<C-c><CMD>NavigatorRight<CR>')
vim.keymap.set('i', "<S-Up>",    '<C-c><CMD>NavigatorUp<CR>')
vim.keymap.set('i', "<S-Down>",  '<C-c><CMD>NavigatorDown<CR>')
vim.keymap.set('i', "<C-\\>",    '<C-c><CMD>NavigatorPrevious<CR>')
