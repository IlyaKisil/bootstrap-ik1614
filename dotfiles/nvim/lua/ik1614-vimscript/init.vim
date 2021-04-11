let s:__here = fnamemodify(resolve(expand('<sfile>:p')), ':h')

let s:__configs = []

call add(s:__configs, 'fzf')
call add(s:__configs, 'vim-fugitive')

" All custom things that need to be converted from the VimScript
call add(s:__configs, 'vim-backport')

for s:__config in s:__configs
    let s:__path = s:__here.'/'.s:__config.'/init.vim'
    if filereadable(expand(s:__path))
        execute "source " . s:__path
    endif
endfor

