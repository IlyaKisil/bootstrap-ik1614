return {
  {
    "https://github.com/lewis6991/gitsigns.nvim",
    enabled = true,
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {},
    config = function()
      require("gitsigns").setup({
        signs = {
          add          = {hl = 'GitSignsAdd'   , text = '▎',  numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'},
          change       = {hl = 'GitSignsChange', text = '▎',  numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
          delete       = {hl = 'GitSignsDelete', text = '__', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
          topdelete    = {hl = 'GitSignsDelete', text = '^^', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
          -- topdelete    = {hl = 'GitSignsDelete', text = '‾‾', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
          changedelete = {hl = 'GitSignsChange', text = '▎',  numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
        },
        numhl = false,  -- highlights the line number
        linehl = false, -- highlights the whole line
        keymaps = {
          -- Default keymap options
          noremap = true,
          buffer = true,
        },
        watch_gitdir = {
          interval = 1000
        },
        sign_priority = 6,
        update_debounce = 200,
        status_formatter = nil, -- Use default
        on_attach = function(bufnr)
          -- This is where keymaps could be set
        end
      })
    end
  }
}
