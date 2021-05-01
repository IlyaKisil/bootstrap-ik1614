local saga = require 'lspsaga'
local default_quit_keys = {
    '<C-c>',
    '<ESC>',
    '<S-Up>',
    '<S-Down>',
    '<S-Right>',
    '<S-Left>',
}
local default_quit_keys

vim.cmd([[
    nnoremap <silent> <C-f> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>
    nnoremap <silent> <C-f> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>
]])

saga.init_lsp_saga {
    use_saga_diagnostic_sign = false,
    error_sign = '',
    warn_sign = '',
    hint_sign = '',
    infor_sign = '',
    dianostic_header_icon = '',
    definition_preview_icon = '',
    finder_definition_icon = '',
    finder_reference_icon = '',
    code_action_icon = ' ',
    -- Sign appears in a gutter
    code_action_prompt = {
      enable = true,
      sign = true,
      sign_priority = 20,
      virtual_text = false,
    },
    rename_action_keys = {
        quit = default_quit_keys,
        exec = '<CR>'  -- quit can be a table
    },
    code_action_keys = {
        quit = default_quit_keys,
        exec = '<CR>',scroll_down = '<C-f>'
    },
    finder_action_keys = {
        quit = default_quit_keys,
        open = {'o', '<CR>'},
        vsplit = 'v',
        split = 's',
        scroll_down = '<C-f>'
    },
}

-- filetype=lspsagafinder
