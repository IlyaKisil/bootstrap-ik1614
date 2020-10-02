" ############################################
" ###       THIS CONFIG IS SYMLINKED       ###
" ###    DONT' ENTER ANY SENSITIVE INFO    ###
" ###                                      ###
" ###  USE LOCAL CONFIG FOR MODIFICATIONS  ###
" ### UNLESS CHANGES WILL BECOME PERMANENT ###
" ############################################

fun! GoCoc()

    " Change location where to look for a global config file (`coc-settings.json`)
    " It is easier to keep it compatible between vim and nvim, while keeping their
    " config directories clean
    "let g:coc_config_home="$HOME/.config/coc"

    " List of extensions that will be installed automatically if they are
    " missing. Potentially can make vim-plug to do this
    let g:coc_global_extensions=[
        \ 'coc-json',
        \ 'coc-yaml',
        \ 'coc-python',
        \ 'coc-snippets',
        \ 'coc-sh',
        \ 'coc-texlab',
        \ 'coc-go',
        \ 'coc-spell-checker',
        \ 'coc-actions',
        \ ]

    " Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
    " delays and poor user experience.
    set updatetime=300

    " Don't pass messages to |ins-completion-menu|.
    set shortmess+=c

    " Always show the signcolumn, otherwise it would shift the text each time
    " diagnostics appear/become resolved.
    if has("patch-8.1.1564")
      " Recently vim can merge signcolumn and number column into one
      set signcolumn=number
    else
      set signcolumn=yes
    endif

    " Highlight the symbol and its references when holding the cursor.
    autocmd CursorHold * silent call CocActionAsync('highlight')

    " Add `:Format` command to format current buffer.
    command! -nargs=0 Format :call CocAction('format')

    " Add `:Fold` command to fold current buffer.
    command! -nargs=? Fold :call     CocAction('fold', <f-args>)

    " Add `:OR` command for organize imports of the current buffer.
    command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

    " Add (Neo)Vim's native statusline support.
    " NOTE: Please see `:h coc-status` for integrations with external plugins that
    " provide custom statusline: lightline.vim, vim-airline.
    set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

    augroup mygroup
      autocmd!
      " Setup formatexpr specified filetype(s).
      autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
      " Update signature help on jump placeholder.
      autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
    augroup end

    "========================================
    "=============   MAPPINGS   =============
    "========================================
    " Use <c-space> to trigger completion.
    if has('nvim')
      inoremap <silent><expr> <c-space> coc#refresh()
    else
      inoremap <silent><expr> <c-@> coc#refresh()
    endif

    " function! s:check_back_space() abort
    "   let col = col('.') - 1
    "   return !col || getline('.')[col - 1]  =~# '\s'
    " endfunction
    " Use <tab> for trigger completion and navigate to the next complete item
    " inoremap <buffer> <silent><expr> <TAB>
    "     \ pumvisible() ? "\<C-n>" :
    "     \ <SID>check_back_space() ? "\<TAB>" :
    "     \ coc#refresh()
    " Use <S-Tab> to navigate backwards in completion list
    " inoremap <buffer> <expr><S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

    " Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
    " position. Coc only does snippet and additional edit on confirm.
    " <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
    if exists('*complete_info')
      inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
    else
      inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
    endif

    " Applying codeAction to the selected region.
    " Example: `<leader>aap` for current paragraph
    " xmap <leader>a  <Plug>(coc-codeaction-selected)
    " nmap <leader>a  <Plug>(coc-codeaction-selected)
    " Use popup instaed of a new pane/buffer
    xmap <silent> <leader>a :<C-u>execute 'CocCommand actions.open ' . visualmode()<CR>
    nmap <silent> <leader>a :<C-u>set operatorfunc=<SID>cocActionsOpenFromSelected<CR>g@
    function! s:cocActionsOpenFromSelected(type) abort
        execute 'CocCommand actions.open ' . a:type
    endfunction

    " Remap keys for applying codeAction to the current buffer.
    nmap <leader>ac  <Plug>(coc-codeaction)
    " Apply AutoFix to problem on the current line.
    nmap <leader>af  <Plug>(coc-fix-current)

    " Use `[g` and `]g` to navigate diagnostics
    " Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
    nmap <silent> [g <Plug>(coc-diagnostic-prev)
    nmap <silent> ]g <Plug>(coc-diagnostic-next)

        " GoTo code navigation.
    " nmap <buffer> <leader>gd <Plug>(coc-definition)
    " nmap <buffer> <leader>gy <Plug>(coc-type-definition)
    " nmap <buffer> <leader>gi <Plug>(coc-implementation)
    " nmap <buffer> <leader>gr <Plug>(coc-references)
    nmap <silent> gd <Plug>(coc-definition)
    nmap <silent> gy <Plug>(coc-type-definition)
    nmap <silent> gi <Plug>(coc-implementation)
    nmap <silent> gr <Plug>(coc-references)

    " Symbol renaming.
    nmap <leader>rn <Plug>(coc-rename)

    " Use K to show documentation in preview window.
    function! s:show_documentation()
      if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
      else
        call CocAction('doHover')
      endif
    endfunction
    nnoremap <silent> K :call <SID>show_documentation()<CR>

    " Map function and class text objects
    " NOTE: Requires 'textDocument.documentSymbol' support from the language server.
    xmap if <Plug>(coc-funcobj-i)
    omap if <Plug>(coc-funcobj-i)
    xmap af <Plug>(coc-funcobj-a)
    omap af <Plug>(coc-funcobj-a)
    xmap ic <Plug>(coc-classobj-i)
    omap ic <Plug>(coc-classobj-i)
    xmap ac <Plug>(coc-classobj-a)
    omap ac <Plug>(coc-classobj-a)

    " Use CTRL-S for selections ranges.
    " Requires 'textDocument/selectionRange' support of LS, ex: coc-tsserver
    nmap <silent> <C-s> <Plug>(coc-range-select)
    xmap <silent> <C-s> <Plug>(coc-range-select)

    " Do default action for next item.
    nnoremap <silent><nowait> <leader>cn  :<C-u>CocNext<CR>
    " Do default action for previous item.
    nnoremap <silent><nowait> <leader>cp  :<C-u>CocPrev<CR>

    " Formatting selected code.
    xmap <leader>cf  <Plug>(coc-format-selected)
    nmap <leader>cf  <Plug>(coc-format-selected)

    "-------- Mappings for CoCList
    " Show all diagnostics.
    nnoremap <silent><nowait> <leader>cd  :<C-u>CocList diagnostics<cr>
    " Manage extensions.
    nnoremap <silent><nowait> <leader>ce  :<C-u>CocList extensions<cr>
    " Show commands.
    nnoremap <silent><nowait> <leader>cc  :<C-u>CocList commands<cr>
    " Find symbol of current document.
    nnoremap <silent><nowait> <leader>co  :<C-u>CocList outline<cr>
    " Search workspace symbols.
    nnoremap <silent><nowait> <leader>cs  :<C-u>CocList -I symbols<cr>
    " Resume latest coc list.
    nnoremap <silent><nowait> <leader>cr :<C-u>CocListResume<CR>
endfun
autocmd FileType * :call GoCoc()
