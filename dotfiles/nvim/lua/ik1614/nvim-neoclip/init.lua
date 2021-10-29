-- FIXME: For some reason this still doesn't work :cry:
-- On exit from, it pushes yanks from a current session to the DB.
-- But it doesn't load them upon new session :shrug:
-- Also, when it pushes new yanks it removes old ones. :shrug:
require('neoclip').setup({
    history = 1000,
    enable_persistant_history = true,
    db_path = vim.fn.stdpath("data") .. "/databases/neoclip.sqlite3",
    filter = nil,
    preview = true,
    default_register = '"',
    content_spec_column = true,
    on_paste = {
        set_reg = false,
    },
    keys = {
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
})