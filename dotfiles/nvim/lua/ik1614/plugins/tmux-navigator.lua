return {
  {
    "https://github.com/numToStr/Navigator.nvim",
    enabled = true,
    config = function()
      require("Navigator").setup({
        auto_save = "all",
        disable_on_zoom = true,
      })

      local map = require("ik1614.functions.mapping")
      map:n({ "<S-Left>", "<CMD>NavigatorLeft<CR>" })
      map:n({ "<S-Right>", "<CMD>NavigatorRight<CR>" })
      map:n({ "<S-Up>", "<CMD>NavigatorUp<CR>" })
      map:n({ "<S-Down>", "<CMD>NavigatorDown<CR>" })
      map:n({ "<C-\\>", "<CMD>NavigatorPrevious<CR>" })

      map:i({ "<S-Left>", "<C-c><CMD>NavigatorLeft<CR>" })
      map:i({ "<S-Right>", "<C-c><CMD>NavigatorRight<CR>" })
      map:i({ "<S-Up>", "<C-c><CMD>NavigatorUp<CR>" })
      map:i({ "<S-Down>", "<C-c><CMD>NavigatorDown<CR>" })
      map:i({ "<C-\\>", "<C-c><CMD>NavigatorPrevious<CR>" })
    end,
  },
}
