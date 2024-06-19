local utils = require("ik1614.functions.utils")
local plugin = utils:load_plugin("bqf")

if not plugin then
  return
end

plugin.setup({
    auto_enable = true,
    preview = {
        auto_preview = false,  -- Having it on by default is a little bit disorienting
        win_height = 25,
        win_vheight = 25,
        delay_syntax = 80,
        border_chars = {'┃', '┃', '━', '━', '┏', '┓', '┗', '┛', '█'}
    },
    func_map = {
        prevfile = 'ge', -- Need this so not to override <C-n> and <C-e> which is a general mapping for jumping through quickfix
        nextfile = 'gn', -- Need this so not to override <C-n> and <C-e> which is a general mapping for jumping through quickfix
        ptoggleitem = 'P',  -- toggle preview for an item of quickfix list
        ptoggleauto = 'p',  -- toggle preview for all items of quickfix list
        ptogglemode = 'za', -- toggle preview window between normal and max size. Similar to toggle text fold
        pscrollorig = 'zz', -- scroll back to original position in preview window. Similar to centering cursor position
        pscrollup = '<C-u>',
        pscrolldown = '<C-d>',
        fzffilter = '<leader>f',  -- Enter 'fzf' mode
    },
})
