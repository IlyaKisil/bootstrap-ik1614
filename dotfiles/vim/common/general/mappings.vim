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
nnoremap <C-l> :nohl<CR><C-L>


" When you paste over something send that content to "the black hole register"
vnoremap <leader>p "_dP


" Keep selection after tab adjust
vnoremap < <gv
vnoremap > >gv


" Move cursor through long soft-wrapped lines that doesn't break <count>
noremap <expr> k (v:count == 0 ? 'gk' : 'k')
noremap <expr> j (v:count == 0 ? 'gj' : 'j')


" Use <C-k> to go up within a comletion menu. For going down, use default
" binding <C-n>, which is convenient with Colemak layout
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<Up>"
cnoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<Up>"
" inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<Down>"
" cnoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<Down>"


" Make cnext, cprevious etc to loop back to the begining
command! Cnext try | cnext | catch | cfirst | catch | endtry
command! Cprev try | cprev | catch | clast | catch | endtry
command! Lnext try | lnext | catch | lfirst | catch | endtry
command! Lprev try | lprev | catch | llast | catch | endtry

map <C-n> :Cnext<CR>
" Can't use <C-p> as it is reserved for 'fzf'
" Consider using <C-m>, if you reserve <C-k> for pane movement
map <C-k> :Cprev<CR>
