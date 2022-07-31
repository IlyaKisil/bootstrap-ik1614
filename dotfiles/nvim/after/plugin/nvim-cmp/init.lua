local utils = require("ik1614.utils")
local plugin_name = "cmp"

if not utils.plugin_installed(plugin_name) then
  return
end

local plugin = require(plugin_name)

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
    format = require("ik1614.lsp.kind").cmp_format(),
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
