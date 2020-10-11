" ############################################
" ###       THIS CONFIG IS SYMLINKED       ###
" ###    DONT' ENTER ANY SENSITIVE INFO    ###
" ###                                      ###
" ###  USE LOCAL CONFIG FOR MODIFICATIONS  ###
" ### UNLESS CHANGES WILL BECOME PERMANENT ###
" ############################################

" Most of this config comes from 'vim-go' tutorial available at
" https://github.com/fatih/vim-go/wiki/Tutorial#quick-setup

" run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>
autocmd FileType go nmap <leader>rr  <Plug>(go-run)
autocmd FileType go nmap <leader>tt  <Plug>(go-test)
" Run test function under the cursor (it is sufficient to be within it's scope)
autocmd FileType go nmap <leader>tf  <Plug>(go-test-func)


" Toggle inline coverage, which is a combination of 'GoCoverage' and 'GoCoverageClear'
autocmd FileType go nmap <leader>tc <Plug>(go-coverage-toggle)


" Close quickfix window
autocmd FileType go nnoremap <leader>q :cclose<CR>

let g:go_list_type = "quickfix"


" Autoformatting on save that also fixes imports. But be aware that it might
" be slow on a large project
let g:go_fmt_command = "goimports"


" Keep comments/docstings as a part of of function declaration when used with
" text object motions, e.g. 'vaf', 'vif'
let g:go_textobj_include_function_doc = 1


" Syntax highlighting. For more options check out ':help go-settings'
let g:go_highlight_types = 1
" let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
" let g:go_highlight_function_calls = 1
" let g:go_highlight_operators = 1
" let g:go_highlight_build_constraints = 1
