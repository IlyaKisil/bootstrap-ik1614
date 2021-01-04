" ############################################
" ###       THIS CONFIG IS SYMLINKED       ###
" ###    DONT' ENTER ANY SENSITIVE INFO    ###
" ###                                      ###
" ###  USE LOCAL CONFIG FOR MODIFICATIONS  ###
" ### UNLESS CHANGES WILL BECOME PERMANENT ###
" ############################################

let g:which_key_timeout = 100

" Define a separator
let g:which_key_sep = '→'

" Not a fan of floating windows for this
let g:which_key_use_floating_win = 0
let g:which_key_max_size = 0

" Don't show status line etc for 'vim-which-key' buffer
autocmd! FileType which_key
autocmd  FileType which_key set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler


nnoremap <silent> <leader><leader>           :<c-u>WhichKey       '<Space>'<CR>
vnoremap <silent> <leader><leader>           :<c-u>WhichKeyVisual '<Space>'<CR>
nnoremap <silent> <localleader><localleader> :<c-u>WhichKey       ','<CR>
vnoremap <silent> <localleader><localleader> :<c-u>WhichKeyVisual ','<CR>

" Create map for leader key
let g:leader_map =  {}
let g:leader_map['?'] = ['Maps', 'show-keybindings']

" Group mappings

" f is for 'Fuzzy Search'
let g:leader_map.f = {
      \ 'name' : '+fzf-find' ,
      \ 'f': ['GFILES',   'Files git'],
      \ 'a': ['FILES',    'All files'],
      \ 'b': ['Buffers',  'Buffers'],
      \ 's': ['SEARCH',   'Search content in all files'],
      \ 'r': ['RG',       'Ripgrep content search'],
      \ 'o': ['LINES',    'Open buffers content search'],
      \ 'c': ['Commands', 'Commands vim'],
      \ 'm': ['Marks',    'Marks'],
      \ }

" g is for 'GIT'
" For resolving merge conflicts we use right/left hand mnemonic
" (letter under index finger, 'n' and 't' for Colemak)
" TODO:
" * Need to double check that conflicts is the same as just showing diff
" * need to double check how 'diffget' works
let g:leader_map.g = {
      \ 'name' : '+git' ,
      \ 'o' : ['GBrowse',     'Open in web'],
      \ 'm' : ['GdiffInTab',  'Merge conflicts'],
      \ 'd' : ['GdiffInTab',  'Diff with HEAD'],
      \ 'g' : ['GitInTab',    'Git status in new tab'],
      \ 'n' : ['diffget //3', 'Get diff from RIGHT side'],
      \ 't' : ['diffget //2', 'Get diff from LEFT side'],
      \ 'h' : {
        \ 'name': '+hunk',
        \ 'd': ['<Plug>(GitGutterPreviewHunk)', 'Preview'],
        \ 'n': ['<Plug>(GitGutterNextHunk)',    'Next'],
        \ 'k': ['<Plug>(GitGutterPrevHunk)',    'Previous'],
        \ 's': ['<Plug>(GitGutterStageHunk)',   'Stage'],
        \ 'u': ['<Plug>(GitGutterUndoHunk)',    'Undo'],
        \ },
      \ }

let g:leader_map.s = {
      \ 'name' : '+show' ,
      \ }

let g:leader_map.o = {
      \ 'name' : '+open' ,
      \ 'l' : ['', 'Location list'],
      \ 'q' : ['', 'Quickfix list'],
      \ 't' : ['', 'Terminal'],
      \ 'w' : ['functions#OpenURL()', 'Web Browser for current url'],
      \ }

let g:leader_map.r = {
      \ 'name' : '+run' ,
      \ 'r' : ['', 'Run'],
      \ 'c' : ['', 'Choose run config'],
      \ }

let g:leader_map.d = {
      \ 'name' : '+debug-run' ,
      \ 'd' : ['', 'Debug'],
      \ 'c' : ['', 'Choose debug config'],
      \ 'b' : ['', 'Breakpoint toggle'],
      \ }

let g:leader_map.t = {
      \ 'name' : '+test-run' ,
      \ 't' : ['', 'Test'],
      \ 'c' : ['', 'Coverage'],
      \ 'f' : ['', 'Funciton test'],
      \ }

let g:leader_map.l = {
      \ 'name' : '+lsp' ,
      \ 'f': ['', 'Format'],
      \ 'r' : {
        \ 'name': '+refactor',
        \ 'e': ['', 'Rename element'],
        \ 'f': ['', 'Rename file'],
        \ },
      \ 'g' : {
        \ 'name': '+goto',
        \ 'd' : ['', 'Definition'],
        \ 't' : ['', 'Type definition'],
        \ 'i' : ['', 'Implementation'],
        \ }
      \ }

let g:leader_map.e = {
      \ 'name' : '+errors' ,
      \ 'n' : ['', 'Next error'],
      \ 'p' : ['', 'Previous error'],
      \ 'a' : ['', 'All errors'],
      \ }

" Register which key map
call which_key#register('<Space>', 'g:leader_map')
