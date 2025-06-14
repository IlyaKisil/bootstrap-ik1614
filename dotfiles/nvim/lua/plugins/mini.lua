return {
  {
    "echasnovski/mini.surround",
    opts = {
      mappings = {
        --[[
          -- These would replicate what came with 'tpop/vim-surround'
          add = "ys",
          delete = "ds",
          replace = "cs",
          find = "", -- Find surrounding (to the right)
          find_left = "", -- Find surrounding (to the left)
          highlight = "", -- Highlight surrounding
          update_n_lines = "", -- Update `n_lines` -> Not sure what this actually doing :shrug:
        --]]
        --[[
          -- Usual mappings
           add = "gsa", -- Add surrounding in Normal and Visual modes
           delete = "gsd", -- Delete surrounding
           replace = "gsr", -- Replace surrounding
           find = "gsf", -- Find surrounding (to the right)
           find_left = "gsF", -- Find surrounding (to the left)
           highlight = "gsh", -- Highlight surrounding
           update_n_lines = "gsn", -- Update `n_lines`
        --]]
        add = "gsa", -- Add surrounding in Normal and Visual modes
        delete = "gsd", -- Delete surrounding
        replace = "gsc", -- [C]hange surrounding
        find_left = "",
        find = "",
        highlight = "",
        update_n_lines = "",
      },
    },
  },
}
