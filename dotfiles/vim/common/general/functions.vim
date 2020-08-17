" ############################################
" ###       THIS CONFIG IS SYMLINKED       ###
" ###    DONT' ENTER ANY SENSITIVE INFO    ###
" ###                                      ###
" ###  USE LOCAL CONFIG FOR MODIFICATIONS  ###
" ### UNLESS CHANGES WILL BECOME PERMANENT ###
" ############################################

" ============================================================================
" GENERAL FUNCTIONS (not related to plugins)
" ============================================================================
fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun
autocmd BufWritePre * :call TrimWhitespace()


" Turn spellcheck on for markdown files
augroup auto_spellcheck
  autocmd BufNewFile,BufRead *.md setlocal spell
augroup END


" Append encoding and modeline at the top of the file
" References:
" - https://vim.fandom.com/wiki/Modeline_magic
" - https://vi.stackexchange.com/a/4952/30655
" - https://medium.com/@sauravomar01/configure-custom-header-template-in-vim-editor-6d578e440da3
function! AppendSlsModeline()
  let l:encoding = printf("## -*- coding: utf-8 -*-")
  let l:modeline = printf("## vim: ft=sls softtabstop=2 tabstop=2 shiftwidth=2 expandtab autoindent cc=90")
  if (! search(l:encoding))
    call append(0, l:encoding)
  endif
  if (! search(l:modeline))
    call append(1, l:modeline)
  endif
endfunction
autocmd BufNewFile,BufRead *.sls :call AppendSlsModeline()
