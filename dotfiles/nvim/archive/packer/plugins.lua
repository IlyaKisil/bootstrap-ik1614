-- Automatically ensure that packer.nvim is installed
local execute = vim.api.nvim_command
local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({ "git", "clone", "https://github.com/wbthomason/packer.nvim", install_path })
  execute("packadd packer.nvim")
end

-- Auto compile when there are changes in plugins.lua
vim.cmd("autocmd BufWritePost plugins.lua PackerCompile profile=true")

-- require('packer').init({display = {non_interactive = true}})
require("packer").init({
  profile = {
    enable = true,
  },
})

return require("packer").startup(function(use)
  -- We keep it so that packer won't try to remove itself.
  -- In reality, we have it as git submodule, that we link to
  -- a specific directory
  use("wbthomason/packer.nvim")

  -------------------------------------------------------------------------------------
  -- If you use Neovim, then you need these :wink:
  -------------------------------------------------------------------------------------
  use("nvim-lua/popup.nvim")
  use("nvim-lua/plenary.nvim") -- kinda ported over (as a dependency)
  use("tami5/sqlite.lua")

  -------------------------------------------------------------------------------------
  -- Autocomplete
  -------------------------------------------------------------------------------------
  use({
    "hrsh7th/nvim-cmp",
    -- commit = "99ef8543",
    -- event = "InsertEnter",  # TODO: understand how this 'opt/event' work etc
    -- opt = true,
    requires = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lsp",
      "saadparwaiz1/cmp_luasnip",
      "L3MON4D3/LuaSnip",
      "rafamadriz/friendly-snippets",
      {
        "windwp/nvim-autopairs",
      },
    },
  })

  -------------------------------------------------------------------------------------
  -- Style and visual sugar
  -------------------------------------------------------------------------------------
  use({
    "nvim-treesitter/nvim-treesitter", -- Ported over
    run = ":TSUpdate",
  })
  use({ "nvim-treesitter/nvim-treesitter-textobjects" }) -- Ported over
  -- use {'https://github.com/nvim-treesitter/nvim-treesitter-context'}
  -- use 'nvim-treesitter/nvim-treesitter-refactor'
  use("nvim-treesitter/playground") -- I think this is now comes by default?

  use("https://github.com/ryanoasis/vim-devicons") -- Don't think I need this
  use("https://github.com/kyazdani42/nvim-web-devicons") -- ported over

  use({
    "https://github.com/nvim-lualine/lualine.nvim", -- ported over
    requires = { "kyazdani42/nvim-web-devicons", opt = true },
  })

  use({ "https://github.com/rcarriga/nvim-notify" })

  -- Color
  use({
    "norcalli/nvim-colorizer.lua", -- ported over
  })
  use("sheerun/vim-polyglot") -- TODO: need to reduce footprint and use Treesitter as much as possible

  -- Colorschemes
  use({
    "https://github.com/navarasu/onedark.nvim", -- ported over
    -- commit = "6c72a9c5",
  })

  use({
    "https://github.com/m-demare/hlargs.nvim", -- ported over
    requires = { "nvim-treesitter/nvim-treesitter" },
  })

  use({
    "https://github.com/junegunn/vim-easy-align",
    -- commit = "6c72a9c5",
  })

  use({
    "folke/noice.nvim",
    requires = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      "rcarriga/nvim-notify",
    },
  })

  -------------------------------------------------------------------------------------
  -- LSP, file and general navigation
  -------------------------------------------------------------------------------------
  use({
    "neovim/nvim-lspconfig",
    -- opt = true, # TODO: understand how this 'opt/event' work etc
    -- NOTE: I have a feeling that this has some odd side effects on the
    -- first file opened. Some files won't get highlinghted, e.g. *.py, other
    -- would be just deleted and in read only mode, e.g. *.go.
    -- event = "BufReadPre",
    wants = {
      "nvim-lsp-ts-utils",
      "null-ls.nvim",
      "cmp-nvim-lsp",
    },
    requires = {
      "jose-elias-alvarez/nvim-lsp-ts-utils",
      "jose-elias-alvarez/null-ls.nvim",
    },
  })

  use({ "https://github.com/williamboman/mason.nvim" })
  use({ "https://github.com/williamboman/mason-lspconfig.nvim" })

  use({
    "jose-elias-alvarez/null-ls.nvim",
    -- commit = "76d0573f",
  })

  -- use({'https://github.com/nvim-lua/lsp-status.nvim'})
  -- use({'https://github.com/arkav/lualine-lsp-progress'})

  use({
    "ThePrimeagen/refactoring.nvim",
    requires = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-treesitter/nvim-treesitter" },
    },
  })

  use({
    "ray-x/sad.nvim",
    requires = {
      { "ray-x/guihua.lua" },
    },
  })

  use({
    "nvim-telescope/telescope.nvim",
    requires = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("ik1614.telescope")
      require("ik1614.telescope.mappings")
    end,
  })
  use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
  -- use 'nvim-telescope/telescope-media-files.nvim'
  use("nvim-telescope/telescope-symbols.nvim")
  -- use 'https://github.com/fhill2/telescope-ultisnips.nvim'

  use({
    "AckslD/nvim-neoclip.lua",
    requires = {
      { "tami5/sqlite.lua", module = "sqlite" },
    },
  })
  use({
    "nvim-telescope/telescope-smart-history.nvim",
    requires = {
      { "tami5/sqlite.lua" },
    },
  })

  use({
    "ibhagwan/fzf-lua", -- ported over
    requires = {
      "vijaymarupudi/nvim-fzf",
      "kyazdani42/nvim-web-devicons",
    },
  })

  use({
    "kevinhwang91/nvim-bqf",
  })

  use({
    "kyazdani42/nvim-tree.lua", -- ported over
  })

  use({
    "https://github.com/folke/todo-comments.nvim",
    -- commit = "916cd4f1",
  })

  use({
    "folke/which-key.nvim",
    -- event = "BufWinEnter",
  })

  -------------------------------------------------------------------------------------
  -- Debugging
  -------------------------------------------------------------------------------------
  -- Debug adapter protocol
  use({
    "mfussenegger/nvim-dap",
  })
  use({
    "rcarriga/nvim-dap-ui",
  })
  -- use({
  --   "theHamsta/nvim-dap-virtual-text"
  -- })
  -- use({
  --   "nvim-telescope/telescope-dap.nvim"
  -- })

  --  Adaparter configuration for specific languages
  use({
    "leoluz/nvim-dap-go",
  })
  use({
    "mfussenegger/nvim-dap-python",
  })

  -------------------------------------------------------------------------------------
  -- Git
  -------------------------------------------------------------------------------------
  use({
    "lewis6991/gitsigns.nvim", -- ported over
    requires = { "nvim-lua/plenary.nvim" },
  })
  use({
    "sindrets/diffview.nvim",
    requires = "nvim-lua/plenary.nvim",
  })
  use("tpope/vim-fugitive") -- ported over -- Can be substituted with https://github.com/TimUntersberger/neogit which is written in Lua
  -- use 'https://github.com/TimUntersberger/neogit'
  use({
    "ruifm/gitlinker.nvim", -- ported over
    requires = "nvim-lua/plenary.nvim",
  })

  -------------------------------------------------------------------------------------
  -- Language specific
  -------------------------------------------------------------------------------------
  use({
    "https://github.com/saltstack/salt-vim",
  })
  use({
    "https://github.com/Glench/Vim-Jinja2-Syntax",
  })

  -- use { "https://github.com/lervag/vimtex" }

  -------------------------------------------------------------------------------------
  -- General Plugins
  -------------------------------------------------------------------------------------
  use({
    "https://github.com/numToStr/Navigator.nvim", -- ported over
  })

  use("https://github.com/tpope/vim-commentary")
  -- use 'terrortylor/nvim-comment'  -- Alternative in pure Lua
  -- use 'b3nj5m1n/kommentary'       -- Similar in pure Lua
  use({
    "https://github.com/echasnovski/mini.nvim",
    branch = "stable",
  })

  use({
    "xorid/asciitree.nvim",
  })
end)
