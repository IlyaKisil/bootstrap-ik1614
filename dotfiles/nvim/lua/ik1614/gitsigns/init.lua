require('gitsigns').setup {
  signs = {
    -- NOTE: somehow it picks up correct colors from 'mdracula'. I think it just uses
    -- custom HL groups, e.g. 'GitChangeStripe'. Although not sure why :shrug:
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
  watch_index = {
    interval = 1000
  },
  sign_priority = 6,
  update_debounce = 200,
  status_formatter = nil, -- Use default
  use_decoration_api = false
}
