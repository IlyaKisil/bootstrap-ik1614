return {
  {
    "L3MON4D3/LuaSnip",
    opts = function(_, opts)
      -- TODO: switch path to snippets to some variable or something
      require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/lua/ik1614/snippets/luasnip" })

      -- This one is cool cause if you have dynamic snippets, it updates as you type!
      opts.updateevents = "TextChanged,TextChangedI"

      -- This will expand/trigger snippets once you fully type the trigger.
      opts.enable_autosnippets = false

      -- Crazy highlights!!
      -- https://www.youtube.com/watch?v=Dn800rlPIho&t=7m52s
      -- https://www.youtube.com/watch?v=KtQZRAkgLqo
      local types = require("luasnip.util.types")
      opts.ext_opts = {
        [types.insertNode] = {
          unvisited = {
            hl_group = "IncSearch",
          },
        },
        [types.choiceNode] = {
          active = {
            virt_text = { { " « choice node ", "DiagnosticVirtualTextHint" } },
          },
        },
      }
    end,
  },
}
