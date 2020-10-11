" ############################################
" ###       THIS CONFIG IS SYMLINKED       ###
" ###    DONT' ENTER ANY SENSITIVE INFO    ###
" ###                                      ###
" ###  USE LOCAL CONFIG FOR MODIFICATIONS  ###
" ### UNLESS CHANGES WILL BECOME PERMANENT ###
" ############################################

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

function! FzfPreviewIfWide(...)
    " Helper for having horizontal or vertical preview based on window width
    " Use 'ctrl-/' to toggle preview
    let spec = get(a:, 1, {})

    return &columns > 120
                \ ? fzf#vim#with_preview(spec, 'right:50%', 'ctrl-/')
                \ : fzf#vim#with_preview(spec, 'down:50%',  'ctrl-/')
endfunction

function! FzfOnlyPreview(...)
    " Helper for using fzf only as preview instead of performing search
    " Use '?' to toggle preview
    let preview_extra_opts = get(a:, 1, [])
    let preview_default_opts = [
                \ '--delimiter', ':',
                \ '--nth', '4..',
                \ ]

    let spec = {"options": extend(preview_default_opts, preview_extra_opts)}
    return FzfPreviewIfWide(spec)
endfunction

" ----------------------------------------------------------------------------
" Integration with Ripgrep
" ----------------------------------------------------------------------------
if executable('rg')

    function! GetRgFlags(...)
        " Generate string of flags to be passed to 'ripgrep'
        let rg_extra_flags = get(a:, 1, [])
        let rg_default_flags = [
                    \ '--column',
                    \ '--line-number',
                    \ '--no-heading',
                    \ '--hidden',
                    \ '--follow',
                    \ '--smart-case',
                    \ '--glob "!.git/*"',
                    \ '--color "auto"',
                    \ ]
        let rg_flags = extend(rg_default_flags, rg_extra_flags)
        let rg_flags_string = join(rg_flags, ' ')
        return rg_flags_string
    endfunction

    function! ExactSearchWithPreview(query, path, rg_extra_flags, fullscreen)
        " Search interface similar to the one provided by 'fzf' but show only
        " exact matches. I think you don't get fuzzy searches due to the way
        " query (<q-args>) gets evaluated and is feed back into fzf preview.
        "
        " When 'path' is set to empty string then root of project will be used
        "
        " Usage:
        "   command! -nargs=* -bang FOO
        "               \ call ExactSearchWithPreview(
        "               \ <q-args>,
        "               \ "",
        "               \ ["--no-ignore"],
        "               \ <bang>0)

        let rg_flags_string = GetRgFlags(a:rg_extra_flags)

        let command_fmt = 'rg '.rg_flags_string.' %s '.a:path.' || true '
        let initial_command = printf(command_fmt, shellescape(a:query))
        let reload_command = printf(command_fmt, '{q}')

        let preview_extra_opts = [
                    \ '--phony',
                    \ '--query', a:query,
                    \ '--bind', 'change:reload:'.reload_command
                    \ ]
        call fzf#vim#grep(
                    \ initial_command,
                    \ 1,
                    \ FzfOnlyPreview(preview_extra_opts),
                    \ a:fullscreen
                    \ )
    endfunction

    set grepprg=rg\ --vimgrep
    let $FZF_DEFAULT_COMMAND = 'rg '.GetRgFlags(["--files"])

    " Make Ripgrep search ONLY file contents and not filenames
    command! -bang -nargs=* RG
                \ call fzf#vim#grep(
                \ "rg ".GetRgFlags()." ".shellescape(<q-args>),
                \ 1,
                \ FzfOnlyPreview(),
                \ <bang>0)

    " Search through content in ALL files (including gitignored)
    command! -bang -nargs=* SEARCH
                \ call fzf#vim#grep(
                \ "rg ".GetRgFlags(["--no-ignore"])." ".shellescape(<q-args>),
                \ 1,
                \ FzfOnlyPreview(),
                \ <bang>0)

    " Use custom preview for the lines search within opened buffers
    command! -bang -nargs=* LINES
                \ call fzf#vim#grep(
                \ "rg ".GetRgFlags(["--with-filename"])." ".shellescape(<q-args>)." ".fnameescape(expand('%')),
                \ 1,
                \ FzfOnlyPreview(),
                \ <bang>0)

    " Slightly modified ':GFile' to show preview either right or down base on
    " window width
    command! -bang -nargs=? GFILES
                \ call fzf#vim#gitfiles(
                \ <q-args>,
                \ FzfPreviewIfWide(),
                \ <bang>0)
endif

" ----------------------------------------------------------------------------
" Mappings
" ----------------------------------------------------------------------------
nnoremap <C-p> :<C-u>GFILES<CR>
nnoremap <silent><nowait> <leader>ff :<C-u>Files<CR>
nnoremap <silent><nowait> <leader>fb :<C-u>Buffers<CR>
nnoremap <silent><nowait> <leader>fs :<C-u>SEARCH<CR>
nnoremap <silent><nowait> <leader>fr :<C-u>RG<CR>
nnoremap <silent><nowait> <leader>fl :<C-u>LINES<CR>
nnoremap <silent><nowait> <leader>fc :<C-u>Commands<CR>
