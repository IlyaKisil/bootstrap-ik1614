#!/usr/bin/env bash

# Useage:
#   source "$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )/print-utils.sh"
#
# Author:
#   Ilya Kisil <ilyakisil@gmail.com>

##########################################
###--------   Default values   --------###
##########################################
RED="\033[0;31m"
GREEN="\033[0;32m"
CYAN="\033[0;36m"
YELLOW="\033[0;33m"
WHITE="\033[0;0m"


#########################################
###--------     Functions     --------###
#########################################
function red(){
    printf "${RED}$1${WHITE}"
}

function green(){
    printf "${GREEN}$1${WHITE}"
}

function yellow(){
    printf "${RED}$1${WHITE}"
}

function INFO(){
    local FILE_NAME
    FILE_NAME=$1
    if [ -z ${FILE_NAME} ] ; then
        echo -e "$(green "INFO:")"
    else
        echo -e "$(green "INFO: ${FILE_NAME}")\n===>"
    fi
}

function WARNING(){
    local FILE_NAME="$1"
    if [ -z ${FILE_NAME} ] ; then
        echo -e "$(yellow "WARNING:")"
    else
        echo -e "$(yellow "WARNING: ${FILE_NAME}")\n===>"
    fi
}

function ERROR(){
    local FILE_NAME="$1"
    if [ -z ${FILE_NAME} ] ; then
        echo -e "$(red "ERROR:")"
    else
        echo -e "$(red "ERROR: ${FILE_NAME}")\n===>"
    fi
}

function exit_msg(){
    printf "Enter [y] to exit: "
    answer=$( while ! head -c 1 | grep -i '[y]' ;do true ;done )
    exit 0
}
