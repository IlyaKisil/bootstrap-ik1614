" ############################################
" ###       THIS CONFIG IS SYMLINKED       ###
" ###    DONT' ENTER ANY SENSITIVE INFO    ###
" ###                                      ###
" ###  USE LOCAL CONFIG FOR MODIFICATIONS  ###
" ### UNLESS CHANGES WILL BECOME PERMANENT ###
" ############################################

" ============================================================================
" GENERAL FUNCTIONS (not related to plugins or filetypes)
" ============================================================================
fun! functions#TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun


function functions#MakeNonExistingDir(file, buf)
    " Create directory if it doesn't exists
    if empty(getbufvar(a:buf, '&buftype')) && a:file!~#'\v^\w+\:\/'
        let dir=fnamemodify(a:file, ':h')
        if !isdirectory(dir)
            call mkdir(dir, 'p')
        endif
    endif
endfunction


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
