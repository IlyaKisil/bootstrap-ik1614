-- I know, I know, arrows are bad, but I have a custom keybord where I've put them
-- on the home row, whereas 'J' and 'K' are quite painful on Colemak layout.

local f = require("ik1614.functions")

vim.g.mapleader = ' '

vim.g.completion_confirm_key = ""

-- Loop through completion options in the command line
f.mapping:c({'<C-e>', '<C-p>'})


-- Move within quickfix list
-- FIXME: resolve clash with LSP diagnostics
f.mapping:n({'<C-n>', ':Cnext<CR>'})
f.mapping:n({'<C-e>', ':Cprev<CR>'})
-- f.mapping:nmap({'<leader>n',  ':Cnext<CR>'})
-- f.mapping:nmap({'<leader>e',  ':Cprev<CR>'})
-- f.mapping:nmap({'<leader>qn', ':Cnext<CR>'})
-- f.mapping:nmap({'<leader>qe', ':Cprev<CR>'})
-- f.mapping:nmap({'<leader>qq', ':toggle quickfix list<CR>'})


-- Move within location list
-- " Since location list is for current buffer, it kind makes sense to
-- " use local leader for mnemonic, although I'd prefer to have something
-- " that can be constantly pressed (similar to <C-n>)
f.mapping:n({'<localleader>n', ':Lnext<CR>'})
f.mapping:n({'<localleader>e', ':Lprev<CR>'})


-- Don't move cursor
f.mapping:v({'<Space>', '<NOP>'})


-- Don't start default completion. All completion related tasks are handled
-- by 'nvim-cmp' and 'luasnip' plugins and mappings are defined there. Also
-- reserve some mappings for the insert mode, since I don't use these anyway.
f.mapping:i({'<C-u>', '<NOP>'}) -- Default: Delete all entered characters in the current line
f.mapping:i({'<C-d>', '<NOP>'}) -- Default: Delete one shiftwidth of indent in the current line
f.mapping:i({'<C-q>', '<NOP>'}) -- Default: Same as CTRL-V, i.e. insert next non-digit literally (unless used for terminal control flow)
f.mapping:i({'<C-a>', '<NOP>'}) -- Default: Insert previously inserted text
f.mapping:i({'<C-e>', '<NOP>'}) -- Default: Insert the character which is below the cursor
f.mapping:i({'<C-n>', '<NOP>'}) -- Default: Find next match for keyword in front of the cursor
f.mapping:i({'<C-y>', '<NOP>'}) -- Default: Copy character above the cursor
f.mapping:i({'<C-j>', '<NOP>'}) -- Default: Create new line
f.mapping:i({'<C-p>', '<NOP>'}) -- Default: Find previous match for keyword in front of the cursor
f.mapping:i({'<C-l>', '<NOP>'}) -- Default: Should be safe
f.mapping:i({'<C-k>', '<NOP>'}) -- Default: Enter digraph
f.mapping:i({'<C-o>', '<NOP>'}) -- Default: Go into normal mode for one command and then back to insert mode
f.mapping:i({'<C-t>', '<NOP>'}) -- Default: Insert one shiftwidth of indent in current line


-- Keep selection after tab adjust
f.mapping:v({'<', '<gv'})
f.mapping:v({'>', '>gv'})


-- Map (redraw screen) to also turn off search highlighting until the next search
f.mapping:n({'<C-l>', ':nohl<CR><C-L>'})


-- When you paste over something send that content to 'the black hole register'
f.mapping:v({'<leader>p', '"_dP'})


-- Convenience for applying macros
f.mapping:n({'Q', '@q'})


-- Movements between tabs
f.mapping:n({'<leader>q', ':tabclose<CR>'})
f.mapping:n({'<S-TAB>',   ':tabprevious<CR>'})
-- <tab> and <C-i> are the codes for for vim/nvim. So if we override, then won't be
-- able to use jumplist
-- TODO: Neovim 0.7 added support to distiguish between them. So need to dig in
-- map('n', '<TAB>',     ':tabnext<CR>')

-- By default it will extend highlighting till the next match.
-- Doesn't work very smooth
f.mapping:v({'*', ':call functions#visual_selection_search()<CR>//<C-R><c-o>'})
f.mapping:v({'#', ':call functions#visual_selection_search()<CR>??<C-R><c-o>'})


-- Move selection up and down. This will also respect indentation levels
f.mapping:v({'J', ":m '>+1<CR>gv=gv"})
f.mapping:v({'K', ":m '<-2<CR>gv=gv"})


-- Search mappings: These will make it so that going to the next one in a
-- search will center on the line it's found in.
f.mapping:n({'n', 'nzzzv'})
f.mapping:n({'N', 'Nzzzv'})


-- Same when moving up and down
f.mapping:n({'<C-d>', '<C-d>zz'})
f.mapping:n({'<C-u>', '<C-u>zz'})


-- Make Y consistent with C and D
f.mapping:n({'Y', 'y$'})


-- Concatenate lines but keep cursor in the original position
f.mapping:n({"J", "mzJ`z"})


-- Move cursor through long soft-wrapped lines that doesn't break <count>
local function walk_through_soft_warpped(key)
  local function wrap()
    return vim.v.count == 0 and 'g' .. key or key
  end
  return wrap
end
f.mapping:n({"j",      walk_through_soft_warpped("j"), {expr=true}})
f.mapping:n({"<down>", walk_through_soft_warpped("j"), {expr=true}})
f.mapping:n({"k",      walk_through_soft_warpped("k"), {expr=true}})
f.mapping:n({"<up>",   walk_through_soft_warpped("k"), {expr=true}})


-- Add multiline movements to jumplist, so we can use <C-i> and <C-o>
local function add_multiline_movevment_to_jumplist(key)
  local function wrap()
    local movement = 'g' .. key
    if vim.v.count > 1 then
      movement = "m'" .. vim.v.count .. movement
    end
    return movement
  end
  return wrap
end
f.mapping:n({"j",      add_multiline_movevment_to_jumplist("j"), {expr=true}})
f.mapping:n({"<down>", add_multiline_movevment_to_jumplist("j"), {expr=true}})
f.mapping:n({"k",      add_multiline_movevment_to_jumplist("k"), {expr=true}})
f.mapping:n({"<up>",   add_multiline_movevment_to_jumplist("k"), {expr=true}})


-- Undo break points. When you type a very long line but then realise that you
-- want to undo something, these mappings will undo text until certain special
-- characters at a time
f.mapping:i({',', ',<C-g>u'})
f.mapping:i({'.', '.<C-g>u'})
f.mapping:i({'!', '!<C-g>u'})
f.mapping:i({'?', '?<C-g>u'})
f.mapping:i({'"', '"<C-g>u'})
f.mapping:i({'$', '$<C-g>u'})
f.mapping:i({'[', '[<C-g>u'})
f.mapping:i({':', ':<C-g>u'})
f.mapping:i({';', ';<C-g>u'})


-- Don't send add '{' and '}' to jump list
f.mapping:n({'}', ':<C-u>execute "keepjumps norm! " . v:count1 . "}"<CR>'})
f.mapping:n({'{', ':<C-u>execute "keepjumps norm! " . v:count1 . "{"<CR>'})

f.mapping:n({"<C-p>", ":<C-u>FzfLua git_files<CR>"})
