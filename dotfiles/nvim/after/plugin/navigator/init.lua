local f = require("ik1614.functions")
local plugin = f.utils:load_plugin("Navigator")

if not plugin then
  return
end

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
f.mapping:n({"<S-Left>",  '<CMD>NavigatorLeft<CR>'})
f.mapping:n({"<S-Right>", '<CMD>NavigatorRight<CR>'})
f.mapping:n({"<S-Up>",    '<CMD>NavigatorUp<CR>'})
f.mapping:n({"<S-Down>",  '<CMD>NavigatorDown<CR>'})
f.mapping:n({"<C-\\>",    '<CMD>NavigatorPrevious<CR>'})

f.mapping:i({"<S-Left>",  '<C-c><CMD>NavigatorLeft<CR>'})
f.mapping:i({"<S-Right>", '<C-c><CMD>NavigatorRight<CR>'})
f.mapping:i({"<S-Up>",    '<C-c><CMD>NavigatorUp<CR>'})
f.mapping:i({"<S-Down>",  '<C-c><CMD>NavigatorDown<CR>'})
f.mapping:i({"<C-\\>",    '<C-c><CMD>NavigatorPrevious<CR>'})
