return {
  {
    "echasnovski/mini.nvim",
    enabled = true,
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {},
    config = function()
      require("mini.align").setup()
      require("mini.splitjoin").setup()

      require("mini.jump").setup({
        delay = {
          -- Delay between jump and automatic stop if idle (no jump is done)
          idle_stop = 2000,
        },
      })
    end,
  },
}
