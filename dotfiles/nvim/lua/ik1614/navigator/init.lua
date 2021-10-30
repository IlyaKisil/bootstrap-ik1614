-- NOTE: Currently I use it only to hookup LSP, although I have my own thing as well.
local navigator = require('navigator')

navigator.setup({
    width = 1, -- max width ratio (number of cols for the floating window) / (window width)
    height = 1, -- max list window height, 0.3 by default
    preview_height = 1, -- max height of preview windows
    preview_lines_before = 5,
    preview_lines = 100,
    transparency = 50,
    lsp_installer = true,
    lsp = {
        diagnostic_virtual_text = false,
        code_lens = false,
        diagnostic_scrollbar_sign = nil,
    },
    icons = {
        icons = false,
        diagnostic_err = 'E',
        diagnostic_warn = 'W',
        diagnostic_info = 'I',
        diagnostic_hint = 'H',
    },
    default_mapping = false,
    keymaps = {
      -- {key = "gr", func = "references()"},
      -- {key = "<c-k>", func = "signature_help()"},
      -- {key = "g0", func = "document_symbol()"},
      -- {key = "gW", func = "workspace_symbol()"},
      -- {key = "<c-]>", func = "definition()"},
      -- {key = "gD", func = "declaration({ border = 'rounded', max_width = 80 })"},
      -- {key = "gp", func = "require('navigator.definition').definition_preview()"},
      -- {key = "gT", func = "require('navigator.treesitter').buf_ts()"},
      -- {key = "<Leader>gT", func = "require('navigator.treesitter').bufs_ts()"},
      -- {key = "K", func = "hover({ popup_opts = { border = single, max_width = 80 }})"},
      -- {key = "<leader>sa", mode = "n", func = "require('navigator.codeAction').code_action()"},
      -- {key = "<Space>cA", mode = "v", func = "range_code_action()"},
      -- {key = "<Leader>re", func = "rename()"},
      -- {key = "<Space>rn", func = "require('navigator.rename').rename()"},
      -- {key = "<Leader>gi", func = "incoming_calls()"},
      -- {key = "<Leader>go", func = "outgoing_calls()"},
      -- {key = "gi", func = "implementation()"},
      -- {key = "<Space>D", func = "type_definition()"},
      -- {key = "gL", func = "require('navigator.diagnostics').show_line_diagnostics()"},
      -- {key = "gG", func = "require('navigator.diagnostics').show_diagnostic()"},
      -- {key = "]d", func = "diagnostic.goto_next({ border = 'rounded', max_width = 80})"},
      -- {key = "[d", func = "diagnostic.goto_prev({ border = 'rounded', max_width = 80})"},
      -- {key = "]r", func = "require('navigator.treesitter').goto_next_usage()"},
      -- {key = "[r", func = "require('navigator.treesitter').goto_previous_usage()"},
      -- {key = "<C-LeftMouse>", func = "definition()"},
      -- {key = "g<LeftMouse>", func = "implementation()"},
      -- {key = "<Leader>k", func = "require('navigator.dochighlight').hi_symbol()"},
      -- {key = '<Space>wa', func = 'add_workspace_folder()'},
      -- {key = '<Space>wr', func = 'remove_workspace_folder()'},
      -- {key = '<Space>ff', func = 'formatting()', mode='n'},
      -- {key = '<Space>ff', func = 'range_formatting()', mode='v'},
      -- {key = '<Space>wl', func = 'print(vim.inspect(vim.lsp.buf.list_workspace_folders()))'},
      -- {key = "<Space>la", mode = "n", func = "require('navigator.codelens').run_action()"},
    }
})
