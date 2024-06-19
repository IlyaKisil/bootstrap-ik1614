return {
  {
    'hrsh7th/nvim-cmp',
    event = {'InsertEnter', 'CmdlineEnter'},
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-cmdline",
      "onsails/lspkind.nvim",
      { "L3MON4D3/LuaSnip", build = "make install_jsregexp" },
      'saadparwaiz1/cmp_luasnip',
    },
    config = function()
      local cmp = require('cmp')
      local luasnip = require('luasnip')
      local lspkind = require("lspkind")

      luasnip.config.setup {}

      vim.opt.completeopt = {
        "menu",
        "menuone",
        "noselect",
        "noinsert",
        "preview"
      }

      local default_mappings = {
        -- Manually trigger completion suggestions. Generally don't need this.
        ["<C-Space>"] = cmp.mapping.complete(),

        -- Close completion options
        ["<C-a>"] = cmp.mapping.abort(),

        -- Stop completion and go back to the original text
        ["<C-c>"] = cmp.mapping.close(),

        -- Move to [N]ext item in completion menue
        ["<C-n>"] = cmp.mapping(
          cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
          {"i", "c"}
        ),

        -- Move to previous item in completion menu
        ["<C-e>"] = cmp.mapping(
          cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
          {"i", "c"}
        ),

        -- Scrolling [U]p / back
        ['<C-u>'] = cmp.mapping(
          cmp.mapping.scroll_docs(-4),
          {"i"}
        ),

        -- Scrolling [D]own / forward
        ['<C-d>'] = cmp.mapping(
          cmp.mapping.scroll_docs(4),
          {"i"}
        ),

        -- Confirm selection
        -- Alternative could be using '<C-y>' -> Confirm [Y]es
        ["<CR>"] = cmp.mapping(
          cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Insert,
            -- behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          },
          { "i", "c" }
        ),
      }

      cmp.setup {
        -- Enable luasnip to handle snippet expansion for nvim-cmp
        snippet = {
          expand = function(args)
            vim.snippet.expand(args.body)
          end,
        },

        mapping = default_mappings,
        sources = {
          { name = "buffer", keyword_length = 5 },
          { name = 'luasnip' },
          { name = 'nvim_lsp' },
          { name = 'path' },
        },
        formatting = {
          format = lspkind.cmp_format({
            maxwidth = 50,
            ellipsis_char = "...",
          }),
        },
      }

      -- cmp.setup.cmdline('/', {
      --   mapping = default_mappings,
      --   sources = {
      --     { name = 'buffer', keyword_length = 3 }
      --   }
      -- })
      --
      -- cmp.setup.cmdline(':', {
      --   mapping = default_mappings,
      --   sources = cmp.config.sources(
      --     {
      --       { name = 'path', keyword_length = 3 }
      --     },
      --     {
      --       { name = 'cmdline', keyword_length = 3 }
      --     }
      --   ),
      --   matching = { disallow_symbol_nonprefix_matching = false }
      -- })
    end,
  },
}
