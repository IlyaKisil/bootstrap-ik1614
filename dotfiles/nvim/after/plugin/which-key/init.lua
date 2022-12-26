local utils = require("ik1614.functions.utils")
local plugin_name = "which-key"

if not utils:plugin_installed(plugin_name) then
    return
end

local plugin = require(plugin_name)

plugin.setup(
  {
    -- plugins = {
    --   marks = true, -- shows a list of your marks on ' and `
    --   registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    --   spelling = {
    --     enabled = false, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
    --     suggestions = 20, -- how many suggestions should be shown in the list?
    --   },
    --   -- the presets plugin, adds help for a bunch of default keybindings in Neovim
    --   -- No actual key bindings are created
    --   presets = {
    --     operators = true, -- adds help for operators like d, y, ... and registers them for motion / text object completion
    --     motions = true, -- adds help for motions
    --     text_objects = true, -- help for text objects triggered after entering an operator
    --     windows = true, -- default bindings on <c-w>
    --     nav = true, -- misc bindings to work with windows
    --     z = true, -- bindings for folds, spelling and others prefixed with z
    --     g = true, -- bindings for prefixed with g
    --   },
    -- },
    -- -- add operators that will trigger motion and text object completion
    -- -- to enable all native operators, set the preset / operators plugin above
    -- operators = { gc = "Comments" },
    -- key_labels = {
    --   -- override the label used to display some keys. It doesn't effect WK in any other way.
    --   -- For example:
    --   -- ["<space>"] = "SPC",
    --   -- ["<cr>"] = "RET",
    --   -- ["<tab>"] = "TAB",
    -- },
    window = {
      border = "single", -- none, single, double, shadow
      margin =  { 0, 0, 0, 0 }, -- extra window margin  [top, right, bottom, left]
      padding = { 0, 0, 0, 0 }, -- extra window padding [top, right, bottom, left]
    },
    layout = {
      height = { min = 10, max = 10 }, -- min and max height of the columns
      width = { min = 20, max = 50 }, -- min and max width of the columns
      spacing = 3, -- spacing between columns
      align = "left", -- align columns left, center or right
    },
    -- ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label
    -- hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ "}, -- hide mapping boilerplate
    -- show_help = true, -- show help message on the command line when the popup is visible
    -- triggers = "auto", -- automatically setup triggers
    -- triggers = {"<leader>"} -- or specify a list manually
    -- triggers_blacklist = {
    --   -- list of mode / prefixes that should never be hooked by WhichKey
    --   -- this is mostly relevant for key maps that start with a native binding
    --   -- most people should not need to change this
    --   i = { "j", "k" },
    --   v = { "j", "k" },
    -- },
  }

)

local n_leader = {
  g = {
    name = "Git",
    g = {':GitInTab<CR>', "Git in tab"},
    i = {':DiffviewOpen<CR>', "Git in tab"},
    d = {':DiffviewFile<CR>', "Diff for current buffer"},
    c = {':DiffviewFileHistory<CR>', "Commits for current buffer"},
    C = {':<C-u>FzfLua git_commits<CR>', "Commits"},
    l = {':<C-u>FzfLua git_branches<CR>', "Log of a branches"},
    s = {':lua require("ik1614.functions").fzf:git_status()<CR>', "Status"},
    o = "Open in web", -- TODO: currently this is defined in the 'gitlinker' config
    h = { name = "+hunk" },
  },
  r = {
    name = "Run/Refactor",
    n = {"Rename"},
    f = {':lua require("ik1614.functions").fzf:lsp_code_actions()<CR>', "Refactor"},
    r = {':w<CR>:luafile %<CR>', "Run currentl lua file"},
    l = {':call functions#exec_current_line()<CR>', "Run current lua line"},
  },
  s = {
    name = "Show",
    a = {"Code actions"},
    s = {"Symbols"},
    S = {"Workspace symbols"},
    d = {"Diagnostics"},
    D = {"Workspace diagnostics"},
    l = {"Line diagnostics"},
    n = {"Next diagnostic"},
    e = {"Previous diagnostic"},
    i = {"Implementations"},
    r = {"References"},
  },
  f = {
    name = "Find (fzf)",
    f = {':<C-u>FzfLua files<CR>', "Files"},
    b = {':<C-u>FzfLua buffers<CR>', "Buffers"},
    s = {':lua require("ik1614.functions").fzf:grep_no_ignore()<CR>', "Search all"},
    p = {':<C-u>FzfLua grep_project<CR>', "Search project"},
    w = {':<C-u>FzfLua grep_cword<CR>', "Current word"},
    l = {':<C-u>FzfLua grep_curbuf<CR>', "Lines of current buffer"},
    r = {':<C-u>FzfLua resume<CR>', "Resume"},
    q = {':<C-u>FzfLua quickfix<CR>', "Quickfix"},
    n = {":lua require('neoclip.fzf')()<CR>", "Neoclip"},
    [":"] = {':<C-u>FzfLua command_history<CR>', "Command history"},
    ["/"] = {':<C-u>FzfLua search_history<CR>', "Search history"},
    ["?"] = {':<C-u>FzfLua builtin<CR>', "Builtins"},
  },
  o = {
    name = "Open",
    b = {':NvimTreeFindFile<CR>zz', "File browser"},
    t = {':TodoTelescope<CR>', "Todo"},
    w = {':call functions#OpenURL()<CR>', "Web browser"},
  },
  h = {
    name = "Help",
    t = { '<cmd>:Telescope builtin<cr>', "Telescope" },
    c = { '<cmd>:Telescope commands<cr>', "Commands" },
    h = { '<cmd>:Telescope help_tags<cr>', "Help Pages" },
    m = { '<cmd>:Telescope man_pages<cr>', "Man Pages" },
    k = { '<cmd>:Telescope keymaps<cr>', "Key Maps" },
    s = { '<cmd>:Telescope highlights<cr>', "Search Highlight Groups" },
    l = { [[<cmd>TSHighlightCapturesUnderCursor<cr>]], "Highlight Groups at cursor" },
    f = { '<cmd>:Telescope filetypes<cr>', "file Types" },
    o = { '<cmd>:Telescope vim_options<cr>', "options" },
    a = { '<cmd>:Telescope autocommands<cr>', "auto Commands" },
    p = {
      name = "+packer",
      p = { '<cmd>PackerSync<cr>', "Sync" },
      s = { '<cmd>PackerStatus<cr>', "Status" },
      i = { '<cmd>PackerInstall<cr>', "Install" },
      c = { '<cmd>PackerCompile<cr>', "Compile" },
    },
  },
}

local v_leader = {
  f = {
    name = "Find (fzf)",
    g = {':<C-u>FzfLua grep_visual<CR>', 'Grep selection'},
  },
  g = {
    o = "Open selection in web", -- TODO: currently this is defined in the 'gitlinker' config
  },
  o = {
    name = "Open",
    w = {':call functions#OpenURL()<CR>', "Web browser"},
  },
  r = {
    name = "Run/Refactor",
    f = {'<esc><cmd>lua require("ik1614.functions").refactoring:refactors()<CR>', "Refactor selection"},
  },
  s = {
    name = "Show",
    a = {':Telescope lsp_range_code_actions<CR>', "Code action for selection"},
  },
}
plugin.register(n_leader, { prefix = "<leader>", mode = "n" })
plugin.register(v_leader, { prefix = "<leader>", mode = "v" })

-- When we don't want to wait for auto pop-up :shrug:
vim.api.nvim_set_keymap('n', '<Leader>?', ":WhichKey '' n<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<Leader>?', ":WhichKey '' v<CR>", { noremap = true, silent = true })
