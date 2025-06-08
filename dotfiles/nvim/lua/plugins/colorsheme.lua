return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      -- flavour = "frappe",
      flavour = "macchiato",
      -- flavour = "mocha",
      transparent_background = false, -- We get this from Tmux setting for the active window
      dim_inactive = {
        enabled = false, -- dims the background color of inactive window
        shade = "dark",
        percentage = 0, -- percentage of the shade to apply to the inactive window
      },
      custom_highlights = {
        ColorColumn = { bg = "#3B3F53" },
        Comment = { fg = "#585D70" },
        LspReferenceText = { bg = "NONE" },
        LspReferenceRead = { bg = "NONE" },
        LspReferenceWrite = { bg = "NONE" },
      },
    },
  },
  {
    "https://github.com/m-demare/hlargs.nvim",
    enabled = true,
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      local arg_color = "#EA999D" -- For: catppuccin-frappe

      require("hlargs").setup({
        color = arg_color,
        excluded_filetypes = {},
        -- disable = function(lang, bufnr) -- If changed, `excluded_filetypes` will be ignored
        --   return vim.tbl_contains(opts.excluded_filetypes, lang)
        -- end,
        paint_arg_declarations = true,
        paint_arg_usages = true,
        paint_catch_blocks = {
          declarations = false,
          usages = false,
        },
        hl_priority = 10000,
        excluded_argnames = {
          declarations = {},
          usages = {
            python = {
              "self",
              "cls",
            },
            lua = {
              "self",
            },
          },
        },
        performance = {
          parse_delay = 1,
          slow_parse_delay = 50,
          max_iterations = 400,
          max_concurrent_partial_parses = 30,
          debounce = {
            partial_parse = 3,
            partial_insert_mode = 100,
            total_parse = 700,
            slow_parse = 5000,
          },
        },
      })
    end,
  },
}
