" Detect *.tex files as 'tex' instead of 'plaintex'
let g:tex_flavor = 'latex'

" One of the neosnippet plugins will conceal symbols in LaTeX which is confusing
let g:tex_conceal = ""

" Set main TeX file
let b:vimtex_main = 'main.tex'

" For backwards sync (requires pynvim and neovim-remote)
" For more details see *vimtex-faq-skimviewer*
if has('nvim')
    let g:vimtex_compiler_progname = 'nvr'
endif

" Automatically open quickfix window only on errors and make it active
let g:vimtex_quickfix_mode = 2
let g:vimtex_quickfix_open_on_warning = 0

let g:vimtex_quickfix_ignore_filters = [
            \ 'LaTeX Warning: You have requested document class',
            \ 'LaTeX Warning: You have requested package',
            \]

let g:vimtex_compiler_latexmk = {
            \ 'build_dir' : 'build',
            \ 'callback' : 1,
            \ 'continuous' : 0,
            \ 'executable' : 'latexmk',
            \ 'hooks' : [],
            \ 'options' : [
            \   '-verbose',
            \   '-file-line-error',
            \   '-synctex=1',
            \   '-interaction=nonstopmode',
            \ ],
            \}

if has('unix')
    if has('mac')
        let g:vimtex_view_method = "skim"
        let g:vimtex_view_general_viewer = '/Applications/Skim.app/Contents/SharedSupport/displayline'
        let g:vimtex_view_general_options = '-r @line @pdf @tex'
    else
        let g:latex_view_general_viewer = "zathura"
        let g:vimtex_view_method = "zathura"
    endif
elseif has('win32')

endif

" Toggle quickfix window with errors. For some reason ':cclose' doesn't work
autocmd FileType tex nmap <leader>q  <Plug>(vimtex-errors)

" Compile document
autocmd FileType tex nmap <leader>b  <Plug>(vimtex-compile)

" Synctex from source code to document
autocmd FileType tex nmap <leader>v  <Plug>(vimtex-view)
