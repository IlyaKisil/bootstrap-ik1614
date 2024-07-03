return {
  {
    "echasnovski/mini.nvim",
    enabled = true,
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {},
    config = function()
      require("mini.align").setup()
      require("mini.splitjoin").setup()

      require("mini.surround").setup({
        mappings = {
          add = "ys",
          delete = "ds",
          replace = "cs",
          find = "",
          find_left = "",
          highlight = "",
        },
      })

      -- Surrounding for Visual mode selection
      vim.keymap.del("x", "ys")
      vim.api.nvim_set_keymap("x", "S", [[:<C-u>lua MiniSurround.add('visual')<CR>]], { noremap = true })

      require("mini.jump").setup({
        delay = {
          -- Delay between jump and automatic stop if idle (no jump is done)
          idle_stop = 2000,
        },
      })
    end,
  },
}
