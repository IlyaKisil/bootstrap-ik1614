## Mappings

:pencil2: **Note:**  Try to keep these patterns the same between IdeaVim and Vim

* `n` and `k` in conjunction with any other mapping (e.g. `<leader>...`, `<C-k>` etc) are
  reserved for moving up and down. For instance, `<C-k>` and `<C-n>` are for moving up
  and down within popup windows, e.g. autocompletion, quickfix lists etc. Consider using
  `<C-m>` instead of `<C-k>` if the latter is used for pane movements.

* `<leader>g ...` is reserved for `git` commands

* `<leader>f ...` is reserved for `fzf` commands

* `<leader>c ...` is reserved for `CoC` commands

* `<leader>b ...` is generally used for building project. But have to be specified either in
    `coc-setting.json` or with a plugin configuration, e.g. `vim-go`, `vimtex`

* `<leader>r ...` is generally used for running/executing file. But have to be specified
    either in `coc-setting.json` or with a plugin configuration, e.g. `vim-go`

* `<leader>t ...` is generally used for test related stuff, e.g. run tests, show
    coverage. But have to be specified either in `coc-setting.json` or with a plugin
    configuration, e.g. `vim-go`

* `<leader>i ...` is generally used for IntelliSence like features, i.e. diagnostics and
    suggestions, formatting, refactoring


## Setup Plugin manager

Don't really need this, since we have `vim-plug` as part of our dotfiles.  Nevertheless,
here is a way to auto-initialise on a new machine. Place either of the following code
snippets in `.vimrc` prior setting up plugins, i.e. `plug#begin()`:

*   This is provided by `vim-plug` on their [wiki page](https://github.com/junegunn/vim-plug/wiki/tips#automatic-installation)
    ```
    if empty(glob('~/.vim/autoload/plug.vim'))
      silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
      autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
    endif
    ```

*   Alternatively, this should also do the job just fine. Source can be found [here](https://github.com/fisadev/fisa-vim-config/blob/master/config.vim#L16-L42)
    ```
    " Install 'vim-plug' for the very first time.
    let vim_plug_just_installed = 0
    let vim_plug_path = expand('~/.vim/autoload/plug.vim')
    endif
    if !filereadable(vim_plug_path)
        echo "Installing Vim-plug..."
        echo ""
        silent !mkdir -p ~/.vim/autoload
        silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        let vim_plug_just_installed = 1
    endif

    " manually load vim-plug the first time
    if vim_plug_just_installed
        :execute 'source '.fnameescape(vim_plug_path)
    endif
    ```
