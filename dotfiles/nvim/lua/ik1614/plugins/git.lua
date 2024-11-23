return {
  {
    -- TODO: Consider substituting with https://github.com/TimUntersberger/neogit or some
    -- other thing written in 'lua'
    "https://github.com/tpope/vim-fugitive",
    enabled = true,
    keys = {
      { "<leader>gg", "<cmd>GitInTab<cr>", mode = "n", desc = "[G]it in tab" },
    },
    cmd = "G",
    config = function()
      vim.cmd([[
        command! GitInTab tabedit 'vim-fugitive'| Git | wincmd k | wincmd q
      ]])
    end,
  },
  {
    "https://github.com/ruifm/gitlinker.nvim",
    enabled = true,
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    keys = {
      "<leader>go",
      {
        "<leader>go",
        "<cmd>lua require('gitlinker').get_buf_range_url('n', {action_callback=require('gitlinker.actions').copy_to_clipboard})<cr>",
        mode = "n",
        desc = "[G]it line: Copy link to a clipboard",
      },
      {
        "<leader>go",
        "<cmd>lua require('gitlinker').get_buf_range_url('v', {action_callback=require('gitlinker.actions').copy_to_clipboard})<cr><esc>",
        mode = "v",
        desc = "[G]it range: Copy link to a clipboard",
      },
      {
        "<leader>gO",
        "<cmd>lua require('gitlinker').get_buf_range_url('v')<cr>",
        mode = "v",
        desc = "[G]it range: Open in a browser and copy link to a clipboard",
      },
      {
        "<leader>gO",
        "<cmd>lua require('gitlinker').get_buf_range_url('n')<cr>",
        mode = "n",
        desc = "[G]it line: Open in a browser and copy link to a clipboard",
      },
      {
        "<leader>gr",
        "<cmd>lua require('gitlinker').get_repo_url({action_callback=require('gitlinker.actions').open_in_browser})<cr>",
        mode = "n",
        desc = "[G]it repo: Open in a browser",
      },
      {
        "<leader>gR",
        "<cmd>lua require('gitlinker').get_repo_url()<cr>",
        mode = "n",
        desc = "[G]it repo: Open in a browser and copy link to a clipboard",
      },
    },
    config = function()
      local gitlinker = require("gitlinker")

      --- copies the url to clipboard and opens the url in your default browser
      --
      -- @param url the url string
      local function copy_and_open_in_browser(url)
        gitlinker.actions.copy_to_clipboard(url)
        gitlinker.actions.open_in_browser(url)
      end

      gitlinker.setup({
        opts = {
          action_callback = copy_and_open_in_browser,
          print_url = false,
        },
        callbacks = {
          ["github.com"] = function(url_data)
            -- NOTE: This is to cover different cases like 'IlyaKisil.github.com -> github.com'
            -- which I have for different SSH keys based on the repo owner (see 'ssh config').
            -- For some reason, simply adding 'IlyaKisil.github.com' to a table with callbacks
            -- doesn't work, potentially because keys are actually lua regex :shrug:
            url_data.host = "github.com"
            return gitlinker.hosts.get_github_type_url(url_data)
          end,
        },
        -- NOTE: This is set through Lazy
        mappings = nil,
      })
    end,
  },
  {
    "https://github.com/lewis6991/gitsigns.nvim",
    enabled = true,
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {},
    config = function()
      require("gitsigns").setup({
        signs = {
          add = { hl = "GitSignsAdd", text = "▎", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
          change = { hl = "GitSignsChange", text = "▎", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
          delete = { hl = "GitSignsDelete", text = "__", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
          topdelete = { hl = "GitSignsDelete", text = "^^", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
          -- topdelete    = {hl = 'GitSignsDelete', text = '‾‾', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
          changedelete = {
            hl = "GitSignsChange",
            text = "▎",
            numhl = "GitSignsChangeNr",
            linehl = "GitSignsChangeLn",
          },
        },
        numhl = false, -- highlights the line number
        linehl = false, -- highlights the whole line
        watch_gitdir = {
          interval = 1000,
        },
        sign_priority = 6,
        update_debounce = 200,
        status_formatter = nil, -- Use default
        on_attach = function(bufnr)
          -- This is where keymaps could be set
        end,
      })
    end,
  },
}
