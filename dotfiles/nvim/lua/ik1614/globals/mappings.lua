vim.g.mapleader = ' '

vim.g.completion_confirm_key = ""

-- Helper function
local map = function (mode, lhs, rhs, opts)
    local options = {noremap = true, silent = true}
    if opts then options = vim.tbl_extend('force', options, opts) end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end


-- Mapping for autocompletion
-- map("i", "<CR>", "v:lua.completion_confirm()", {expr = true, noremap = true})
-- map("i", "<C-n>", "v:lua.next_complete_item()", {expr = true})
-- map("s", "<C-n>", "v:lua.next_complete_item()", {expr = true})
-- map("i", "<C-e>", "v:lua.previous_complete_item()", {expr = true})
-- map("s", "<C-e>", "v:lua.previous_complete_item()", {expr = true})
vim.cmd([[
  cnoremap <C-e> <C-p>
]])
-- Yes, this is bad, but for not so much with programmable keyboard where these
-- are one the home row.
-- NOTE: This breaks pattern match for command history
-- vim.cmd([[
--   cnoremap <UP> <C-p>
--   cnoremap <DOWN> <C-n>
-- ]])



-- Move within quickfix list
-- FIXME: resolve clash with LSP diagnostics
map('n', '<C-n>', ':Cnext<CR>')
map('n', '<C-e>', ':Cprev<CR>')
-- map('n', '<leader>n',  ':Cnext<CR>')
-- map('n', '<leader>e',  ':Cprev<CR>')
-- map('n', '<leader>qn', ':Cnext<CR>')
-- map('n', '<leader>qe', ':Cprev<CR>')
-- map('n', '<leader>qq', ':toggle quickfix list<CR>')


-- Move within location list
-- " Since location list is for current buffer, it kind makes sense to
-- " use local leader for mnemonic, although I'd prefer to have something
-- " that can be constantly pressed (similar to <C-n>)
map('n', '<localleader>n', ':Lnext<CR>')
map('n', '<localleader>e', ':Lprev<CR>')



-- Don't move cursor
map('n', '<Space>', '<NOP>')


-- Keep selection after tab adjust
map('v', '<', '<gv')
map('v', '>', '>gv')


-- Map (redraw screen) to also turn off search highlighting until the next search
map('n', '<C-l>', ':nohl<CR><C-L>')


-- When you paste over something send that content to 'the black hole register'
map('v', '<leader>p', '"_dP')


-- Convenience for applying macros
map('n', 'Q', '@q')


-- Movements between tabs
map('n', '<leader>q', ':tabclose<CR>')
map('n', '<S-TAB>',   ':tabprevious<CR>')
-- <tab> and <C-i> are the codes for for vim/nvim. So if we override, then won't be
-- able to use jumplist
-- map('n', '<TAB>',     ':tabnext<CR>')


-- Open URL on the current line in a web browser
map('n', '<leader>ow', ':call functions#OpenURL()<CR>')
map('v', '<leader>ow', ':call functions#OpenURL()<CR>')

-- Execute current line (vim/lua scripts)
map('n', '<leader>x', ':call functions#exec_current_line()<CR>')

-- By default it will extend highlighting till the next match.
-- Doesn't work very smooth
map('v', '*', ':call functions#visual_selection_search()<CR>//<C-R><c-o>')
map('v', '#', ':call functions#visual_selection_search()<CR>??<C-R><c-o>')


-- Move selection up and down. This will also respect indentation levels
map('v', 'J', ":m '>+1<CR>gv=gv")
map('v', 'K', ":m '<-2<CR>gv=gv")



-- Search mappings: These will make it so that going to the next one in a
-- search will center on the line it's found in.
map('n', 'n', 'nzzzv')
map('n', 'N', 'Nzzzv')


-- Same when moving up and down
map('n', '<C-d>', '<C-d>zz')
map('n', '<C-u>', '<C-u>zz')


-- Make Y consistent with C and D
map('n', 'Y', 'y$')

-- TODO: convert to lua native mappings
-- Move cursor through long soft-wrapped lines that doesn't break <count>
vim.cmd([[
  noremap <expr> k (v:count == 0 ? 'gk' : 'k')
  noremap <expr> j (v:count == 0 ? 'gj' : 'j')
]])


-- Add multiline movements to jumplist, so we can use <C-i> and <C-o>
vim.cmd([[
  nnoremap <expr> k (v:count > 1 ? "m'" . v:count : '') . 'gk'
  nnoremap <expr> j (v:count > 1 ? "m'" . v:count : '') . 'gj'
]])


-- Undo break points. When you type a very long line but then realise that you
-- want to undo something, these mappings will undo text until certain special
-- characters at a time
map('i', ',', ',<C-g>u')
map('i', '.', '.<C-g>u')
map('i', '!', '!<C-g>u')
map('i', '?', '?<C-g>u')
map('i', '"', '"<C-g>u')
map('i', '$', '$<C-g>u')
map('i', '[', '[<C-g>u')
map('i', ':', ':<C-g>u')
map('i', ';', ';<C-g>u')

-- Don't send add '{' and '}' to jump list
map('n', '}', ':<C-u>execute "keepjumps norm! " . v:count1 . "}"<CR>')
map('n', '{', ':<C-u>execute "keepjumps norm! " . v:count1 . "{"<CR>')


-- Mnemonic: T -> Telescope ...
map('n', '<leader>tt', ':Telescope<CR>')
map('n', '<leader>tq', ':Telescope quickfix<CR>')
map('n', '<leader>tr', ':Telescope resume<CR>')
map('n', '<leader>tn', ':Telescope neoclip<CR>')

-- Mnemonic: O -> Open ...
map('n', '<leader>od', ':GdiffInTab<CR>')
map('n', '<leader>ob', ':NvimTreeFindFile<CR>zz')
map('n', '<leader>ot', ':TodoTelescope<CR>')

-----------------------------------------------------------------------------------------
-- LSP
-----------------------------------------------------------------------------------------
-- Mnemonic: G -> Go To ...
map('n', '<leader>gr', ':Telescope lsp_references<CR>')
map('n', '<leader>gd', ':Telescope lsp_definitions<CR>')
-- map('n', '<leader>gd', '<Cmd>lua vim.lsp.buf.declaration()<CR>')
map('n', '<leader>gD', ':Telescope lsp_type_definitions<CR>')
map('n', '<leader>gi', ':Telescope lsp_implementations<CR>')
map('n', '<leader>ge', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>')
map('n', '<leader>gn', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>')

-- Mnemonic: S -> Show ...
map('n', '<leader>sa', ':Telescope lsp_code_actions<CR>')
map('v', '<leader>sa', ':Telescope lsp_range_code_actions<CR>')
map('n', '<leader>ss', ':Telescope lsp_document_symbols<CR>')
-- map('n', '<leader>sS', ':Telescope lsp_workspace_symbols query=') -- Works only with query
map('n', '<leader>sS', ':Telescope lsp_dynamic_workspace_symbols<CR>')
map('n', '<leader>sd', ':Telescope lsp_document_diagnostics<CR>')
map('n', '<leader>sD', ':Telescope lsp_workspace_diagnostics line_width=120<CR>')
map('n', '<leader>sl', ':lua vim.lsp.diagnostic.show_line_diagnostics()<CR>')


map('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>')
map('v', '<leader>rf', '<esc><cmd>lua require("ik1614.refactoring").refactors()<CR>', {expr=false})
map('n', 'K',          '<cmd>lua vim.lsp.buf.hover()<CR>')
map('n', '<C-k>',      '<cmd>lua vim.lsp.buf.signature_help()<CR>')
