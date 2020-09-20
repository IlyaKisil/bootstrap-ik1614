" ############################################
" ###       THIS CONFIG IS SYMLINKED       ###
" ###    DONT' ENTER ANY SENSITIVE INFO    ###
" ###                                      ###
" ###  USE LOCAL CONFIG FOR MODIFICATIONS  ###
" ### UNLESS CHANGES WILL BECOME PERMANENT ###
" ############################################

nnoremap <C-p> :GFiles<CR>

" Border color
let g:fzf_layout = {'up':'~90%', 'window': { 'width': 1, 'height': 1,'yoffset':0,'xoffset': 0, 'highlight': 'Todo'} }

" Customize fzf colors to match your color scheme
let g:fzf_colors = {
            \ 'fg':      ['fg', 'Normal'],
            \ 'bg':      ['bg', 'Normal'],
            \ 'hl':      ['fg', 'Comment'],
            \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
            \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
            \ 'hl+':     ['fg', 'Statement'],
            \ 'info':    ['fg', 'PreProc'],
            \ 'border':  ['fg', 'Ignore'],
            \ 'prompt':  ['fg', 'Conditional'],
            \ 'pointer': ['fg', 'Exception'],
            \ 'marker':  ['fg', 'Keyword'],
            \ 'spinner': ['fg', 'Label'],
            \ 'header':  ['fg', 'Comment'] }

" Helper for having horizontal or vertical preview based on window width
function! FzfPreviewIfWide(spec)
    return &columns > 120
                \ ? fzf#vim#with_preview(a:spec, 'right:50%', '?')
                \ : fzf#vim#with_preview(a:spec, 'down:50%', '?')
endfunction

" Integration with Ripgrep
if executable('rg')
    let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*" --color=always'
    set grepprg=rg\ --vimgrep

    command! -bang -nargs=* Find
                \ call fzf#vim#grep(
                \   'rg --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1,
                \   <bang>0)

    " Make Ripgrep ONLY search file contents and not filenames
    command! -bang -nargs=* Rg
                \ call fzf#vim#grep(
                \   'rg --line-number --hidden --smart-case --no-heading --color=always '.shellescape(<q-args>), 1,
                \   FzfPreviewIfWide({'options': '--delimiter : --nth 4..'}),
                \   <bang>0)

    " Add preview for the lines search within opened buffers
    command! -bang -nargs=* Lines
                \ call fzf#vim#grep(
                \   'rg --with-filename --line-number --no-heading --color=always --smart-case . '.fnameescape(expand('%')), 1,
                \   FzfPreviewIfWide({'options': '--delimiter : --nth 4..'}),
                \   <bang>0)
endif
