" Fill sign colum with color instead of showing characters
" Green
highlight GitGutterAdd    guifg=#98bd65 guibg=#98bd65 ctermfg=2 ctermbg=2
" Blue
highlight GitGutterChange guifg=#1c74c7 guibg=#1c74c7 ctermfg=6 ctermbg=6

" But for deleted lines use sign to see where exactly line was removed
" i.e. shows between which lines content was removed
" Use red, but leave background as is
let g:gitgutter_sign_removed = '__'
highlight GitGutterDelete guifg=#ff6b6b ctermfg=1


" TODO: set/find mapping to toggle hunks
" let g:gitgutter_preview_win_floating = 1
