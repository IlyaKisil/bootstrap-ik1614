-- I know, I know, arrows are bad, but I have a custom keybord where I've put them
-- on the home row, whereas 'J' and 'K' are quite painful on Colemak layout.

local map = require("ik1614.functions.mapping")

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.g.completion_confirm_key = ""

-- Loop through completion options in the command line
map:c({ "<C-e>", "<C-p>" })

-- Move within quickfix list
-- FIXME: resolve clash with LSP diagnostics
map:n({ "<C-n>", ":Cnext<CR>" })
map:n({ "<C-e>", ":Cprev<CR>" })
-- map:nmap({'<leader>n',  ':Cnext<CR>'})
-- map:nmap({'<leader>e',  ':Cprev<CR>'})
-- map:nmap({'<leader>qn', ':Cnext<CR>'})
-- map:nmap({'<leader>qe', ':Cprev<CR>'})
-- map:nmap({'<leader>qq', ':toggle quickfix list<CR>'})

-- Move within location list
-- " Since location list is for current buffer, it kind makes sense to
-- " use local leader for mnemonic, although I'd prefer to have something
-- " that can be constantly pressed (similar to <C-n>)
-- map:n({'<localleader>n', ':Lnext<CR>'})
-- map:n({'<localleader>e', ':Lprev<CR>'})

-- Don't move cursor
map:v({ "<Space>", "<NOP>" })

-- Don't start default completion. All completion related tasks are handled
-- by 'nvim-cmp' and 'luasnip' plugins and mappings are defined there. Also
-- reserve some mappings for the insert mode, since I don't use these anyway.
map:i({ "<C-u>", "<NOP>" }) -- Default: Delete all entered characters in the current line
map:i({ "<C-d>", "<NOP>" }) -- Default: Delete one shiftwidth of indent in the current line
map:i({ "<C-q>", "<NOP>" }) -- Default: Same as CTRL-V, i.e. insert next non-digit literally (unless used for terminal control flow)
map:i({ "<C-a>", "<NOP>" }) -- Default: Insert previously inserted text
map:i({ "<C-e>", "<NOP>" }) -- Default: Insert the character which is below the cursor
map:i({ "<C-n>", "<NOP>" }) -- Default: Find next match for keyword in front of the cursor
map:i({ "<C-y>", "<NOP>" }) -- Default: Copy character above the cursor
map:i({ "<C-j>", "<NOP>" }) -- Default: Create new line
map:i({ "<C-p>", "<NOP>" }) -- Default: Find previous match for keyword in front of the cursor
map:i({ "<C-l>", "<NOP>" }) -- Default: Should be safe
map:i({ "<C-k>", "<NOP>" }) -- Default: Enter digraph
map:i({ "<C-o>", "<NOP>" }) -- Default: Go into normal mode for one command and then back to insert mode
map:i({ "<C-t>", "<NOP>" }) -- Default: Insert one shiftwidth of indent in current line

-- Keep selection after tab adjust
map:v({ "<", "<gv" })
map:v({ ">", ">gv" })

-- Map (redraw screen) to also turn off search highlighting until the next search
map:n({ "<C-l>", ":nohl<CR><C-L>" })

-- When you paste over something send that content to 'the black hole register'
map:v({ "<leader>p", '"_dP' })

-- Convenience for applying macros
map:n({ "Q", "@q" })

-- Movements between tabs
map:n({ "<leader>q", ":tabclose<CR>" })
map:n({ "<S-TAB>", ":tabprevious<CR>" })
-- <tab> and <C-i> are the codes for for vim/nvim. So if we override, then won't be
-- able to use jumplist
-- TODO: Neovim 0.7 added support to distiguish between them. So need to dig in
-- map('n', '<TAB>',     ':tabnext<CR>')

-- By default it will extend highlighting till the next match.
-- Doesn't work very smooth
map:v({ "*", ":call functions#visual_selection_search()<CR>//<C-R><c-o>" })
map:v({ "#", ":call functions#visual_selection_search()<CR>??<C-R><c-o>" })

-- Move selection up and down. This will also respect indentation levels
map:v({ "J", ":m '>+1<CR>gv=gv" })
map:v({ "K", ":m '<-2<CR>gv=gv" })

-- Search mappings: These will make it so that going to the next one in a
-- search will center on the line it's found in.
map:n({ "n", "nzzzv" })
map:n({ "N", "Nzzzv" })

-- Same when moving up and down
map:n({ "<C-d>", "<C-d>zz" })
map:n({ "<C-u>", "<C-u>zz" })

-- Make Y consistent with C and D
map:n({ "Y", "y$" })

-- Concatenate lines but keep cursor in the original position
map:n({ "J", "mzJ`z" })

-- Move cursor through long soft-wrapped lines that doesn't break <count>
local function walk_through_soft_warpped(key)
  local function wrap()
    return vim.v.count == 0 and "g" .. key or key
  end
  return wrap
end
map:n({ "j", walk_through_soft_warpped("j"), { expr = true } })
map:n({ "<down>", walk_through_soft_warpped("j"), { expr = true } })
map:n({ "k", walk_through_soft_warpped("k"), { expr = true } })
map:n({ "<up>", walk_through_soft_warpped("k"), { expr = true } })

-- Add multiline movements to jumplist, so we can use <C-i> and <C-o>
local function add_multiline_movevment_to_jumplist(key)
  local function wrap()
    local movement = "g" .. key
    if vim.v.count > 1 then
      movement = "m'" .. vim.v.count .. movement
    end
    return movement
  end
  return wrap
end
map:n({ "j", add_multiline_movevment_to_jumplist("j"), { expr = true } })
map:n({ "<down>", add_multiline_movevment_to_jumplist("j"), { expr = true } })
map:n({ "k", add_multiline_movevment_to_jumplist("k"), { expr = true } })
map:n({ "<up>", add_multiline_movevment_to_jumplist("k"), { expr = true } })

-- Undo break points. When you type a very long line but then realise that you
-- want to undo something, these mappings will undo text until certain special
-- characters at a time
map:i({ ",", ",<C-g>u" })
map:i({ ".", ".<C-g>u" })
map:i({ "!", "!<C-g>u" })
map:i({ "?", "?<C-g>u" })
map:i({ '"', '"<C-g>u' })
map:i({ "$", "$<C-g>u" })
map:i({ "[", "[<C-g>u" })
map:i({ ":", ":<C-g>u" })
map:i({ ";", ";<C-g>u" })

-- Don't send add '{' and '}' to jump list
map:n({ "}", ':<C-u>execute "keepjumps norm! " . v:count1 . "}"<CR>' })
map:n({ "{", ':<C-u>execute "keepjumps norm! " . v:count1 . "{"<CR>' })
