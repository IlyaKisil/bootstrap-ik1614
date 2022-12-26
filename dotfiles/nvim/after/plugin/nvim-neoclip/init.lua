local f = require("ik1614.functions")
local plugin_name = "neoclip"

if not f.utils:plugin_installed(plugin_name) then
  return
end

local plugin = require(plugin_name)

-- FIXME: For some reason this still doesn't work :cry:
-- On exit from, it pushes yanks from a current session to the DB.
-- But it doesn't load them upon new session :shrug:
-- Also, when it pushes new yanks it removes old ones. :shrug:
plugin.setup({
    history = 1000,
    enable_persistent_history = true,
    db_path = DATA_PATH .. "/databases/neoclip.sqlite3",
    filter = nil,
    preview = true,
    default_register = '"',
    content_spec_column = true,
    on_paste = {
        set_reg = false,
    },
    keys = {
        telescope = {
            i = {
                select = '<CR>',  -- NOTE: note sure what this does
                paste = '<C-p>',
                paste_behind = '<C-k>',
                custom = {},
            },
            n = {
                select = '<CR>',
                paste = 'p',
                paste_behind = 'P',
                custom = {},
            },
        },
        fzf = {
          select = 'default',
          paste = 'ctrl-p',
          paste_behind = 'ctrl-k',
          custom = {},
        },
    },
})
