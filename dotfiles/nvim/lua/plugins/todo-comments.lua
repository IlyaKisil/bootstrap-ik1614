return {
  {
    "https://github.com/folke/todo-comments.nvim",
    opts = function(_, opts)
      opts.highlight = {
        before = "",
        after = "",
        keyword = "",
      }
    end,
  },
}
