vim.g.go_list_type = "quickfix"

-- " Keep comments/docstings as a part of of function declaration when used with
-- " text object motions, e.g. 'vaf', 'vif'
vim.g.go_textobj_include_function_doc = 1


-- " Syntax highlighting. For more options check out ':help go-settings'
vim.g.go_highlight_types = 1
-- vim.g.go_highlight_fields = 1
vim.g.go_highlight_functions = 1
-- vim.g.go_highlight_function_calls = 1
-- vim.g.go_highlight_operators = 1
-- vim.g.go_highlight_build_constraints = 1

-- Autoformatting on save that also fixes imports. But be aware that it might
-- be slow on a large project
vim.g.go_fmt_command = "goimports"

-- NOTE: For some reason when these are enabled then LSP diagnostics will disappear
-- upon saving a file. For more info https://github.com/fatih/vim-go/issues/3264
-- Auto imports and formatting still work even when these are disabled, as this is
-- configured as a part of standard setup of native LSP.
vim.g.go_fmt_autosave = 0
-- vim.g.go_imports_autosave = 0

vim.cmd([[
augroup ik1614_go
    autocmd!
    autocmd FileType go nmap <buffer> <leader>rr <Plug>(go-run-vertical)
    autocmd FileType go nmap <buffer> <leader>rv <Plug>(go-run-vertical)
    autocmd FileType go nmap <buffer> <leader>rt <Plug>(go-test)
    autocmd FileType go nmap <buffer> <leader>rT <Plug>(go-test-func)
    autocmd FileType godoc nmap <buffer> q :q<CR>
augroup END
]])
