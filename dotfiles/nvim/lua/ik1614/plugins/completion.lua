return {
  {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter" },
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lsp",
      "onsails/lspkind.nvim",
      { "L3MON4D3/LuaSnip", build = "make install_jsregexp" },
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      local lspkind = require("lspkind")

      luasnip.config.setup({})

      vim.opt.completeopt = {
        "menu",
        "menuone",
        "noselect",
        "noinsert",
        "preview",
      }

      local default_mappings = {
        -- Manually trigger completion suggestions. Generally don't need this.
        ["<C-Space>"] = cmp.mapping.complete(),

        -- Close completion options
        ["<C-a>"] = cmp.mapping.abort(),

        -- Stop completion and go back to the original text
        ["<C-c>"] = cmp.mapping.close(),

        -- Move to [N]ext item in completion menue
        ["<C-n>"] = cmp.mapping(cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }), { "i" }),

        -- Move to previous item in completion menu
        ["<C-e>"] = cmp.mapping(cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }), { "i" }),

        -- Scrolling [U]p / back
        ["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i" }),

        -- Scrolling [D]own / forward
        ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i" }),

        -- Confirm selection: Safely select entries
        -- * If nothing is selected (including preselections) add a newline as usual.
        -- * If something has explicitly been selected by the user, select it.
        --
        -- Alternative could use
        -- * <CR>  (Confirm)        as cmp.ConfirmBehavior.Insert
        -- * <C-y> (Confirm [Y]es ) as cmp.ConfirmBehavior.Replace
        ["<CR>"] = cmp.mapping({
          i = function(fallback)
            if cmp.visible() and cmp.get_active_entry() then
              cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
            else
              fallback()
            end
          end,
          s = cmp.mapping.confirm({ select = true }),
        }),
      }

      cmp.setup({
        -- Enable luasnip to handle snippet expansion for nvim-cmp
        snippet = {
          expand = function(args)
            vim.snippet.expand(args.body)
          end,
        },

        mapping = default_mappings,
        sources = {
          { name = "buffer", keyword_length = 5 },
          { name = "luasnip" },
          { name = "nvim_lsp" },
          { name = "path" },
        },
        formatting = {
          format = lspkind.cmp_format({
            maxwidth = 50,
            ellipsis_char = "...",
          }),
        },
      })
    end,
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    dependencies = {
      { "hrsh7th/nvim-cmp" },
    },
    config = function()
      local npairs = require("nvim-autopairs")
      npairs.setup({})

      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      local cmp = require("cmp")
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
  },
}
