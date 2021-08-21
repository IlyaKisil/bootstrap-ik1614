local saga = require 'lspsaga'
local default_quit_keys = {
    '<C-c>',
    '<ESC>',
    '<S-Up>',
    '<S-Down>',
    '<S-Right>',
    '<S-Left>',
}

saga.init_lsp_saga {
    use_saga_diagnostic_sign = false,
    max_preview_lines = 20,
    error_sign = '',
    warn_sign = '',
    hint_sign = '',
    infor_sign = '',
    dianostic_header_icon = '',
    definition_preview_icon = '',
    finder_definition_icon = '',
    finder_reference_icon = '',
    rename_prompt_prefix = '➤',
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
        exec = '<CR>'
    },
    code_action_keys = {
        quit = default_quit_keys,
        exec = '<CR>',
    },
    finder_action_keys = {
        quit = default_quit_keys,
        open = {'o', '<CR>'},
        vsplit = 'v',
        split = 's',
        -- FIXME: doesn't work :shrug:
        scroll_down = '<C-f>',
        scroll_up = '<C-k>',
    },
}
