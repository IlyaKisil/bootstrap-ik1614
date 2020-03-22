#!/usr/bin/env bash


echo -e "\n\n==========   TESTS   ==========\n\n"
ls -la ${HOME}/.ssh


ls -la ${HOME} | grep --color=always ".gitconfig"
ls -la ${HOME} | grep --color=always ".gitignore-global"


echo -e "\n\n========   END TESTS   =========\n\n"
