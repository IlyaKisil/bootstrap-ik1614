" ############################################
" ###       THIS CONFIG IS SYMLINKED       ###
" ###    DONT' ENTER ANY SENSITIVE INFO    ###
" ###                                      ###
" ###  USE LOCAL CONFIG FOR MODIFICATIONS  ###
" ### UNLESS CHANGES WILL BECOME PERMANENT ###
" ############################################

" ============================================================================
" GENERAL MAPPINGS (not related to plugins)
" ============================================================================
let mapleader="\<Space>"
let maplocalleader="\\"

" Map (redraw screen) to also turn off search highlighting until the next search
nnoremap <leader>l :nohl<CR><C-L>

" When you paste over something send that content to "the black hole register"
vnoremap <leader>p "_dP

" Keep selection after tab adjust
vnoremap < <gv
vnoremap > >gv
