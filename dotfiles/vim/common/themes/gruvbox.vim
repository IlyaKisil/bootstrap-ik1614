" ############################################
" ###       THIS CONFIG IS SYMLINKED       ###
" ###    DONT' ENTER ANY SENSITIVE INFO    ###
" ###                                      ###
" ###  USE LOCAL CONFIG FOR MODIFICATIONS  ###
" ### UNLESS CHANGES WILL BECOME PERMANENT ###
" ############################################

" https://github.com/morhetz/gruvbox/wiki/Terminal-specific#1-italics-is-disabled
let g:gruvbox_italic=1
let g:gruvbox_invert_selection = '0'

colorscheme gruvbox
set background=dark

" Support for true color
if (has("nvim"))
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

if (has("termguicolors"))
    set termguicolors
endif

highlight SignColumn guibg=#3a3a3a
