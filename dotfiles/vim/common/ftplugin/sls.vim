" ############################################
" ###       THIS CONFIG IS SYMLINKED       ###
" ###    DONT' ENTER ANY SENSITIVE INFO    ###
" ###                                      ###
" ###  USE LOCAL CONFIG FOR MODIFICATIONS  ###
" ### UNLESS CHANGES WILL BECOME PERMANENT ###
" ############################################

setlocal expandtab
setlocal autoindent
setlocal softtabstop=2
setlocal tabstop=2
setlocal shiftwidth=2
setlocal colorcolumn=90

" Add header with some basic stuff
call functions#add_file_header([
            \ '## -*- coding: utf-8 -*-',
            \ "## vim" . ": ft=sls softtabstop=2 tabstop=2 shiftwidth=2 expandtab autoindent cc=90",
            \ ])
