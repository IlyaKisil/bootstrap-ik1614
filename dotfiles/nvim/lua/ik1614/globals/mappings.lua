vim.g.mapleader = ' '

-- Helper function
local map = function (mode, lhs, rhs, opts)
    local options = {noremap = true, silent = true}
    if opts then options = vim.tbl_extend('force', options, opts) end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

local t = function(str)
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

-- _G.next_complete_item = function()
--     if vim.fn.pumvisible() == 1 then
--         return t "<C-n>"
--     -- elseif vim.fn.call("vsnip#available", {1}) == 1 then
--     --     return t "<Plug>(vsnip-expand-or-jump)"
--     elseif check_back_space() then
--         return t "<C-n>"
--     else
--         return vim.fn['compe#complete']()
--     end
-- end
_G.previous_complete_item = function()
    if vim.fn.pumvisible() == 1 then
        return t "<C-p>"
    -- elseif vim.fn.call("vsnip#jumpable", {-1}) == 1 then
    --     return t "<Plug>(vsnip-jump-prev)"
    else
        return t "<C-e>"
    end
end


-- Mapping for autocompletion
-- On Colemak, I'm ok to use <C-n> for getting next complete item
-- NOTE: Mapping for command mode works, but it displays dots :shurg:
map("i", "<C-e>", "v:lua.previous_complete_item()", {expr = true})
map("s", "<C-e>", "v:lua.previous_complete_item()", {expr = true})
map("c", "<C-e>", "v:lua.previous_complete_item()", {expr = true})


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
map('v', 'x', ':call functions#visual_selection_search()<CR>??<C-R><c-o>')


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


