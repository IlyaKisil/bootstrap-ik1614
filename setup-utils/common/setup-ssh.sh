#!/usr/bin/env bash

set -ue

function main() {
    local SSH_DIR=${HOME}/.ssh
    local SSH_CONFIG=${SSH_DIR}/config
    local SSH_USER=`whoami`
    local SSH_PC=`uname -n`

    if [[ -d ${SSH_DIR} ]] && [[ -f ${SSH_CONFIG} ]]; then
        echo '==> Creating ssh keys'

        for LINE in $(grep "IdentityFile" ${SSH_CONFIG});
        do
            # This check is a way around of grep automatically splitting
            # by space a line with a match. So we just disregard those elements
            if [[ ${LINE} != "IdentityFile" ]]; then
                ssh_key_name=`echo ${LINE} | awk -F '/' '{ print $NF }'`
                ssh_key_path="${SSH_DIR}/${ssh_key_name}"
                if [ ! -f ${ssh_key_path} ] && [ ! -f "${ssh_key_path}.pub" ]   ; then
                    printf "=> Creating [${ssh_key_path}] SSH key.\n"
                    ssh-keygen -t rsa -b 4096 -C "${SSH_USER}@${SSH_PC}" -f ${ssh_key_path} -q -N ""
                else
                    printf "=> SSH key [${ssh_key_path}] exists. Creation is skipped.\n"
                fi
            fi
        done
    else
        echo "==> SSH config [~/.ssh/config] file do not exists at user level."
    fi
}

main
