--[[
=========================================================================================


Default keymaps that are set by LazyVim distro
* https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua

To delete default keymap use something like
  vim.keymap.del({ "n" }, "<space>-")

To override default keymap use
  vim.keymap.set(...)

To add/delete/override plugin specifc keymaps see
* https://www.lazyvim.org/configuration/plugins#%EF%B8%8F-adding--disabling-plugin-keymaps


=========================================================================================
-- ]]

local map = require("ik1614.functions.mapping")

--[[
=========================================================================================

REMOVE KEY MAPS DEFINED BY LazyVim

=========================================================================================
-- ]]

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

vim.keymap.del({ "n" }, "<leader>:")
vim.keymap.del({ "n" }, "<leader>.")
vim.keymap.del({ "n" }, "<leader>-")
vim.keymap.del({ "n" }, "<leader>|")
vim.keymap.del({ "n" }, "<leader>/")
vim.keymap.del({ "n" }, "<leader>`")
vim.keymap.del({ "n" }, "<leader>,")
vim.keymap.del({ "n" }, "<leader><space>")

vim.keymap.del({ "n" }, "<leader>l")
vim.keymap.del({ "n" }, "<leader>L")

vim.keymap.del({ "n" }, "<leader>e")
vim.keymap.del({ "n" }, "<leader>E")

vim.keymap.del({ "n" }, "<leader>fB")
vim.keymap.del({ "n" }, "<leader>fE")
vim.keymap.del({ "n" }, "<leader>fF")
vim.keymap.del({ "n" }, "<leader>fR")
vim.keymap.del({ "n" }, "<leader>fT")
vim.keymap.del({ "n" }, "<leader>fc")
vim.keymap.del({ "n" }, "<leader>fe")
vim.keymap.del({ "n" }, "<leader>ff")
vim.keymap.del({ "n" }, "<leader>fg")
vim.keymap.del({ "n" }, "<leader>fn")
vim.keymap.del({ "n" }, "<leader>fr")
vim.keymap.del({ "n" }, "<leader>ft")

vim.keymap.del({ "n" }, "<leader>gB")
vim.keymap.del({ "n" }, "<leader>gY")
vim.keymap.del({ "n" }, "<leader>gS")

vim.keymap.del({ "n" }, "<leader>qq")

vim.keymap.del({ "n" }, "<leader>S")
vim.keymap.del({ "n" }, "<leader>s/")
vim.keymap.del({ "n" }, "<leader>sB")
vim.keymap.del({ "n" }, "<leader>sG")
vim.keymap.del({ "n" }, "<leader>sM")
vim.keymap.del({ "n" }, "<leader>sW")
vim.keymap.del({ "n" }, "<leader>sb")
vim.keymap.del({ "n" }, "<leader>sg")
vim.keymap.del({ "n" }, "<leader>si")
vim.keymap.del({ "n" }, "<leader>sj")
vim.keymap.del({ "n" }, "<leader>sl")
vim.keymap.del({ "n" }, "<leader>sm")

vim.keymap.del({ "n" }, "<leader>K")
--[[
=========================================================================================

DISABLE DEFAULT KEY MAPS

=========================================================================================
-- ]]

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

--[[
=========================================================================================

ADD MY KEY MAPS

=========================================================================================
-- ]]
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
map:n({
  "<C-l>",
  ":nohlsearch<cr>:diffupdate<cr>:syntax sync fromstart<cr><c-l>",
  { desc = "Smarter redraw", silent = true },
})

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

map:n({
  "yd",
  function()
    local pos = vim.api.nvim_win_get_cursor(0)
    local line_num = pos[1] - 1 -- 0-indexed
    local line_text = vim.api.nvim_buf_get_lines(0, line_num, line_num + 1, false)[1]
    local diagnostics = vim.diagnostic.get(0, { lnum = line_num })
    if #diagnostics == 0 then
      vim.notify("No diagnostic found on this line", vim.log.levels.WARN)
      return
    end
    local message_lines = {}
    for _, d in ipairs(diagnostics) do
      for msg_line in d.message:gmatch("[^\n]+") do
        table.insert(message_lines, msg_line)
      end
    end
    local formatted = {}
    table.insert(formatted, "Line:\n" .. line_text .. "\n")
    table.insert(formatted, "Diagnostic on that line:\n" .. table.concat(message_lines, "\n"))
    vim.fn.setreg("+", table.concat(formatted, "\n\n"))
    vim.notify("Line and diagnostic copied to clipboard", vim.log.levels.INFO)
  end,
  { desc = "Yank line and [D]iagnostic to system clipboard" },
})

