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
" let maplocalleader="\,"

" Don't move cursor
nnoremap <Space> <Nop>

" Map (redraw screen) to also turn off search highlighting until the next search
nnoremap <C-l> :nohl<CR><C-L>


" When you paste over something send that content to 'the black hole register'
vnoremap <leader>p "_dP


" Keep selection after tab adjust
vnoremap < <gv
vnoremap > >gv


" Move cursor through long soft-wrapped lines that doesn't break <count>
noremap <expr> k (v:count == 0 ? 'gk' : 'k')
noremap <expr> j (v:count == 0 ? 'gj' : 'j')


" Use <C-k> to go up within a completion menu. For going down, use default
" binding <C-n>, which is convenient with Colemak layout
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<Up>"
cnoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<Up>"
" inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<Down>"
" cnoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<Down>"


" Loop through quickfix and locations lists
command! Cnext try | cnext | catch | cfirst | catch | endtry
command! Cprev try | cprev | catch | clast  | catch | endtry
command! Lnext try | lnext | catch | lfirst | catch | endtry
command! Lprev try | lprev | catch | llast  | catch | endtry

" Can't use <C-p> as it is reserved for 'fzf'
" Consider using <C-m>, if you reserve <C-k> for pane movement
map <C-k> :Cprev<CR>
map <C-n> :Cnext<CR>

" Since location list is for current buffer, it kind makes sense to
" use local leader for mnemonic, although I'd prefer to have something
" that can be constantly pressed (similar to <C-n>)
map <localleader>k :Lprev<CR>
map <localleader>n :Lnext<CR>

" Convenience for applying macros
nnoremap Q @q

" Movements between tabs
nnoremap <leader>q        :tabclose<CR>
nnoremap <silent> <TAB>   :tabnext<CR>
nnoremap <silent> <S-TAB> :tabprevious<CR>


" Open URL on the current line in a web browser
nnoremap <leader>ow :call functions#OpenURL()<CR>
vnoremap <leader>ow :call functions#OpenURL()<CR>

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
nnoremap n nzzzv
nnoremap N Nzzzv

" Same when moving up and down
noremap <C-d> <C-d>zz
noremap <C-u> <C-u>zz

"make Y consistent with C and D
nnoremap Y y$

" Visual Mode for '*' and '#'. By default it will extend highlighting till the
" next match.
function! s:VSetSearch()
  let temp = @@
  norm! gvy
  let @/ = '\V' . substitute(escape(@@, '\'), '\n', '\\n', 'g')
  let @@ = temp
endfunction

vnoremap * :<C-u>call <SID>VSetSearch()<CR>//<CR><c-o>
vnoremap # :<C-u>call <SID>VSetSearch()<CR>??<CR><c-o>

" Move selection up and down. This will also respect indentation levels
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
