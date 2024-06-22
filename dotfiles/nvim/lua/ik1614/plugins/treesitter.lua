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
          "go",
          "html",
          "javascript",
          "json",
          "jsonc",
          "kotlin",
          "latex",
          "lua",
          "luadoc",
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
            "yaml", -- There is something weird with it as well
            "hcl",
          },
        },
        indent = {
          enable = true,
        },
      })
    end,
  },
}
