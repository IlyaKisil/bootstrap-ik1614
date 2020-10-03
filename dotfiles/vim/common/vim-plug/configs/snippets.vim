" ############################################
" ##       THIS CONFIG IS SYMLINKED       ###
" ##    DONT' ENTER ANY SENSITIVE INFO    ###
" ##                                      ###
" ##  USE LOCAL CONFIG FOR MODIFICATIONS  ###
" ## UNLESS CHANGES WILL BECOME PERMANENT ###
" ###########################################
"
" 1. Use this to configure 'vim-snippets', 'coc-snippets' and 'ultisnips'
" 2. List of locations to look for snippets are specified within 'coc-settings.json'

" Need to keep mapping for jumping between placeholders the same since
" different snippet engines might provide similar prefix for expanging
" let ik_next_placeholder_mapping = "<C-j>"  " Don't like it since not on a home row
" let ik_next_placeholder_mapping = "<C-n>"  " Overlaps with cycling through 'pumvisible()'
let ik_next_placeholder_mapping = "<CR>"
let ik_prev_placeholder_mapping = "<C-k>"

" UltiSnips -----------------------------------------------------------------------------
" Trigger configuration
let g:UltiSnipsExpandTrigger="<tab>"

let g:UltiSnipsJumpForwardTrigger = ik_next_placeholder_mapping
let g:UltiSnipsJumpBackwardTrigger = ik_prev_placeholder_mapping


" vim-snippets --------------------------------------------------------------------------


" coc-snippets --------------------------------------------------------------------------
" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = ik_next_placeholder_mapping

" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = ik_prev_placeholder_mapping

" Use <leader>x for convert visual selected code to snippet
" xmap <leader>x  <Plug>(coc-convert-snippet)
