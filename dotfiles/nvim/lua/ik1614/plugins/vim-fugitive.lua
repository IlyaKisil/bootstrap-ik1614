-- TODO: Consider substituting with https://github.com/TimUntersberger/neogit or some
-- other thing written in 'lua'
return {
  {
    "https://github.com/tpope/vim-fugitive",
    enabled = true,
    keys = {
      {"<leader>gg", "<cmd>GitInTab<cr>", mode="n", desc="[G]it in tab"},
    },
    config = function()
      vim.cmd([[
        command! GitInTab tabedit 'vim-fugitive'| Git | wincmd k | wincmd q
      ]])
    end
  }
}
