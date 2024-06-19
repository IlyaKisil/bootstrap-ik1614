local utils = require("ik1614.functions.utils")
local ls = utils:load_plugin("luasnip")

if not ls then
  return
end


local types = require("luasnip.util.types")

ls.config.set_config {
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
        hl_group = "Visual"
      }
    },
    [types.choiceNode] = {
      active = {
        virt_text = { { " « ", "NonTest" } },
      },
    },
  },
}

-- <C-j> is my expansion key (for [J]ump)
-- this will expand the current item or jump to the next item within the snippet.
vim.keymap.set({ "i", "s" }, "<C-j>", function()
  if ls.expand_or_jumpable() then
    ls.expand_or_jump()
  end
end, { silent = true })

-- <C-p> is my jump backwards key (for [P]revious)
-- this always moves to the previous item within the snippet
vim.keymap.set({ "i", "s" }, "<C-p>", function()
  if ls.jumpable(-1) then
    ls.jump(-1)
  end
end, { silent = true })

-- <C-l> is selecting within a list of options. (for [L]ist)
-- This is useful for choice nodes
vim.keymap.set("i", "<C-l>", function()
  if ls.choice_active() then
    ls.change_choice(1)
  end
end)

-- TODO: switch path to snippets to some variable or something
require("luasnip.loaders.from_lua").load({paths = "~/.config/nvim/lua/ik1614/snippets/ft"})

-- NOTE: Needs to be called after defining my own snippets
-- require("luasnip.loaders.from_snipmate").lazy_load()
require("luasnip.loaders.from_vscode").lazy_load({
  include = {
    "gitcommit",
    "go",
    "lua",
    "make",
    "markdown",
    "python",
    "shell",
    "sql",
  }
})


