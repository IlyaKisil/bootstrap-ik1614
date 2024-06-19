-- Write all buffers before navigating from Vim to tmux pane
vim.cmd([[
    let g:tmux_navigator_save_on_switch = 2
]])

-- Disable tmux navigator when zooming the Vim pane
vim.cmd([[
    let g:tmux_navigator_disable_when_zoomed = 1
]])

-- Custom navigation
vim.cmd([[
    let g:tmux_navigator_no_mappings = 1
    nnoremap <silent> <S-Left> :TmuxNavigateLeft<cr>
    nnoremap <silent> <S-Down> :TmuxNavigateDown<cr>
    nnoremap <silent> <S-Up> :TmuxNavigateUp<cr>
    nnoremap <silent> <S-Right> :TmuxNavigateRight<cr>
    nnoremap <silent> <C-\> :TmuxNavigatePrevious<cr>

    inoremap <silent> <S-Left> <C-c>:TmuxNavigateLeft<cr>
    inoremap <silent> <S-Down> <C-c>:TmuxNavigateDown<cr>
    inoremap <silent> <S-Up> <C-c>:TmuxNavigateUp<cr>
    inoremap <silent> <S-Right> <C-c>:TmuxNavigateRight<cr>
    inoremap <silent> <C-\> <C-c>:TmuxNavigatePrevious<cr>
]])
