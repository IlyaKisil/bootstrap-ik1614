#!/usr/bin/env bash


echo -e "\n\n==========   TESTS   ==========\n\n"
echo -e "\n==> Test SSH"
ls -la ${HOME}/.ssh


echo -e "\n==> Test GIT"
ls -la ${HOME} | grep --color=always ".gitconfig"
ls -la ${HOME} | grep --color=always ".gitignore"


echo -e "\n==> Test SH-ALIASES"
ls -la ${HOME} | grep --color=always ".aliases"


echo -e "\n==> Test TMUX"
ls -la ${HOME} | grep --color=always ".tmux"
ls -la ${HOME}/.tmux/plugins


echo -e "\n==> Test BIN"
ls -la ${HOME}/bin


echo -e "\n==> Test ZSH"
ls -la ${HOME} | grep --color=always "zsh"
ls -la ${HOME}/.config/zsh
ls -la ${HOME}/.config/zsh/custom/plugins
ls -la ${HOME}/.config/zsh/custom/themes


echo -e "\n==> Test VIM"
ls -la ${HOME} | grep --color=always "vim"
ls -la ${HOME}/.vim
ls -la ${HOME}/.vim/autoload

echo -e "\n\n========   END TESTS   =========\n\n"
