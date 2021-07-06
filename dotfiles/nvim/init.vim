" #################################################
" ###       THIS CONFIG IS SYMLINKED            ###
" ###    DONT' ENTER ANY SENSITIVE INFO         ###
" ###                                           ###
" ###  USE LOCAL CONFIG FOR MODIFICATIONS       ###
" ### UNLESS CHANGES WILL BECOME PERMANENT      ###
" ###                                           ###
" ###                                           ###
" ### Lua configs should be specified in        ###
" ###   'lua/ik1614/<NAME>/init.lua'            ###
" ###                                           ###
" ###                                           ###
" ### VimScript configs should be specified in  ###
" ###   'lua/ik1614-vimscript/<NAME>/init.vim'  ###
" ###                                           ###
" #################################################

lua require("ik1614")

let s:__vimscript_path = $HOME.'/.config/nvim/lua/ik1614-vimscript/init.vim'
if filereadable(expand(s:__vimscript_path))
    execute "source " . s:__vimscript_path
endif

