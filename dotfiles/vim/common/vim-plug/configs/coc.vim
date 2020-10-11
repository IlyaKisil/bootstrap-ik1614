" ############################################
" ###       THIS CONFIG IS SYMLINKED       ###
" ###    DONT' ENTER ANY SENSITIVE INFO    ###
" ###                                      ###
" ###  USE LOCAL CONFIG FOR MODIFICATIONS  ###
" ### UNLESS CHANGES WILL BECOME PERMANENT ###
" ############################################

" Incase you want to use different IntelliSence like implementations, then
" consider to surround these settings into a function and apply it to
" corresponging files, e.g.
" fun! GoCoc()
"    config goes here
" endfun
" autocmd FileType * :call GoCoc()

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
    \ 'coc-emoji',
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

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
" Inside/Around Function
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
" Inside/Around Class
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of LS, ex: coc-tsserver
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)


"-------- Code navigation
nmap <silent> <leader>gd <Plug>(coc-definition)
nmap <silent> <leader>gy <Plug>(coc-type-definition)
nmap <silent> <leader>gi <Plug>(coc-implementation)
nmap <silent> <leader>gr <Plug>(coc-references)
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> gn <Plug>(coc-diagnostic-next)
nmap <silent> gk <Plug>(coc-diagnostic-prev)


"-------- IntelliSence like features `<leader>i ...`
" Formatting selected code.
xmap <leader>if <Plug>(coc-format-selected)
nmap <leader>if <Plug>(coc-format-selected)

" Symbol renaming/refactoring
nmap <silent> <leader>rn <Plug>(coc-rename)
nmap <silent> <leader>rR <Plug>(coc-refactor)

" Show documentation in preview window.
nnoremap <silent> <leader>sd :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Suggestions/action for current word under the cursor. Potentially, can
" use just 'g@' in which case, will need to provide textobjects/motions, e.g
" `<leader>isap` -> suggestion around paragraph. However, I would pefer to
" do that via visualmode instead
nmap <silent> <leader>sa :<C-u>set operatorfunc=<SID>cocActionsOpenFromSelected<CR>g@w
xmap <silent> <leader>sa :<C-u>execute 'CocCommand actions.open ' . visualmode()<CR>
function! s:cocActionsOpenFromSelected(type) abort
    " Suggestions to fix things (code actions) as a popup instead of a new pane/buffer
    " You can use, '<Plug>(coc-codeaction-selected)' or '<Plug>(coc-codeaction)' if
    " you want it in a new buffer
    execute 'CocCommand actions.open ' . a:type
endfunction
" Apply AutoFix to problem on the current line. However, it is hard to
" tell what that fix is gonna be :shrug:
" nmap <leader>isf  <Plug>(coc-fix-current)
" nnoremap <silent><nowait> <leader>ian  :<C-u>CocNext<CR>
" nnoremap <silent><nowait> <leader>iak  :<C-u>CocPrev<CR>


"-------- Mappings for CoCList `<leader>c ...`
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
