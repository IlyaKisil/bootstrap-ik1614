return {
  {
    "https://github.com/numToStr/Navigator.nvim",
    enabled = true,
    keys = {
      { "<S-Down>", "<CMD>NavigatorDown<CR>", mode = "i", desc = "Tmux navigator" },
      { "<S-Down>", "<CMD>NavigatorDown<CR>", mode = "n", desc = "Tmux navigator" },
      { "<S-Left>", "<CMD>NavigatorLeft<CR>", mode = "i", desc = "Tmux navigator" },
      { "<S-Left>", "<CMD>NavigatorLeft<CR>", mode = "n", desc = "Tmux navigator" },
      { "<S-Right>", "<CMD>NavigatorRight<CR>", mode = "i", desc = "Tmux navigator" },
      { "<S-Right>", "<CMD>NavigatorRight<CR>", mode = "n", desc = "Tmux navigator" },
      { "<S-Up>", "<CMD>NavigatorUp<CR>", mode = "i", desc = "Tmux navigator" },
      { "<S-Up>", "<CMD>NavigatorUp<CR>", mode = "n", desc = "Tmux navigator" },
      { "<C-\\>", "<CMD>NavigatorPrevious<CR>", mode = "i", desc = "Tmux navigator (previous)" },
      { "<C-\\>", "<CMD>NavigatorPrevious<CR>", mode = "n", desc = "Tmux navigator (previous)" },
    },
    config = function()
      require("Navigator").setup({
        auto_save = "all",
        disable_on_zoom = true,
      })
    end,
  },
}
