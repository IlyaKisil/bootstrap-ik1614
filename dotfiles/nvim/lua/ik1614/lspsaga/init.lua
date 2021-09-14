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


-- Mappings for LSP
-- map('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
-- map('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>')
-- map('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>')
-- map('n', 'gr', ':Lspsaga lsp_finder<CR>')
-- vim.cmd('nnoremap <silent> gi <cmd>lua vim.lsp.buf.implementation()<CR>')

-- map('n', '<leader>sa', ':Lspsaga code_action<CR>') -- Menmonic: Show action
-- map('v', '<leader>sa', ':<C-U>Lspsaga range_code_action<CR>') -- Menmonic: Show action

-- map('n', 'K', ':Lspsaga hover_doc<CR>')
-- map('n', '<leader>ss', ':Lspsaga signature_help<CR>') -- Menmonic: Show signature

-- map('n', '<leader>rn', ':Lspsaga rename<CR>') -- Menmonic: ReName

-- map('n', 'ge', ':Lspsaga diagnostic_jump_prev<CR>')
-- map('n', 'gn', ':Lspsaga diagnostic_jump_next<CR>')

-- Workaround for moving within suggested actions and reference finder
-- vim.cmd('autocmd FileType lspsagafinder,LspSagaCodeAction :nnoremap <buffer> <C-n> j')
-- vim.cmd('autocmd FileType lspsagafinder,LspSagaCodeAction :nnoremap <buffer> <C-e> k')

-- scroll up and down hover doc or scroll in definition preview
-- vim.cmd('nnoremap <silent> <C-f> <cmd>lua require(\'lspsaga.action\').smart_scroll_with_saga(1)<CR>')
-- vim.cmd('nnoremap <silent> <C-k> <cmd>lua require(\'lspsaga.action\').smart_scroll_with_saga(-1)<CR>')

