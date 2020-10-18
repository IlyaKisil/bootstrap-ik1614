" ############################################
" ###       THIS CONFIG IS SYMLINKED       ###
" ###    DONT' ENTER ANY SENSITIVE INFO    ###
" ###                                      ###
" ###  USE LOCAL CONFIG FOR MODIFICATIONS  ###
" ### UNLESS CHANGES WILL BECOME PERMANENT ###
" ############################################

setlocal colorcolumn=90
setlocal textwidth=89

" In general we use 'coc-spell-check'
" set spell
" set spelllang=en_gb

" Break at the end of the word
setlocal linebreak

" Auto Resize paragraphs based on 'textwidth'
"set formatoptions+=a

" Wrap text when exceeding window width (in case it is < textwidth)
setlocal wrap

" Add header with tex and cSpell settings
call functions#add_file_header([
            \ '% !TEX root =',
            \ '% cSpell:ignoreRegExp ^[\s]*%.*',
            \ '% cSpell:ignoreRegExp \\[0-9a-zA-Z]*',
            \ '% cSpell:ignoreRegExp .*\\usepackage.*',
            \ '% cSpell:ignoreRegExp .*\\cite\{[\w:\-,\s]*\}',
            \ '% cSpell:ignoreRegExp .*\\c?ref\{[\w:\-]*\}',
            \ '% cSpell:ignoreRegExp .*\\(begin|end){.*}.*',
            \ ])
