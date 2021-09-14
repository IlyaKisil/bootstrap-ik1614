require('bqf').setup({
    auto_enable = true,
    preview = {
        win_height = 25,
        win_vheight = 25,
        delay_syntax = 80,
        border_chars = {'┃', '┃', '━', '━', '┏', '┓', '┗', '┛', '█'}
    },
    func_map = {
        -- vsplit = '',
        -- ptogglemode = 'z,',
        -- stoggleup = '',
        -- prevfile = '<leader>qp',
        -- nextfile = '<leader>qn',
        pscrollup = '<C-e>',
        pscrolldown = '<C-n>',
        fzffilter = '<leader>f',  -- Enter 'fzf' mode
    },
    -- filter = {
    --     fzf = {
    --         -- action_for = {['ctrl-v'] = 'split'},
    --         extra_opts = {'--bind', 'ctrl-o:toggle-all'} -- I set it as a part of shell config
    --     }
    -- }
})
