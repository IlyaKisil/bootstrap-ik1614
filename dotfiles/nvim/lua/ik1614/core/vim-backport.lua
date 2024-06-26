-- TODO: convert this to lua native format
--
vim.cmd([[
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

  " Continue where you left off upon reopening vim session, e.g.
  " command history, search history etc. Potentially, it used to
  " work for preserving last position in a given file, but I'm not sure
  " TODO: Switch to 'shada' as 'viminfo' is deprecated
  set viminfo+=n$__NVIM_HOME/dirs/viminfo

  augroup ik1614_now
      autocmd!

      autocmd BufWritePre * :call functions#TrimWhitespace()
      autocmd BufWritePre * :call functions#MakeNonExistingDir(expand('<afile>'), +expand('<abuf>'))

      " Always show help window on the left
      autocmd FileType help wincmd L
      autocmd FileType help nmap <buffer> q :q<CR>

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
]])