map:n({
  "<leader>cb",
  function()
    local file = vim.fn.expand("%")
    local first_line = vim.fn.getline(1)
    if not string.match(first_line, "^#!/") then
      vim.cmd("echo 'Not a script. Shebang line not found.'")
    else
      local escaped_file = vim.fn.shellescape(file) -- Properly escape the file name for shell commands
      vim.cmd(
        "silent !tmux split-window -v 'bash -c \""
          .. escaped_file
          .. "; echo; echo Press any key to exit...; read -n 1; exit\"'"
      )
    end
  end,
  { desc = "Bash, execute file in a TMUX pane" },
})

map:n({
  "<leader>cg",
  function()
    local file = vim.fn.expand("%")
    if not string.match(file, "%.go$") then
      vim.cmd("echo 'Not a Go file.'")
    else
      local file_dir = vim.fn.expand("%:p:h")
      -- local escaped_file = vim.fn.shellescape(file) -- Properly escape the file name for shell commands
      -- local command_to_run = "go run " .. escaped_file
      local command_to_run = "go run *.go"
      local cmd = "silent !tmux split-window -v 'cd "
        .. file_dir
        .. ' && echo "'
        .. command_to_run
        .. '\\n" && bash -c "'
        .. command_to_run
        .. "; echo; echo Press enter to exit...; read _\"'"
      vim.cmd(cmd)
    end
  end,
  { desc = "Golang, execute file in a TMUX pane" },
})

--[[
=========================================================================================

Swap keymaps

=========================================================================================
-- ]]

-- <leader>g...
map:n({
  "<leader>go",
  function()
    Snacks.gitbrowse({
      open = function(url)
        vim.fn.setreg("+", url)
      end,
      notify = false,
    })
  end,
  { expr = true, desc = "Git Browse (copy line ref)" },
})

map:v({
  "<leader>go",
  function()
    Snacks.gitbrowse({
      open = function(url)
        vim.fn.setreg("+", url)
      end,
      notify = false,
    })
  end,
  { expr = true, desc = "Git Browse (copy range ref)" },
})

map:n({
  "<leader>gO",
  function()
    Snacks.gitbrowse()
  end,
  { desc = "Git Browse (open line)" },
})

map:v({
  "<leader>gO",
  function()
    Snacks.gitbrowse()
  end,
  { desc = "Git Browse (open range)" },
})

map:n({
  "<leader>gl",
  function()
    Snacks.picker.git_branches()
  end,
  { desc = "Git Log Branches" },
})

map:n({
  "<leader>gC",
  function()
    Snacks.picker.git_log()
  end,
  { desc = "Git Commits" },
})
map:n({
  "<leader>gc",
  function()
    Snacks.picker.git_log_file()
  end,
  { desc = "Git Commits File" },
})

-- <leader>o...
map:n({
  "<leader>ob",
  "<cmd>NvimTreeFindFile<CR>zz",
  { desc = "Browser/Explorer" },
})

map:n({
  "<leader>os",
  function()
    Snacks.scratch.select()
  end,
  { desc = "Scratchpad Buffer" },
})

map:n({
  "<leader>ok",
  "<cmd>norm! K<cr>",
  { desc = "Keywordprg" },
})

-- <leader>f...
map:n({
  "<leader>ff",
  "<cmd>FzfLua git_files<cr>",
  { desc = "Find Files (git-files)" },
})

map:n({
  "<leader>fF",
  "<cmd>FzfLua files<cr>",
  { desc = "Find Files (fd)" },
})

map:n({
  "<leader>fr",
  "<cmd>FzfLua resume<cr>",
  { desc = "FZF Resume" },
})

-- <leader>s...
map:n({
  "<leader>sg",
  "<cmd>FzfLua grep_project<cr>",
  { desc = "Grep (git)" },
})

map:n({
  "<leader>sG",
  function()
    require("ik1614.functions.fzf-lua"):grep_no_ignore()
  end,
  { desc = "Grep (all)" },
})
