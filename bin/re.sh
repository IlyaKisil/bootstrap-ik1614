#!/usr/bin/env bash

set -ue

function help() {

local _FILE_NAME
_FILE_NAME=`basename ${BASH_SOURCE[0]}`œ

cat << HELP_USAGE

Description:
    Delete files/folders into Trash.
    A lot safer than to rm -rf files as you can always check
    out ~/.Trash in cases of emergency or mistakes.

Author:
    Ilya Kisil <ilyakisil@gmail.com>

Report bugs to ilyakisil@gmail.com.

HELP_USAGE
}


mv "$1" ~/.Trash
