return {
  {
    "echasnovski/mini.nvim",
    enabled = true,
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {},
    config = function()
      require("mini.align").setup()
      require("mini.splitjoin").setup()
    end,
  },
}
