local utils = require("ik1614.functions.utils")
local plugin_name = "colorizer"

if not utils:plugin_installed(plugin_name) then
  return
end

local plugin = require(plugin_name)

plugin.setup(
  {
    -- filetypes
    '*'
  },
  {
    -- Default options
    RGB      = true;    -- #RGB hex codes
    RRGGBB   = true;    -- #RRGGBB hex codes
    names    = false;   -- "Name" codes like Blue
    RRGGBBAA = false;   -- #RRGGBBAA hex codes
    rgb_fn   = false;   -- CSS rgb() and rgba() functions
    hsl_fn   = false;   -- CSS hsl() and hsla() functions
    css      = false;   -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
    css_fn   = false;   -- Enable all CSS *functions*: rgb_fn, hsl_fn

    -- Available modes: foreground, background
    mode = 'background'; -- Set the display mode.
  }
)
