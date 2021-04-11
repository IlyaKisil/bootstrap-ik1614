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

augroup highlight_yank
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank { higroup='IncSearch', timeout=400 }
augroup END

augroup now
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
augroup END


