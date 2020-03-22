#!/usr/bin/env bash

set -e

function help() {

local _FILE_NAME
_FILE_NAME=`basename ${BASH_SOURCE[0]}`

cat << HELP_USAGE

Description:
    This script starts a Jupyter Lab or Jupyter Notebook.

Usage:
    $_FILE_NAME [-h|--help] [--notebook] [--port=<PORT>]
    [--remote-port=<REMOTE_PORT>] [--connect=<REMOTE_ID>]

Examples:
    $_FILE_NAME
    $_FILE_NAME --port=9000
    $_FILE_NAME --notebook --port=9000
    $_FILE_NAME --connect=user@address --port=9000
        Tunnelling localhost:9000 ==> user@address:9000
    $_FILE_NAME --connect=doc-ik1614 --remote-port=8888 --port=9000
        Tunnelling localhost:9000 ==> doc-ik1614:8888

Options:
    -h|--help
    Show this message.

    --notebook
        Start Jupyter Notebook instead of Jupyter Lab.
        By default Jupyter Lab is started.

    --port=<port>
        Local port for starting/connecting to Jupyter server.
        Default is '8888'.

    --remote-port=<remote_port>
        Use port for starting/connecting to.
        Defaults to value of specified by '--port'.

    --connect=<REMOTE_ID>
        Open ssh tunnel to remote server that runs jupyter server.
        <REMOTE_ID> can be specified as 'user@address' and will ask for password.
        Alternatively, you can use entries from the ssh config file (~/.ssh/config).

Author:
    Ilya Kisil <ilyakisil@gmail.com>

Report bugs to ilyakisil@gmail.com.

HELP_USAGE
}

RED="\033[0;31m"
GREEN="\033[0;32m"
CYAN="\033[0;36m"
BROWN="\033[0;33m"
WHITE="\033[0;0m"

### Default value for variables
# User interface for jupyter
UI="lab"

# Exposed port on the local server
port="8888"

# Exposed port on the remote server
remote_port=""

# Exposed port on the remote server
connect_to_remote=0

### Parse arguments
for arg in "$@"; do
    case $arg in
        -h|--help)
            help
            exit
            ;;
        --notebook)
            UI="notebook"
            ;;
        --port=*)
            port="${arg#*=}"
            ;;
        --remote-port=*)
            remote_port="${arg#*=}"
            ;;
        --connect=*)
            REMOTE_ID="${arg#*=}"
            connect_to_remote=1
            ;;
        *)
            # Skip unknown option
            ;;
    esac
    shift
done

### Define new variables with respect to the parsed arguments


##########################################
#--------          MAIN          --------#
##########################################

# Use zsh as shell for terminals if it exists
if [ ! -z "${SHELL##*zsh*}" ] && [ -x "$(command -v zsh)" ]; then
    SHELL_PATH=`which zsh`
else
    SHELL_PATH=$SHELL
fi

if [[ ($connect_to_remote == 1) ]]; then

    if [ -z $remote_port ]; then
        remote_port=$port
    fi

    printf "INFO: Creating a tunnel to the jupyter server running remotely.\n"

    ssh -N -f -L localhost:${port}:localhost:${remote_port} ${REMOTE_ID}

    printf "INFO: Jupyter Server hosted on ${GREEN}[${REMOTE_ID}:${remote_port}]${WHITE} can be accessed through:\n"
    printf "\t${GREEN}http://localhost:${port}/${WHITE} \n\n"

else

    printf "Starting Jupyter ${UI}\n\n"
    env SHELL=$SHELL_PATH jupyter ${UI} --no-browser --port="${port}"

fi
