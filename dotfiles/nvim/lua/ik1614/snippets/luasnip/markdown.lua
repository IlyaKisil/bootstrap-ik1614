local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local fmt = require("luasnip.extras.fmt").fmt

return {
  s(
    {
      trig = "note",
      dscr = "Highlights information that users should take into account",
    },
    fmt(
      [[
        > [!NOTE]
        >
      ]],
      {}
    )
  ),
  s(
    {
      trig = "tip",
      dscr = "Optional information to help a user be more successful",
    },
    fmt(
      [[
        > [!TIP]
        >
      ]],
      {}
    )
  ),
  s(
    {
      trig = "warning",
      dscr = "Critical content demanding immediate user attention due to potential risks",
    },
    fmt(
      [[
        > [!WARNING]
        >
      ]],
      {}
    )
  ),
  s(
    {
      trig = "important",
      dscr = "Crucial information necessary for users to succeed",
    },
    fmt(
      [[
        > [!IMPORTANT]
        >
      ]],
      {}
    )
  ),
  s(
    {
      trig = "caution",
      dscr = "Negative potential consequences of an action",
    },
    fmt(
      [[
        > [!CAUTION]
        >
      ]],
      {}
    )
  ),
  -- FIXME: Need to escape brakets within the snippet content
  -- s(
  --     {
  --        trig = "readme",
  --        dscr = "Add boilerplate for repo readme"
  --     },
  --     fmt([[
  --       [![forthebadge](https://forthebadge.com/images/badges/built-with-love.svg)](https://github.com/IlyaKisil)

  --       <!-- START doctoc generated TOC please keep comment here to allow auto update -->
  --       <!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
  --       <!-- END doctoc generated TOC please keep comment here to allow auto update -->

  --       ## Reporting issues and feature request
  --       Please use one of [these forms](https://github.com/${1:IlyaKisil}/$2/issues/new/choose) which supports `markdown` text formatting. It would also be helpful if you include as much relevant information as possible. This could include screenshots, code snippets etc.
  --     ]], {})
  --  ),
  s(
    {
      trig = "toc",
      dscr = "Add TOC definition for doctoc package",
    },
    fmt(
      [[
        <!-- START doctoc generated TOC please keep comment here to allow auto update -->
        <!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
        <!-- END doctoc generated TOC please keep comment here to allow auto update -->
      ]],
      {}
    )
  ),
  s(
    {
      trig = "toggle-item",
      dscr = "Add toggle/collapsable item",
    },
    fmt(
      [[
        <details>
          <summary>Click to expand :point_down:</summary>
          <p>

          FIXME: Place cursor here after expanding snippet

          </p>
        </details>
      ]],
      {}
    )
  ),
}
