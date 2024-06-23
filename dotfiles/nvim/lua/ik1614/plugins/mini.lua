return {
  {
    "echasnovski/mini.surround",
    enabled = true,
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {},
    config = function()
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
    end,
  },
}
