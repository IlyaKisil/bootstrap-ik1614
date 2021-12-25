-- Automatically ensure that packer.nvim is installed
local execute = vim.api.nvim_command
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
  execute 'packadd packer.nvim'
end

-- Auto compile when there are changes in plugins.lua
vim.cmd 'autocmd BufWritePost plugins.lua PackerCompile profile=true'

-- require('packer').init({display = {non_interactive = true}})
require('packer').init(
  {
    profile = {
      enable = true,
    }
  }
)

return require('packer').startup(
  function(use)
    -- We keep it so that packer won't try to remove itself.
    -- In reality, we have it as git submodule, that we link to
    -- a specific directory
    use "wbthomason/packer.nvim"

    -------------------------------------------------------------------------------------
    -- If you use Neovim, then you need these :wink:
    -------------------------------------------------------------------------------------
    use 'nvim-lua/popup.nvim'
    use 'nvim-lua/plenary.nvim'
    use "tami5/sqlite.lua"


    -------------------------------------------------------------------------------------
    -- Autocomplete
    -------------------------------------------------------------------------------------
    use({
      "hrsh7th/nvim-cmp",
      event = "InsertEnter",
      opt = true,
      config = function()
        require("ik1614.nvim-cmp")
      end,
      requires = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "quangnguyen30192/cmp-nvim-ultisnips",
        {
          "windwp/nvim-autopairs",
          config = function()
            require('nvim-autopairs').setup()
          end,
        },
      },
    })

    use 'SirVer/ultisnips'
    -- use 'honza/vim-snippets'
    -- use 'golang/vscode-go'


    -------------------------------------------------------------------------------------
    -- Style and visual sugar
    -------------------------------------------------------------------------------------
    use({
      'nvim-treesitter/nvim-treesitter',
      run = ':TSUpdate',
      config = function()
        require("ik1614.treesitter")
      end,
    })
    use {'nvim-treesitter/nvim-treesitter-textobjects'}
    -- use 'nvim-treesitter/nvim-treesitter-refactor'
    use 'nvim-treesitter/playground'

    use 'https://github.com/ryanoasis/vim-devicons'
    use 'https://github.com/kyazdani42/nvim-web-devicons'

    use({
      'https://github.com/glepnir/galaxyline.nvim',
      config = function()
        require("ik1614.galaxyline")
      end,
    })

    -- Color
    use({
      'norcalli/nvim-colorizer.lua',
      config = function()
        require("ik1614.nvim-colorizer")
      end,
    })
    use 'sheerun/vim-polyglot' -- TODO: need to reduce footprint and use Treesitter as much as possible

    -- use({
    --   'stevearc/dressing.nvim',
    --   config = function()
    --     require("ik1614.dressing")
    --   end,
    -- })

    -------------------------------------------------------------------------------------
    -- LSP, file and general navigation
    -------------------------------------------------------------------------------------
    use({
      "neovim/nvim-lspconfig",
      opt = true,
      event = "BufReadPre",
      wants = {
        "nvim-lsp-ts-utils",
        "null-ls.nvim",
        "cmp-nvim-lsp",
        "nvim-lsp-installer",
      },
      config = function()
        require("ik1614.lsp")
      end,
      requires = {
        "jose-elias-alvarez/nvim-lsp-ts-utils",
        "jose-elias-alvarez/null-ls.nvim",
        "williamboman/nvim-lsp-installer",
      },
    })

    use({
      "RRethy/vim-illuminate",
      event = "CursorHold",
      module = "illuminate",
      config = function()
        vim.g.Illuminate_delay = 1000
      end,
    })
    -- use 'https://github.com/folke/lsp-trouble.nvim'

    use {
      "ThePrimeagen/refactoring.nvim",
      requires = {
        {"nvim-lua/plenary.nvim"},
        {"nvim-treesitter/nvim-treesitter"}
      },
      config = function()
        require("ik1614.refactoring")
      end,
    }

    use {
      "ray-x/sad.nvim",
      requires = {
        {"ray-x/guihua.lua"},
      },
      config = function()
        require("ik1614.sad")
      end,
    }

    use {
      'nvim-telescope/telescope.nvim',
      requires = {
        'nvim-lua/plenary.nvim'
      },
      config = function()
        require("ik1614.telescope")
        require("ik1614.telescope.mappings")
      end,
    }
    use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
    use 'nvim-telescope/telescope-media-files.nvim'
    use 'nvim-telescope/telescope-symbols.nvim'
    -- use 'https://github.com/fhill2/telescope-ultisnips.nvim'

    use {
      "AckslD/nvim-neoclip.lua",
      requires = {
        {'tami5/sqlite.lua', module = 'sqlite'}
      },
      config = function()
        require("ik1614.nvim-neoclip")
      end,
    }
    use {
      'nvim-telescope/telescope-smart-history.nvim',
      requires = {
        {'tami5/sqlite.lua'}
      },
    }

    use 'https://github.com/junegunn/fzf'
    use 'https://github.com/junegunn/fzf.vim'
    -- use {'ibhagwan/fzf-lua',
    --   requires = {
    --     'vijaymarupudi/nvim-fzf',
    --     'kyazdani42/nvim-web-devicons'
    --   },
    -- }

    use({
      'kevinhwang91/nvim-bqf',
      config = function()
        require("ik1614.nvim-bqf")
      end,
    })

    use({
      'kyazdani42/nvim-tree.lua',
      config = function()
        require("ik1614.nvim-tree")
      end,
    })

    use({
      'https://github.com/folke/todo-comments.nvim',
      config = function()
        require("ik1614.todo-comments")
      end,
    })


    -------------------------------------------------------------------------------------
    -- Debugging
    -------------------------------------------------------------------------------------
    -- use 'mfussenegger/nvim-dap'


    -------------------------------------------------------------------------------------
    -- Git
    -------------------------------------------------------------------------------------
    use {
      'lewis6991/gitsigns.nvim',
      requires = {'nvim-lua/plenary.nvim'},
      config = function()
        require("ik1614.gitsigns")
      end,
    }
    use 'sindrets/diffview.nvim'
    use 'tpope/vim-fugitive' -- Can be substituted with https://github.com/TimUntersberger/neogit which is written in Lua
    -- use 'https://github.com/TimUntersberger/neogit'
    use {
      'ruifm/gitlinker.nvim',
      requires = 'nvim-lua/plenary.nvim',
      config = function()
        require("ik1614.gitlinker")
      end,
    }
    -- For PR review etc. FIXME: some problems with 'gh auth'. I'm logged in just fine
    -- (using 'GITHUB_TOKEN' env variable) and can do everything in CLI but this plugin
    -- asks to do auth :shrug:
    -- use {
    --   'pwntester/octo.nvim',
    --   config=function()
    --     require"octo".setup({})
    --   end
    -- }

    -------------------------------------------------------------------------------------
    -- Language specific
    -------------------------------------------------------------------------------------
    use {
      'https://github.com/fatih/vim-go',
      run = ':GoUpdateBinaries',
      config = function()
        require("ik1614.vim-go")
      end,
    }
    use {
      'https://github.com/saltstack/salt-vim',
    }
    use {
      'https://github.com/Glench/Vim-Jinja2-Syntax',
    }

    use {
      "https://github.com/lervag/vimtex"
    }

    -------------------------------------------------------------------------------------
    -- General Plugins
    -------------------------------------------------------------------------------------
    -- Preview/query JSON files
    -- use 'gennaro-tedesco/nvim-jqx'

    -- Registers
    -- use 'gennaro-tedesco/nvim-peekup'

    -- use 'liuchengxu/vim-which-key'
    -- use 'https://github.com/folke/which-key.nvim'
    -- use 'liuchengxu/vista.vim'
    -- use 'monaqa/dial.nvim'
    -- use 'andymass/vim-matchup'
    -- use 'MattesGroeger/vim-bookmarks'
    -- use 'kshenoy/vim-signature'

    -- Will need to double check
    -- use {
    --     'glacambre/firenvim',
    --     run = function()
    --         vim.fn['firenvim#install'](1)
    --     end
    -- }

    -- Documentation Generator
    -- use({
    --   "kkoomen/vim-doge",
    --   config = function()
    --     vim.g.doge_enable_mappings = false
    --   end,
    --   run = function()
    --     vim.fn["doge#install"]()
    --   end,
    -- })

    use({
      'https://github.com/christoomey/vim-tmux-navigator', -- Can be replaced with https://github.com/numToStr/Navigator.nvim
      config = function()
        require("ik1614.vim-tmux-navigator")
      end,
    })

    use 'https://github.com/tpope/vim-surround'
    use 'https://github.com/tpope/vim-commentary'
    -- use 'terrortylor/nvim-comment'  -- Alternative in pure Lua
    -- use 'b3nj5m1n/kommentary'       -- Similar in pure Lua

    -------------------------------------------------------------------------------------
    -- Plugins to try out at some point
    -------------------------------------------------------------------------------------
    -- https://github.com/mfussenegger/nvim-lint
    -- https://github.com/ThePrimeagen/harpoon
    -- https://github.com/folke/persistence.nvim
    -- https://github.com/nvim-pack/nvim-spectre
    -- https://github.com/akinsho/toggleterm.nvim
    --
    -------------------------------------------------------------------------------------
    -- Interesting colorschemes when/if I get bored of my current setup
    -------------------------------------------------------------------------------------
    -- use({
    --   'rebelot/kanagawa.nvim',
    --   config = function()
    --     require("ik1614.kanagawa")
    --   end,
    -- })
  end
)
