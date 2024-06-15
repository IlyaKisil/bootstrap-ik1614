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
        ["<C-Space>"] = cmp.mapping.complete(), -- Manually trigger completion suggestions. Generally don't need this.
        ["<C-a>"] = cmp.mapping.abort(), -- Close completion options
        ["<C-c>"] = cmp.mapping.close(), -- Stop completion and go back to the original text
        ["<C-e>"] = cmp.mapping(
          cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
          {"i", "c"}
        ),

        ["<C-n>"] = cmp.mapping(
          cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
          {"i", "c"}
        ),
        ['<C-u>'] = cmp.mapping.scroll_docs(-4), -- Scrolling back
        ['<C-d>'] = cmp.mapping.scroll_docs(4), -- Scrolling forward

        -- Alternative could be using '<CR>'
        ["<C-y>"] = cmp.mapping(
          cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Insert,
            -- behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          },
          { "i", "c" }
        ),

        -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
        -- * https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
        -- Alternative could be using Tab and S-Tab
        ['<C-i>'] = cmp.mapping(
          function()
            if luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            end
          end,
          { 'i', 's' }
        ),
        ['<C-h>'] = cmp.mapping(
          function()
            if luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            end
          end,
          { 'i', 's' }
        ),
      }

      cmp.setup {
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
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

      cmp.setup.cmdline('/', {
        mapping = default_mappings,
        sources = {
          { name = 'buffer', keyword_length = 3 }
        }
      })

      cmp.setup.cmdline(':', {
        mapping = default_mappings,
        sources = cmp.config.sources(
          {
            { name = 'path', keyword_length = 3 }
          },
          {
            { name = 'cmdline', keyword_length = 3 }
          }
        ),
        matching = { disallow_symbol_nonprefix_matching = false }
      })
    end,
  },
}
