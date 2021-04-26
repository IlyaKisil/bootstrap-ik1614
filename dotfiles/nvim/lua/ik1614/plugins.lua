local execute = vim.api.nvim_command
local fn = vim.fn

-- Auto compile when there are changes in plugins.lua
vim.cmd 'autocmd BufWritePost plugins.lua PackerCompile'

-- require('packer').init({display = {non_interactive = true}})
-- require('packer').init({display = {auto_clean = false}})

return require('packer').startup(
  function(use)
    -- We keep it so that packer won't try to remove itself.
    -- In reality, we have it as git submodule, that we link to
    -- a specific directory
    -- use "wbthomason/packer.nvim"

    -- Guides to use Lua in NVIM
    -- use 'https://github.com/nanotee/nvim-lua-guide'
    -- use 'norcalli/nvim_utils'

    -- LSP
    use 'neovim/nvim-lspconfig'
    use {"kabouzeid/nvim-lspinstall"}
    use 'glepnir/lspsaga.nvim'
    -- use 'kosayoda/nvim-lightbulb'
    -- use {
    --   'ojroques/nvim-lspfuzzy',
    --   requires = {
    --     {'junegunn/fzf'},
    --     {'junegunn/fzf.vim'},  -- to enable preview (optional)
    --   },
    -- }

    -- Debugging
    -- use 'mfussenegger/nvim-dap'

    -- Autocomplete
    use 'hrsh7th/nvim-compe'
    use {'https://github.com/hrsh7th/vim-vsnip'}
    -- use 'SirVer/ultisnips'
    -- use 'honza/vim-snippets'
    -- use 'golang/vscode-go'

    -- Treesitter
    use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
    use {'nvim-treesitter/nvim-treesitter-textobjects'}
    -- use 'nvim-treesitter/nvim-treesitter-refactor'
    use 'nvim-treesitter/playground'

    -- Icons
    use 'https://github.com/ryanoasis/vim-devicons'
    use 'https://github.com/kyazdani42/nvim-web-devicons'

    -- Status Line and Bufferline
    use 'https://github.com/glepnir/galaxyline.nvim'
    -- use 'romgrk/barbar.nvim'

    -- Telescope
    use 'nvim-lua/popup.nvim'
    use 'nvim-lua/plenary.nvim'
    use 'nvim-telescope/telescope.nvim'
    use 'nvim-telescope/telescope-media-files.nvim'
    use 'https://github.com/junegunn/fzf'
    use 'https://github.com/junegunn/fzf.vim'

    -- Explorer
    -- use {'kyazdani42/nvim-tree.lua'} -- NOTE: Somehow it removes 'netrw#Explore', So I can't use 'GBrowse'
    use {"glepnir/dashboard-nvim"}

    -- Color
    use 'norcalli/nvim-colorizer.lua'
    use 'sheerun/vim-polyglot' -- TODO: need to reduce footprint and use Treesitter as much as possible

    -- Git
    use {
      'lewis6991/gitsigns.nvim',
      requires = {'nvim-lua/plenary.nvim'},
      -- FIXME: Doesn't work :cry:
      -- config = [[require('ik1614.gitsigns')]],
    }
    use 'tpope/vim-fugitive'
    use {
      'ruifm/gitlinker.nvim',
      requires = 'nvim-lua/plenary.nvim',
    }
    -- For PR review etc
    -- use {'https://github.com/pwntester/octo.nvim'}

    -- Preview/query JSON files
    -- use 'gennaro-tedesco/nvim-jqx'

    -- Registers
    -- use 'gennaro-tedesco/nvim-peekup'

    -- Navigation
    -- use 'unblevable/quick-scope'

    -- General Plugins
    -- use 'liuchengxu/vim-which-key'
    -- use 'kevinhwang91/nvim-bqf' -- Seems good but will need time to set it up
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

    -- Legit plugins
    use 'https://github.com/christoomey/vim-tmux-navigator'

    use 'https://github.com/tpope/vim-surround'
    use 'https://github.com/tpope/vim-commentary'
    -- use 'terrortylor/nvim-comment'  -- Alternative in pure Lua
    -- use 'b3nj5m1n/kommentary'       -- Similar in pure Lua

    -- Work
    use {
      'https://github.com/saltstack/salt-vim',
      -- FIXME: Doesn't work :cry:
      -- ft = {
      --   'sls',
      --   'j2',
      --   'jinja',
      --   'jinja2',
      -- }
    }
    use {
      'https://github.com/Glench/Vim-Jinja2-Syntax',
      -- FIXME: Doesn't work :cry:
      -- ft = {
      --   'sls',
      --   'j2',
      --   'jinja',
      --   'jinja2',
      -- }
    }

    use {
      "windwp/nvim-autopairs"
    }

    -- FIXME: Doesn't work straight away :shrug:
    use {
      "AndrewRadev/splitjoin.vim"
    }
  end
)
