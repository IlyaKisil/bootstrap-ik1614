return {
  {
    "L3MON4D3/LuaSnip",
    enabled = true,
    dependencies = {},
    build = "make install_jsregexp",
    config = function()
      local ls = require("luasnip")

      vim.snippet.expand = ls.lsp_expand
      vim.snippet.stop = ls.unlink_current

      ---@diagnostic disable-next-line: duplicate-set-field
      vim.snippet.active = function(filter)
        filter = filter or {}
        filter.direction = filter.direction or 1

        if filter.direction == 1 then
          return ls.expand_or_jumpable()
        else
          return ls.jumpable(filter.direction)
        end
      end

      ---@diagnostic disable-next-line: duplicate-set-field
      vim.snippet.jump = function(direction)
        if direction == 1 then
          if ls.expandable() then
            return ls.expand_or_jump()
          else
            return ls.jumpable(1) and ls.jump(1)
          end
        else
          return ls.jumpable(-1) and ls.jump(-1)
        end
      end

      local types = require("luasnip.util.types")

      ls.config.set_config({
        -- This tells LuaSnip to remember to keep around the last snippet.
        -- You can jump back into it even if you move outside of the selection
        history = true,

        -- This one is cool cause if you have dynamic snippets, it updates as you type!
        updateevents = "TextChanged,TextChangedI",

        -- This will expand/trigger snippets once you fully type the trigger.
        -- You would also need to specify something for the
        enable_autosnippets = false,

        -- Crazy highlights!!
        -- https://www.youtube.com/watch?v=Dn800rlPIho&t=7m52s
        -- https://www.youtube.com/watch?v=KtQZRAkgLqo
        ext_opts = {
          [types.insertNode] = {
            unvisited = {
              hl_group = "Visual",
            },
          },
          [types.choiceNode] = {
            active = {
              virt_text = { { " « ", "NonTest" } },
            },
          },
        },
      })

      -- TODO: switch path to snippets to some variable or something
      require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/lua/ik1614/snippets/luasnip" })

      -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
      -- * https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
      -- Alternative could be using Tab and S-Tab, <C-j> for [J]ump, <C-p> for [P]revious
      vim.keymap.set({ "i", "s" }, "<c-i>", function()
        return vim.snippet.active({ direction = 1 }) and vim.snippet.jump(1)
      end, { silent = true })

      vim.keymap.set({ "i", "s" }, "<c-h>", function()
        return vim.snippet.active({ direction = -1 }) and vim.snippet.jump(-1)
      end, { silent = true })

      -- <C-l> is selecting within a list of options. (for [L]ist)
      -- This is useful for choice nodes
      vim.keymap.set("i", "<C-l>", function()
        if ls.choice_active() then
          ls.change_choice(1)
        end
      end)
    end,
  },
}
