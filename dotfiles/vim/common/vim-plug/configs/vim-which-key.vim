" ############################################
" ###       THIS CONFIG IS SYMLINKED       ###
" ###    DONT' ENTER ANY SENSITIVE INFO    ###
" ###                                      ###
" ###  USE LOCAL CONFIG FOR MODIFICATIONS  ###
" ### UNLESS CHANGES WILL BECOME PERMANENT ###
" ############################################

let g:which_key_timeout = 100

" Define a separator
let g:which_key_sep = '→'

" Not a fan of floating windows for this
let g:which_key_use_floating_win = 0
let g:which_key_max_size = 0


nnoremap <silent> <leader><leader>           :<c-u>WhichKey '<Space>'<CR>
vnoremap <silent> <leader><leader>           :<c-u>WhichKeyVisual '<Space>'<CR>
nnoremap <silent> <localleader><localleader> :<c-u>WhichKey  '\'<CR>

" Create map to add keys to
let g:which_key_map =  {}


let g:which_key_map['?'] = [ 'Maps', 'show-keybindings' ]


" Group mappings

" a is for actions {{{
let g:which_key_map.a = {
      \ 'name' : 'actions' ,
      \ 'c' : [':ColorizerToggle'        , 'colorizer'],
      \ 'e' : [':CocCommand explorer'    , 'explorer'],
      \ }
" }}}

" Register which key map
call which_key#register('<Space>', "g:which_key_map")
