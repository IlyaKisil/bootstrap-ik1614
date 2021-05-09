vim.g.mapleader = ' '

vim.g.completion_confirm_key = ""
local npairs = require('nvim-autopairs')

-- Helper function
local map = function (mode, lhs, rhs, opts)
    local options = {noremap = true, silent = true}
    if opts then options = vim.tbl_extend('force', options, opts) end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

local escape_replace = function(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col('.') - 1
    if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        return true
    else
        return false
    end
end

_G.next_complete_item = function()
    if vim.fn.pumvisible() == 1 then
        return escape_replace "<C-n>"
    -- elseif vim.fn.call("vsnip#available", {1}) == 1 then
    --     return escape_replace "<Plug>(vsnip-expand-or-jump)"
    elseif check_back_space() then
        return escape_replace "<C-n>"
    else
        return vim.fn['compe#complete']()
    end
end

_G.previous_complete_item = function()
    if vim.fn.pumvisible() == 1 then
        return escape_replace "<C-p>"
    -- elseif vim.fn.call("vsnip#jumpable", {-1}) == 1 then
    --     return escape_replace "<Plug>(vsnip-jump-prev)"
    else
        return escape_replace "<C-e>"
    end
end

_G.completion_confirm = function()
  if vim.fn.pumvisible() ~= 0  then
    if vim.fn.complete_info()["selected"] ~= -1 then
      return vim.fn["compe#confirm"](npairs.esc("<c-r>"))
    else
      return npairs.esc("<cr>")
    end
  else
    return npairs.autopairs_cr()
  end
end

_G.trigger_completion = function()
  return vim.fn["compe#complete"]()
end


-- Mapping for autocompletion
map("i", "<CR>", "v:lua.completion_confirm()", {expr = true, noremap = true})
map("i", "<C-n>", "v:lua.next_complete_item()", {expr = true})
map("s", "<C-n>", "v:lua.next_complete_item()", {expr = true})
map("i", "<C-e>", "v:lua.previous_complete_item()", {expr = true})
map("s", "<C-e>", "v:lua.previous_complete_item()", {expr = true})
vim.cmd([[
  cnoremap <C-e> <C-p>
]])

map("i", "<C-Space>", "v:lua.trigger_completion()", {expr = true})



-- Move within quickfix list
-- FIXME: resolve clash with LSP diagnostics
map('n', '<C-n>', ':Cnext<CR>')
map('n', '<C-e>', ':Cprev<CR>')


-- Move within location list
-- " Since location list is for current buffer, it kind makes sense to
-- " use local leader for mnemonic, although I'd prefer to have something
-- " that can be constantly pressed (similar to <C-n>)
map('n', '<localleader>n', ':Lnext<CR>')
map('n', '<localleader>e', ':Lprev<CR>')

-- Mappings for LSP
map('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
map('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>')
-- map('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>')
map('n', 'gr', ':Lspsaga lsp_finder<CR>')
-- vim.cmd('nnoremap <silent> gi <cmd>lua vim.lsp.buf.implementation()<CR>')

map('n', '<leader>sa', ':Lspsaga code_action<CR>') -- Menmonic: Show action
map('v', '<leader>sa', ':<C-U>Lspsaga range_code_action<CR>') -- Menmonic: Show action

map('n', 'K', ':Lspsaga hover_doc<CR>')
map('n', '<leader>ss', ':Lspsaga signature_help<CR>') -- Menmonic: Show signature

map('n', '<leader>rn', ':Lspsaga rename<CR>') -- Menmonic: ReName

map('n', 'ge', ':Lspsaga diagnostic_jump_prev<CR>')
map('n', 'gn', ':Lspsaga diagnostic_jump_next<CR>')

-- Workaround for moving within suggested actions and reference finder
vim.cmd('autocmd FileType lspsagafinder,LspSagaCodeAction :nnoremap <buffer> <C-n> j')
vim.cmd('autocmd FileType lspsagafinder,LspSagaCodeAction :nnoremap <buffer> <C-e> k')

-- scroll up and down hover doc or scroll in definition preview
-- vim.cmd('nnoremap <silent> <C-f> <cmd>lua require(\'lspsaga.action\').smart_scroll_with_saga(1)<CR>')
-- vim.cmd('nnoremap <silent> <C-k> <cmd>lua require(\'lspsaga.action\').smart_scroll_with_saga(-1)<CR>')


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

map('n', '<leader>t', ':TSHighlightCapturesUnderCursor<CR>')

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


