" ############################################
" ###       THIS CONFIG IS SYMLINKED       ###
" ###    DONT' ENTER ANY SENSITIVE INFO    ###
" ###                                      ###
" ###  USE LOCAL CONFIG FOR MODIFICATIONS  ###
" ### UNLESS CHANGES WILL BECOME PERMANENT ###
" ############################################

function! functions#add_file_header(lines)
    " Need to reverse so that lines would appear in the
    " same order at the top of the file as they are specified
    " unless file already contains them
    for l:line in reverse(a:lines)
        if (! search(escape(l:line, '\\/.*$^~[]')))
            call append(0, l:line)
        endif
    endfor
endfunction
