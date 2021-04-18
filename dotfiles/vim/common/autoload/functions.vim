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


function! functions#UpdateTodoKeywords(...)
    " Extend default highlight group (in this case it is 'Todo' group.
    " Reference: https://vi.stackexchange.com/a/19043/30655
    let newKeywords = join(a:000, " ")
    let synTodo = map(filter(split(execute("syntax list"), '\n') , { i,v -> match(v, '^\w*Todo\>') == 0}), {i,v -> substitute(v, ' .*$', '', '')})
    for synGrp in synTodo
        execute "syntax keyword " . synGrp . " contained " . newKeywords
    endfor
endfunction


function! functions#OpenURL()
    " Open URL found on the current line
    let line = getline(".")
    let uri = matchstr(line, '[a-z]*:\/\/[^ >,;:]*')
    if uri != ""
        let uri = substitute(uri, "'", '', '')
        let uri = substitute(uri, '"', '', '')
        echom "Found " . uri
        let uri = escape(uri, "#?&;|%")
        " Todo: Potentially need to extend bey
        if has('macunix')
            silent exec "!open '" . uri . "'"
        else
            echom "Don't know how to open " . uri
        endif
    else
        echom "No URI found in line."
    endif
endfunction


function! functions#save_and_exec() abort
  if &filetype == 'vim'
    :silent! write
    :source %
  elseif &filetype == 'lua'
    :silent! write
    :luafile %
  endif
  return
endfunction


function! functions#exec_current_line() abort
  if &ft == 'lua'
    execute(printf(":lua %s", getline(".")))
  elseif &ft == 'vim'
    exe getline(">")
  endif
endfunction


" Utility for using '*' and '#' for a selected region
function! functions#visual_selection_search()
  let temp = @@
  norm! gvy
  let @/ = '\V' . substitute(escape(@@, '\'), '\n', '\\n', 'g')
  let @@ = temp
endfunction


" Utility for creating highlight groups
function! functions#HL(group, fg, ...)
  " arguments: group, fg, bg, style
  if a:0 >= 1
    let bg=a:1
  else
    let bg=g:ik1614_color_palette.null
  endif
  if a:0 >= 2 && strlen(a:2)
    let style=a:2
  else
    let style='NONE'
  endif
  let hiList = [
    \ 'hi', a:group,
    \ 'ctermfg=' . a:fg[1],
    \ 'guifg=' . a:fg[0],
    \ 'ctermbg=' . bg[1],
    \ 'guibg=' . bg[0],
    \ 'cterm=' . style,
    \ 'gui=' . style
    \ ]
  execute join(hiList)
endfunction

