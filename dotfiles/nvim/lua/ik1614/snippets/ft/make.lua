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
      t([[HERE = $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))]])
   ),
  s(
      {
         trig = "repo-home",
         dscr = "Get absolute path for current git repo"
      },
      t([[GIT_REPO_HOME = $(shell git rev-parse --show-toplevel)]])
   ),
  s(
      {
         trig = "codebase",
         dscr = "Get name of git repo"
      },
      t([[CODEBASE = $(shell git remote get-url origin | rev | cut -d '/' -f1 | rev | cut -d '.' -f1)]])
   ),
  s(
      {
         trig = "now",
         dscr = "Get current time"
      },
      t([[NOW = $(shell date +%Y-%m-%dT%H:%M:%S)]])
   ),
  s(
      {
         trig = "base-minimal",
         dscr = "Boilerplate for any new Makefile"
      },
      fmt([[
        .DEFAULT_GOAL := help
        .DELETE_ON_ERROR:
        # Use a single shell for the whole recipe
        .ONESHELL:

        SHELL      = /bin/bash -o errexit -o nounset -o pipefail
        MAKEFLAGS += --warn-undefined-variables
        MAKEFLAGS += --no-builtin-rules

        ifeq ($(shell uname), Darwin)
          GOOS = "darwin"
          SED = sed -i ''
        else ifeq ($(shell uname), Linux)
          GOOS = "linux"
          SED = sed -i
        endif

        HERE  = $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))

      ]], {})
   ),
  -- FIXME: Need to escape brakets within the snippet content
  --s(
  --    {
  --       trig = "toc",
  --       dscr = "Create target for updating readme with 'doctoc'"
  --    },
  --    fmt([[
  --      .PHONY: update-readme-toc

  --      define README_TOC_TITLE
  --      Table of Contents
  --      -----------------
  --      Generated with [DocToc](https://github.com/thlorenz/doctoc)

  --      Last Update: $(shell date +%Y-%m-%d)
  --      endef
  --      export README_TOC_TITLE
  --      ## Update table of contents only for staged 'README.md' known to git. Requires 'doctoc' to be installed
  --      update-readme-toc:
  --      	@git diff --name-only --cached \
  --      		| grep README.md \
  --      		| xargs -I FILE sh -c '{ doctoc --github --title "$${README_TOC_TITLE}" FILE && git add FILE; }'
  --    ]], {})
  -- ),
}

