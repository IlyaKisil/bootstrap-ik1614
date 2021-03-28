-- Helper function
local map = function (mode, lhs, rhs, opts)
    local options = {noremap = true, silent = true}
    if opts then options = vim.tbl_extend('force', options, opts) end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

vim.g.mapleader = ' '

-- Don't move cursor
map('n', '<Space>', '<NOP>')

-- Keep selection after tab adjust
map('v', '<', '<gv')
map('v', '>', '>gv')

-- Map (redraw screen) to also turn off search highlighting until the next search
map('n', '<C-l>', ':nohl<CR><C-L>')


-- " When you paste over something send that content to 'the black hole register'
map('v', '<leader>p', '"_dP')



-- " Convenience for applying macros
map('n', 'Q', '@q')

-- " Movements between tabs
map('n', '<leader>q', ':tabclose<CR>')
map('n', '<TAB>',     ':tabnext<CR>')
map('n', '<S-TAB>',   ':tabprevious<CR>')


-- " Open URL on the current line in a web browser
map('n', '<leader>ow', ':call functions#OpenURL()<CR>')
map('v', '<leader>ow', ':call functions#OpenURL()<CR>')

-- " Search mappings: These will make it so that going to the next one in a
-- " search will center on the line it's found in.
-- FIXME: looks like this is broken
map('n', 'n', 'nzzzv')
map('n', 'N', 'Nzzzv')

-- " Same when moving up and down
map('n', '<C-d>', '<C-d>zz')
map('n', '<C-u>', '<C-u>zz')

-- "make Y consistent with C and D
map('n', 'Y', 'y$')

-- TODO: convert to lua native mappings
-- " Move cursor through long soft-wrapped lines that doesn't break <count>
vim.cmd([[
  noremap <expr> k (v:count == 0 ? 'gk' : 'k')
  noremap <expr> j (v:count == 0 ? 'gj' : 'j')
]])

-- " Use <C-k> to go up within a completion menu. For going down, use default
-- " binding <C-n>, which is convenient with Colemak layout
vim.cmd([[
  inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<Up>"
  cnoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<Up>"
]])


-- " Loop through quickfix and locations lists
vim.cmd([[
  command! Cnext try | cnext | catch | cfirst | catch | endtry
  command! Cprev try | cprev | catch | clast  | catch | endtry
  command! Lnext try | lnext | catch | lfirst | catch | endtry
  command! Lprev try | lprev | catch | llast  | catch | endtry
]])

-- " Can't use <C-p> as it is reserved for 'fzf'
-- " Consider using <C-m>, if you reserve <C-k> for pane movement
vim.cmd([[
  map <C-k> :Cprev<CR>
  map <C-n> :Cnext<CR>
]])

-- " Since location list is for current buffer, it kind makes sense to
-- " use local leader for mnemonic, although I'd prefer to have something
-- " that can be constantly pressed (similar to <C-n>)
vim.cmd([[
  map <localleader>k :Lprev<CR>
  map <localleader>n :Lnext<CR>
]])

