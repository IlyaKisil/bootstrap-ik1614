return {
  {
    "nvim-treesitter/nvim-treesitter",
    enabled = true,
    lazy = false,
    build = ":TSUpdate",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      "windwp/nvim-ts-autotag",
    },
    config = function()
      require("nvim-treesitter.configs").setup({
        auto_install = true,
        ensure_installed = {
          "bash",
          "c",
          "comment",
          "cpp",
          "css",
          "diff",
          "dockerfile",
          "go",
          "html",
          "hcl",
          "javascript",
          "json",
          "jsonc",
          "kotlin",
          "latex",
          "lua",
          "luadoc",
          "make",
          "markdown",
          "python",
          "query",
          "regex",
          "rust",
          "toml",
          "typescript",
          "vim",
          "vimdoc",
          "yaml",
        },
        -- NOTE seems to be broken
        ignore_install = {
          "haskell",
        },
        highlight = {
          enable = true,
          disable = {
            "bash", -- TODO: after switching to `lazy.nvim` stopped working :shrug:
            "json", -- breaks for environment.template
          },
        },
        indent = {
          enable = true,
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<C-Space>",
            node_incremental = "<C-Space>",
            scope_incremental = "<CR>",
            node_decremental = "<BS>",
          },
        },
        textobjects = {
          select = {
            enable = true,
            keymaps = {
              ["af"] = { query = "@function.outer", desc = "Select outer part of a function/method definition" },
              ["if"] = { query = "@function.inner", desc = "Select inner part of a function/method definition" },
              ["ac"] = { query = "@class.outer", desc = "Select outer part of a class" },
              ["ic"] = { query = "@class.inner", desc = "Select inner part of a class" },
              ["al"] = { query = "@loop.outer", desc = "Select outer part of a loop" },
              ["il"] = { query = "@loop.inner", desc = "Select inner part of a loop" },
            },
          },
        },
      })
    end,
  },
}
