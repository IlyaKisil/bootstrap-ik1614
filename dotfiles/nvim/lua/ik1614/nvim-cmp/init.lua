vim.o.completeopt = "menuone,noselect"

local cmp = require("cmp")

cmp.setup({
  snippet = {
    expand = function(args)
      -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      -- require'snippy'.expand_snippet(args.body) -- For `snippy` users.
    end,
  },
  mapping = {
    ["<C-u>"] = cmp.mapping.scroll_docs(-4), -- Once again scropplin is a bit backwards
    ["<C-d>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
    ["<C-e>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
    -- ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
    -- ["<C-e>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
    -- ["<C-e>"] = cmp.mapping.close(),
    ["<C-q>"] = cmp.mapping.close(),
    ["<C-a>"] = cmp.mapping.abort(),
    ["<CR>"] = cmp.mapping.confirm({
      select = true,
      -- behavior = cmp.ConfirmBehavior.Replace,
    }),
  },
  sources = {
    { name = "nvim_lsp" },
    { name = "buffer", keyword_length = 5 },
    { name = "path" },
    -- { name = 'vsnip' }, -- For vsnip users.
    -- { name = 'luasnip' }, -- For luasnip users.
    { name = 'ultisnips' }, -- For ultisnips users. -- FIXME: Doesn't work :cry:
    -- { name = 'snippy' }, -- For snippy users.
  },
  formatting = {
    format = require("ik1614.lsp.kind").cmp_format(),
  },
  documentation = {
    border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
  },
  experimental = {
    -- ghost_text = {
    --   hl_group = "CodeGhost",
    --   -- hl_group = "LineNr",
    --   -- hl_group = "Comment", -- This make it hard to type comments :rofl:
    -- },
  },
})
