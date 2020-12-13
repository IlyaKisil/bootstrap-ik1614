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

    " Fill sign column with color instead of showing characters
    " Green
    highlight GitGutterAdd    guifg=#98bd65 guibg=#98bd65 ctermfg=2 ctermbg=2
    " Blue
    highlight GitGutterChange       guifg=#135fa8 guibg=#135fa8 ctermfg=6 ctermbg=6
    highlight GitGutterChangeDelete guifg=#135fa8 guibg=#135fa8 ctermfg=6 ctermbg=6

    " But for deleted lines use sign to see where exactly line was removed
    " i.e. shows between which lines content was removed
    " Use red, but leave background to match
    highlight GitGutterDelete guifg=#ff6b6b guibg=#3a3a3a ctermfg=1
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

