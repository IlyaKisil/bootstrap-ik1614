local f = require("ik1614.functions")
local plugin = f.utils:load_plugin("cmp")

if not plugin then
  return
end


plugin.setup({
  snippet = {
    expand = function(args)
      -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      -- require'snippy'.expand_snippet(args.body) -- For `snippy` users.
    end,
  },
  mapping = {
    ["<C-u>"] = plugin.mapping.scroll_docs(-4), -- Once again scropplin is a bit backwards
    ["<C-d>"] = plugin.mapping.scroll_docs(4),
    ["<C-Space>"] = plugin.mapping.complete(),
    ["<C-n>"] = plugin.mapping.select_next_item({ behavior = plugin.SelectBehavior.Select }),
    ["<C-e>"] = plugin.mapping.select_prev_item({ behavior = plugin.SelectBehavior.Select }),
    -- ["<C-n>"] = plugin.mapping.select_next_item({ behavior = plugin.SelectBehavior.Insert }),
    -- ["<C-e>"] = plugin.mapping.select_prev_item({ behavior = plugin.SelectBehavior.Insert }),
    -- ["<C-e>"] = plugin.mapping.close(),
    ["<C-q>"] = plugin.mapping.close(),
    ["<C-a>"] = plugin.mapping.abort(),
    ["<CR>"] = plugin.mapping.confirm({
      select = true,
      -- behavior = plugin.ConfirmBehavior.Replace,
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
    format = function(_entry, vim_item)
      local icons = {
        Class = " ",
        Color = " ",
        Constant = " ",
        Constructor = " ",
        Enum = "了 ",
        EnumMember = " ",
        Field = " ",
        File = " ",
        Folder = " ",
        Function = " ",
        Interface = "ﰮ ",
        Keyword = " ",
        Method = "ƒ ",
        Module = " ",
        Property = " ",
        Snippet = "﬌ ",
        Struct = " ",
        Text = " ",
        Unit = " ",
        Value = " ",
        Variable = " ",
      }
      if icons[vim_item.kind] then
        vim_item.kind = icons[vim_item.kind] .. vim_item.kind
      end
      return vim_item
    end,
  },
  window = {
    documentation = {
      border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
    },
  },
  experimental = {
    -- ghost_text = {
    --   hl_group = "CodeGhost",
    --   -- hl_group = "LineNr",
    --   -- hl_group = "Comment", -- This make it hard to type comments :rofl:
    -- },
  },
})
