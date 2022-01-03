" ############################################
" ###       THIS CONFIG IS SYMLINKED       ###
" ###    DONT' ENTER ANY SENSITIVE INFO    ###
" ###                                      ###
" ###  USE LOCAL CONFIG FOR MODIFICATIONS  ###
" ### UNLESS CHANGES WILL BECOME PERMANENT ###
" ############################################

" Open Diff agains the last commit in a new tab
" command! GdiffInTab tabedit %|Gvdiff HEAD

" Open main page of git integration in a new tab. Also need to close empty
" window that appears above (using defaut vim mappings)
command! GitInTab tabedit 'vim-fugitive'| Git | wincmd k | wincmd q
