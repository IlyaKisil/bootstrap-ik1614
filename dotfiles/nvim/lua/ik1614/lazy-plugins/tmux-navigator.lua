return {
  {
    "https://github.com/numToStr/Navigator.nvim",
    enabled = true,
    config = function()

      require("Navigator").setup({
        auto_save = 'all',
        disable_on_zoom = true
      })

      local f = require("ik1614.functions")
      f.mapping:n({"<S-Left>",  '<CMD>NavigatorLeft<CR>'})
      f.mapping:n({"<S-Right>", '<CMD>NavigatorRight<CR>'})
      f.mapping:n({"<S-Up>",    '<CMD>NavigatorUp<CR>'})
      f.mapping:n({"<S-Down>",  '<CMD>NavigatorDown<CR>'})
      f.mapping:n({"<C-\\>",    '<CMD>NavigatorPrevious<CR>'})

      f.mapping:i({"<S-Left>",  '<C-c><CMD>NavigatorLeft<CR>'})
      f.mapping:i({"<S-Right>", '<C-c><CMD>NavigatorRight<CR>'})
      f.mapping:i({"<S-Up>",    '<C-c><CMD>NavigatorUp<CR>'})
      f.mapping:i({"<S-Down>",  '<C-c><CMD>NavigatorDown<CR>'})
      f.mapping:i({"<C-\\>",    '<C-c><CMD>NavigatorPrevious<CR>'})
    end
  }
}
