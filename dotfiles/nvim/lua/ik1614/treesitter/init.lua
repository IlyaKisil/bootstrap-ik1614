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
    'fennel',
    'go',
    'html',
    'javascript',
    'json',
    'jsonc',
    'julia',
    'kotlin',
    'latex',
    'lua',
    'ocaml',
    'ocaml_interface',
    'python',
    'regex',
    'rust',
    'teal',
    'toml',
    'typescript',
    'yaml',
    'zig'
  },
  -- NOTE seems to be broken
  ignore_install = {
    "haskell"
  },
  highlight = {
    enable = true -- false will disable the whole extension
  },
  playground = {
    enable = true,
    disable = {},
    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
    persist_queries = false -- Whether the query persists across vim sessions
  },
  indent = {
    enable = true
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

