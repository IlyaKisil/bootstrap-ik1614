" ############################################
" ###       THIS CONFIG IS SYMLINKED       ###
" ###    DONT' ENTER ANY SENSITIVE INFO    ###
" ###                                      ###
" ###  USE LOCAL CONFIG FOR MODIFICATIONS  ###
" ### UNLESS CHANGES WILL BECOME PERMANENT ###
" ############################################

"let g:airline_powerline_fonts = 0
let g:airline_theme = 'bubblegum'
let g:airline#extensions#whitespace#enabled = 0

" Show all buffers at the top
" let g:airline#extensions#tabline#enabled = 1
" let g:airline#extensions#tabline#formatter = 'default'

" custom airline symbols
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
"let g:airline_left_sep = ''
"let g:airline_left_alt_sep = ''
"let g:airline_right_sep = ''
"let g:airline_right_alt_sep = ''
"let g:airline_symbols.branch = ''  " Powerline symbol
let g:airline_symbols.branch = ''


" remove the filetype and encoding parts
let g:airline_section_x=''
let g:airline_section_y=''
let g:webdevicons_enable_airline_statusline_fileformat_symbols = 0

" remove separators for empty sections
let g:airline_skip_empty_sections = 1

" Disable word count"
let g:airline#extensions#wordcount#enabled = 0

" Show only position of cursor"
let g:airline_section_z = '%l:%v'

" Don't show SPELL"
let g:airline_section_a= airline#section#create(['mode'])

" Shorten current mode symbol
let g:airline_mode_map = {
        \ '__' : '------',
        \ 'c'  : 'C',
        \ 'i'  : 'I',
        \ 'ic' : 'I',
        \ 'ix' : 'I',
        \ 'multi' : 'M',
        \ 'n'  : 'N',
        \ 'ni' : '(I)',
        \ 'no' : 'OP PENDING',
        \ 'R'  : 'R',
        \ 'Rv' : 'V-R',
        \ 's'  : 'S',
        \ 'S'  : 'S-LINE',
        \ '' : 'S-BLOCK',
        \ 't'  : 'TERMINAL',
        \ 'v'  : 'V',
        \ 'V'  : 'V-L',
        \ '' : 'V-B',
        \ }

" Don't show mode in commad window, e.g. -- INSERT --
set noshowmode

