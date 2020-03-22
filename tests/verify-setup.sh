#!/usr/bin/env bash


echo -e "\n\n==========   TESTS   ==========\n\n"
echo -e "\n==> Test"
ls -la ${HOME}/.ssh


echo -e "\n==> Test"
ls -la ${HOME} | grep --color=always ".gitconfig"
ls -la ${HOME} | grep --color=always ".gitignore"


echo -e "\n==> Test"
ls -la ${HOME} | grep --color=always ".aliases"

echo -e "\n\n========   END TESTS   =========\n\n"
