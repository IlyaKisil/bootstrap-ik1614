return {
  {
    -- TODO: Consider substituting with https://github.com/TimUntersberger/neogit or some
    -- other thing written in 'lua'
    "https://github.com/tpope/vim-fugitive",
    enabled = true,
    keys = {
      {
        "<leader>gg",
        function()
          vim.cmd("tabedit fugitive")
          vim.cmd("Git")
          vim.cmd("wincmd k")
          vim.cmd("wincmd q")
        end,
        mode = "n",
        desc = "Git",
      },
    },
    cmd = "G",
  },
}
