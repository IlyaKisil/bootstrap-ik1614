" ############################################
" ###       THIS CONFIG IS SYMLINKED       ###
" ###    DONT' ENTER ANY SENSITIVE INFO    ###
" ###                                      ###
" ###  USE LOCAL CONFIG FOR MODIFICATIONS  ###
" ### UNLESS CHANGES WILL BECOME PERMANENT ###
" ############################################

set t_Co=256

" Support for true color
if (has("nvim"))
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

if (has("termguicolors"))
    set termguicolors
endif

colorscheme gruvbox

" Theme specific settings
if (g:colors_name == 'gruvbox')
    set background=dark
    " https://github.com/morhetz/gruvbox/wiki/Terminal-specific#1-italics-is-disabled
    let g:gruvbox_italic=1
    let g:gruvbox_invert_selection = '0'
    highlight SignColumn guibg=#3a3a3a
elseif (g:colors_name == 'onedark')
    hi Comment cterm=italic
    let g:onedark_hide_endofbuffer=1
    let g:onedark_terminal_italics=1
    let g:onedark_termcolors=256
    if (has("termguicolors"))
        hi LineNr ctermbg=NONE guibg=NONE
    endif
endif

