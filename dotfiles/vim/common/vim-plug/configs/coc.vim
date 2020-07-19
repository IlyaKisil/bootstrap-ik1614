" ############################################
" ###       THIS CONFIG IS SYMLINKED       ###
" ###    DONT' ENTER ANY SENSITIVE INFO    ###
" ###                                      ###
" ###  USE LOCAL CONFIG FOR MODIFICATIONS  ###
" ### UNLESS CHANGES WILL BECOME PERMANENT ###
" ############################################

fun! GoCoc()
    " Use <tab> for trigger completion and navigate to the next complete item
    inoremap <buffer> <silent><expr> <TAB>
        \ pumvisible() ? "\<C-n>" :
        \ <SID>check_back_space() ? "\<TAB>" :
        \ coc#refresh()
    " Use <S-Tab> to navigate backwards in completion list
    inoremap <buffer> <expr><S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

    " Use <CR> to confirm completion, NOTE: don't really need this since you can jsut
    inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

    " Use <C-space> for trigger completion. TODO: need to remap to something else as I use this as TMUX prefix
    "inoremap <buffer> <silent><expr> <C-space> coc#refresh()

    " GoTo code navigation.
    nmap <buffer> <leader>gd <Plug>(coc-definition)
    nmap <buffer> <leader>gy <Plug>(coc-type-definition)
    nmap <buffer> <leader>gi <Plug>(coc-implementation)
    nmap <buffer> <leader>gr <Plug>(coc-references)
    nnoremap <buffer> <leader>cr :CocRestart
endfun
autocmd FileType * :call GoCoc()
