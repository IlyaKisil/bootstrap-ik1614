local f = require("ik1614.functions")
local cmp = f.utils:load_plugin("cmp")
local luasnip = f.utils:load_plugin("luasnip")

if not cmp or not luasnip then
  return
end

cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = {
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-u>"] = cmp.mapping.scroll_docs(-4), -- Scrolling is a bit backwards
    ["<C-d>"] = cmp.mapping.scroll_docs(4),
    ["<C-q>"] = cmp.mapping.close(), -- Just close completion options
    ["<C-a>"] = cmp.mapping.abort(), -- Stop completion and go back to the original text
    ["<C-e>"]  = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
    ["<C-n>"]  = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
    ["<C-y>"] = cmp.mapping(
      cmp.mapping.confirm{
        behavior = cmp.ConfirmBehavior.Replace,
        select = true,
      },
      { "i", "c" }
    ),
    ["<CR>"] = cmp.mapping(
      cmp.mapping.confirm{
        select = true,
        behavior = cmp.ConfirmBehavior.Insert,
      },
      { "i", "c" }
    ),
    ['<DOWN>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        -- TODO: close popup and make a move.
        -- By default, it will just move you without closing it
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<UP>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        -- TODO: close popup and make a move.
        -- By default, it will just move you without closing it
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  sources = {
    { name = "nvim_lsp" },
    { name = "buffer", keyword_length = 5 },
    { name = "path" },
    { name = 'luasnip' },
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
