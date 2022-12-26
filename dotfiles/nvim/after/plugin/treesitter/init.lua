local utils = require("ik1614.functions.utils")
local plugin_name = "nvim-treesitter"

if not utils:plugin_installed(plugin_name) then
  return
end

-- local plugin = require(plugin_name)
-- plugin.setup({})


require'nvim-treesitter.configs'.setup {
  -- ensure_installed = "all", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  ensure_installed = {
    'bash',
    'bibtex',
    'c',
    'c_sharp',
    'clojure',
    'comment',
    'cpp',
    'css',
    'go',
    'html',
    'javascript',
    'json',
    'jsonc',
    'kotlin',
    'latex',
    'lua',
    'python',
    'query',
    'regex',
    'rust',
    'toml',
    'typescript',
    'yaml',
  },
  -- NOTE seems to be broken
  ignore_install = {
    "haskell"
  },
  highlight = {
    enable = true, -- false will disable the whole extension
    -- use_languagetree = false,
    disable = {
      "json", -- breaks for environment.template
      "yaml", -- There is something weird with it as well
      "hcl",
    },
  },
  indent = {
    enable = true
  },
  playground = {
    enable = true,
    disable = {},
    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
    persist_queries = false, -- Whether the query persists across vim sessions
    keybindings = {
      toggle_query_editor = 'o',
      toggle_hl_groups = 'i',
      toggle_injected_languages = 't',
      toggle_anonymous_nodes = 'a',
      toggle_language_display = 'I',
      focus_language = 'f',
      unfocus_language = 'F',
      update = 'R',
      goto_node = '<cr>',
      show_help = '?',
    },
  },
  query_linter = {
    enable = true,
    use_virtual_text = true,
    lint_events = {
      "BufWrite",
      "CursorHold"
    },
  },
  textobjects = {
    select = {
      enable = true,
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
      },
    },
  },
  -- autotag = {
  --     enable = true
  -- },
  -- rainbow = {
  --     enable = true
  -- },
  -- context_commentstring = {
  --     enable = true,
  --     config = {
  --         javascriptreact = {
  --             style_element = '{/*%s*/}'
  --         }
  --     }
  -- }
  -- refactor = {
  --     highlight_definitions = {
  --         enable = true
  --     }
  -- }
}

