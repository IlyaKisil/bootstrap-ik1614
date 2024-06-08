local ls = require("luasnip")
local s = ls.snippet
local fmt = require("luasnip.extras.fmt").fmta

return {
  s(
      {
         trig = "plugin-setup",
         dscr = "Add boiler plate for setting up a plugin with 'lazy.nvim'"
      },
      fmt([[
        return {
          {
            "__URL_FILL_ME__",
            enabled = true,
            config = function()
              require("___").setup({})
            end
          }
        }
      ]], {})
   ),
}
