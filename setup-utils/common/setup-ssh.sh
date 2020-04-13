#!/usr/bin/env bash

set -ue

function main() {
    local SSH_DIR=${HOME}/.ssh
    local SSH_USER=`whoami`
    local SSH_PC=`uname -n`
    local SSH_CONFIGS
    declare -a SSH_CONFIGS=("${SSH_DIR}/config"
                            "${SSH_DIR}/config-local"
                            )

    for ssh_config in ${SSH_CONFIGS[@]}; do
        if [[ -d ${SSH_DIR} ]] && [[ -f ${ssh_config} ]]; then
            for LINE in $(grep "IdentityFile" ${ssh_config});
            do
                # This check is a way around of grep automatically splitting
                # by space a line with a match. So we just disregard those elements
                if [[ ${LINE} != "IdentityFile" ]]; then
                    ssh_key_name=`echo ${LINE} | awk -F '/' '{ print $NF }'`
                    ssh_key_path="${SSH_DIR}/${ssh_key_name}"
                    if [ ! -f ${ssh_key_path} ] && [ ! -f "${ssh_key_path}.pub" ]   ; then
                        printf "=> Creating [${ssh_key_path}] SSH key.\n"
                        ssh-keygen -t rsa -b 4096 -C "${SSH_USER}@${SSH_PC}" -f ${ssh_key_path} -q -N ""
                        ssh-add -K ${ssh_key_path}
                    else
                        printf "=> SSH key [${ssh_key_path}] exists. Creation is skipped.\n"
                    fi
                fi
            done
        else
            echo "=> SSH config [${ssh_config}] file do not exists at user level."
        fi
    done
}

main
