return {
  {
    "https://github.com/numToStr/Navigator.nvim",
    enabled = true,
    keys = {
      { "<S-Down>", "<CMD>NavigatorDown<CR>", mode = "i", desc = "Tmux navigator Down" },
      { "<S-Down>", "<CMD>NavigatorDown<CR>", mode = "n", desc = "Tmux navigator Down" },
      { "<S-Left>", "<CMD>NavigatorLeft<CR>", mode = "i", desc = "Tmux navigator Left" },
      { "<S-Left>", "<CMD>NavigatorLeft<CR>", mode = "n", desc = "Tmux navigator Left" },
      { "<S-Right>", "<CMD>NavigatorRight<CR>", mode = "i", desc = "Tmux navigator Right" },
      { "<S-Right>", "<CMD>NavigatorRight<CR>", mode = "n", desc = "Tmux navigator Right" },
      { "<S-Up>", "<CMD>NavigatorUp<CR>", mode = "i", desc = "Tmux navigator Up" },
      { "<S-Up>", "<CMD>NavigatorUp<CR>", mode = "n", desc = "Tmux navigator Up" },
      -- { "<C-\\>", "<CMD>NavigatorPrevious<CR>", mode = "i", desc = "Tmux navigator (previous)" },
      -- { "<C-\\>", "<CMD>NavigatorPrevious<CR>", mode = "n", desc = "Tmux navigator (previous)" },
    },
    config = function()
      require("Navigator").setup({
        auto_save = "all",
        disable_on_zoom = true,
      })
    end,
  },
}
