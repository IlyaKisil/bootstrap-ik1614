local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local fmt = require("luasnip.extras.fmt").fmt

return {
  s(
      {
         trig = "here",
         dscr = "Get the full path to location of current script"
      },
      t([[HERE="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"]])
   ),
  s(
      {
         trig = "repo-home",
         dscr = "Get absolute path for current git repo"
      },
      t([[GIT_REPO_HOME="$(git rev-parse --show-toplevel)"]])
   ),
  s(
      {
         trig = "codebase",
         dscr = "Get name of git repo"
      },
      t([[CODEBASE="$(basename "$(git remote get-url origin)" .git)"]])
   ),
  s(
      {
         trig = "now",
         dscr = "Get current time"
      },
      t([[NOW="$(date +"%Y-%m-%dT%H:%M:%S")"]])
   ),
  s(
      {
         trig = "base-minimal",
         dscr = "Add shebang and basic options"
      },
      fmt([[
         #!/usr/bin/env bash
         # vim: ft=sh softtabstop=2 tabstop=2 shiftwidth=2 expandtab autoindent cc=90

         set -euo pipefail

         . import_blockchain_module utils

      ]], {})
   ),
}
