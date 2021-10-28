" ---------- Better backup, swap and undos storage for vim default
let $__NVIM_HOME = $HOME.'/.config/nvim'


" Directory to place swap files in
set directory=$__NVIM_HOME/dirs/tmp
if !isdirectory(&directory)
    call mkdir(&directory, "p")
endif
" Make backup files and where to put them
set backup
set backupdir=$__NVIM_HOME/dirs/backups
if !isdirectory(&backupdir)
    call mkdir(&backupdir, "p")
endif
" Persistent undos - undo after you re-open the file
set undofile
set undodir=$__NVIM_HOME/dirs/undos
if !isdirectory(&undodir)
    call mkdir(&undodir, "p")
endif
" Continue where you left off upon reopening vim session
set viminfo+=n$__NVIM_HOME/dirs/viminfo

augroup ik1614_now
    autocmd!
    autocmd Syntax * call functions#UpdateTodoKeywords(
                \ "NOTE",
                \ "Note",
                \ "note",
                \ "Todo",
                \ "todo",
                \ "Fixme",
                \ "fixme",
                \ )

    autocmd BufWritePre * :call functions#TrimWhitespace()
    autocmd BufWritePre * :call functions#MakeNonExistingDir(expand('<afile>'), +expand('<abuf>'))

    " Always show help window on the left
    autocmd FileType help wincmd L

    " Change highlight group of active/inactive windows
    " https://caleb89taylor.medium.com/customizing-individual-neovim-windows-4a08f2d02b4e
    autocmd WinEnter * call functions#HandleWinEnter()

    " Highlight yank
    autocmd TextYankPost * silent! lua vim.highlight.on_yank { higroup='IncSearch', timeout=400 }
augroup END

" NeoVim doesn't support command definition at this moment :cry:
command! Cnext try | cnext | catch | cfirst | catch | endtry
command! Cprev try | cprev | catch | clast  | catch | endtry
command! Lnext try | lnext | catch | lfirst | catch | endtry
command! Lprev try | lprev | catch | llast  | catch | endtry



" vimscript
command! DiffviewFile execute("DiffviewOpen -- " . expand("%")) | DiffviewToggleFiles



" Allows to first grep for something, and then use Telescope as the secondary filter
command! -nargs=? Tgrep lua require 'telescope.builtin'.grep_string({ search = vim.fn.input("Grep For > ")})
