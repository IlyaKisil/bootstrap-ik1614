" ############################################
" ###       THIS CONFIG IS SYMLINKED       ###
" ###    DONT' ENTER ANY SENSITIVE INFO    ###
" ###                                      ###
" ###  USE LOCAL CONFIG FOR MODIFICATIONS  ###
" ### UNLESS CHANGES WILL BECOME PERMANENT ###
" ############################################

" (MacOS: if there are problems with displaying vim-devicons, chances are you need to update vim)

map <F3> :NERDTreeToggle<CR>    " toggle nerdtree display
nmap ,t :NERDTreeFind<CR>       " open nerdtree with the current file selected

let NERDTreeShowHidden=1

" Don't show these file types
let NERDTreeIgnore = [
    \ '\.pyc$',
    \ '\.pyo$',
    \ '\py.class$',
    \ '\.egg-info$',
    \ '\.hprof$',
    \ '\.rbc$',
    \ '\.yarb$',
    \ '\.DS_Store$',
    \ '\pycache__$']


" Remove expandable arrow
let NERDTreeDirArrowExpandable = "\u00a0"
let NERDTreeDirArrowCollapsible = "\u00a0"

" Auto refresh on tree focus
function! NERDTreeRefresh()
    if &filetype == "nerdtree"
        silent exe substitute(mapcheck("R"), "<CR>", "", "")
    endif
endfunction

if exists("g:loaded_webdevicons")
    call webdevicons#refresh()
endif
autocmd BufEnter * call NERDTreeRefresh()
