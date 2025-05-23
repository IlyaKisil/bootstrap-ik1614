local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local fmt = require("luasnip.extras.fmt").fmt

return {
  s({
    trig = "here",
    dscr = "Get the full path to location of current script",
  }, t([[HERE = os.path.dirname(os.path.realpath(__file__))]])),
  s({
    trig = "now",
    dscr = "Get current time",
  }, t([[NOW = datetime.now().replace(microsecond=0).isoformat()]])),
  s(
    {
      trig = "base-uv",
      dscr = "Add basics for 'uv' based script",
    },
    fmt(
      [[
        #!/usr/bin/env -S uv run --script
        # /// script
        # requires-python = ">=3.13"
        # dependencies = [
        # ]
        # ///
        #

      ]],
      {}
    )
  ),
}
