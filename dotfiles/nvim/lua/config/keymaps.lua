-- ======================================================================================
--
-- Default keymaps that are set by LazyVim distro
-- * https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
--
-- To delete default keymap use something like
--   vim.keymap.del({ "n" }, "<space>-")
--
-- To override default keymap use
--   vim.keymap.set(...)
--
-- To add/delete/override plugin specifc keymaps see
-- * https://www.lazyvim.org/configuration/plugins#%EF%B8%8F-adding--disabling-plugin-keymaps
--
-- ======================================================================================

local map = require("ik1614.functions.mapping")

-- ======================================================================================
--
-- REMOVE KEY MAPS DEFINED BY LazyVim
--
-- ======================================================================================

-- NOTE: These are reserved for system wide movement of windows
vim.keymap.del({ "n" }, "<C-Up>")
vim.keymap.del({ "n" }, "<C-Down>")
vim.keymap.del({ "n" }, "<C-Left>")
vim.keymap.del({ "n" }, "<C-Right>")

-- NOTE: I don't use QWERTY anyway. Was used for moving between windows/splits
vim.keymap.del({ "n" }, "<C-h>")
vim.keymap.del({ "n" }, "<C-j>")
vim.keymap.del({ "n" }, "<C-k>")
vim.keymap.del({ "n" }, "<C-l>")

-- NOTE: I don't use QWERTY anyway: Was used for moving a line/selection up/down
vim.keymap.del({ "n" }, "<A-j>")
vim.keymap.del({ "n" }, "<A-k>")
vim.keymap.del({ "v" }, "<A-k>")
vim.keymap.del({ "v" }, "<A-j>")
vim.keymap.del({ "i" }, "<A-k>")
vim.keymap.del({ "i" }, "<A-j>")

vim.keymap.del({ "n" }, "<leader>-")
vim.keymap.del({ "n" }, "<leader>|")
vim.keymap.del({ "n" }, "<leader>/")
vim.keymap.del({ "n" }, "<leader>`")
vim.keymap.del({ "n" }, "<leader>,")
vim.keymap.del({ "n" }, "<leader>l")
vim.keymap.del({ "n" }, "<leader>L")
vim.keymap.del({ "n" }, "<leader>e")
vim.keymap.del({ "n" }, "<leader>E")
vim.keymap.del({ "n" }, "<leader>fB")
vim.keymap.del({ "n" }, "<leader>ft")
vim.keymap.del({ "n" }, "<leader>fT")
vim.keymap.del({ "n" }, "<leader>fr")

-- ======================================================================================
--
-- DISABLE DEFAULT KEY MAPS
--
-- ======================================================================================

map:i({ "<C-u>", "<NOP>", { desc = "Disabled default: Delete all entered characters in the current line:" } })
map:i({ "<C-d>", "<NOP>", { desc = "Disabled default: Delete one shiftwidth of indent in the current line" } })
map:i({ "<C-q>", "<NOP>", { desc = "Disabled default: Same as CTRL-V, i.e. insert next non-digit literally " } })
map:i({ "<C-a>", "<NOP>", { desc = "Disabled default: Insert previously inserted text" } })
map:i({ "<C-e>", "<NOP>", { desc = "Disabled default: Insert the character which is below the cursor" } })
map:i({ "<C-n>", "<NOP>", { desc = "Disabled default: Find next match for keyword in front of the cursor" } })
map:i({ "<C-y>", "<NOP>", { desc = "Disabled default: Copy character above the cursor" } })
map:i({ "<C-j>", "<NOP>", { desc = "Disabled default: Create new line" } })
map:i({ "<C-p>", "<NOP>", { desc = "Disabled default: Find previous match for keyword in front of the cursor" } })
map:i({ "<C-l>", "<NOP>", { desc = "Disabled default: Should be safe" } })
map:i({ "<C-k>", "<NOP>", { desc = "Disabled default: Enter digraph" } })
map:i({ "<C-o>", "<NOP>", { desc = "Disabled default: Go into normal mode for one command and back to insert mode" } })
map:i({ "<C-t>", "<NOP>", { desc = "Disabled default: Insert one shiftwidth of indent in current line" } })
map:n({ "<C-e>", "<NOP>", { desc = "Disabled default: Scroll window [count] lines downwards in the buffer" } })

-- ======================================================================================
--
-- ADD MY KEY MAPS
--
-- ======================================================================================
map:n({ "<C-d>", "<C-d>zz" })
map:n({ "<C-u>", "<C-u>zz" })

-- Continious scroll of the quickfix items
map:n({
  "<C-n>",
  function()
    local ok = pcall(vim.cmd.cnext)
    if not ok then
      pcall(vim.cmd.cfirst)
    end
  end,
  { desc = "Goto next quickfix item" },
})
map:n({
  "<C-p>",
  function()
    local ok = pcall(vim.cmd.cprev)
    if not ok then
      pcall(vim.cmd.clast)
    end
  end,
  { desc = "Goto prev quickfix item" },
})

-- https://github.com/mhinz/vim-galore?tab=readme-ov-file#saner-command-line-history
map:c({
  "<C-n>",
  function()
    return vim.fn.wildmenumode() == 1 and "<C-n>" or "<Down>"
  end,
  { expr = true, desc = "Navigate down in cmdline or wildmenu" },
})
map:c({
  "<C-p>",
  function()
    return vim.fn.wildmenumode() == 1 and "<C-p>" or "<Up>"
  end,
  { expr = true, desc = "Navigate up in cmdline or wildmenu" },
})

-- https://github.com/mhinz/vim-galore?tab=readme-ov-file#saner-ctrl-l
map:n({ "<C-l>", ":nohlsearch<cr>:diffupdate<cr>:syntax sync fromstart<cr><c-l>", { desc = "Smarter redraw" } })

-- https://github.com/mhinz/vim-galore?tab=readme-ov-file#saner-behavior-of-n-and-n
-- * Center result
-- * 'n' to always search forward
-- * 'N' to always search backward
map:n({ "n", "'Nn'[v:searchforward].'zzzv'", { expr = true, desc = "Next Search Result" } })
map:n({ "N", "'nN'[v:searchforward].'zzzv'", { expr = true, desc = "Prev Search Result" } })

map:n({ "Q", "@q", { desc = "Convenience for applying macros" } })
map:n({ "Y", "y$", { desc = "Make Y consistent with C and D" } })
map:n({ "J", "mzJ`z", { desc = "Concatenate lines but keep cursor in the original position" } })

-- Keep selection after tab adjust
map:v({ "<", "<gv" })
map:v({ ">", ">gv" })

-- Move selection up and down. This will also respect indentation levels
map:v({ "J", ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv" })
map:v({ "K", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv" })

-- Don't send add '{' and '}' to jump list
map:n({ "}", ':<C-u>execute "keepjumps norm! " . v:count1 . "}"<CR>' })
map:n({ "{", ':<C-u>execute "keepjumps norm! " . v:count1 . "{"<CR>' })

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
map:n({ "k", add_multiline_movevment_to_jumplist("k"), { expr = true } })

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
