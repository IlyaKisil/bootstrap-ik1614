Don't really need this, since we have `vim-plug` as part of our dotfiles. Nevertheless, here is a way to auto-initialise on a new machine. Place either of the following code snippets in `.vimrc` prior setting up plugins, i.e. `plug#begin()`:

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
