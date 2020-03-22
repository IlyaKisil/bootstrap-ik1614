#!/usr/bin/env bash

set -ue


### Utility functions
__detect_color_support() {
    local COLORS=$(tput colors 2>/dev/null || echo 0)

    # shellcheck disable=SC2181
    if [ $? -eq 0 ] && [ "$COLORS" -gt 2 ]; then
        RC='\033[31m'
        GC='\033[32m'
        BC='\033[34m'
        YC='\033[33m'
        EC='\033[0m'
    else
        RC=""
        GC=""
        BC=""
        YC=""
        EC=""
    fi
}
__detect_color_support

echoerror() {
  printf "${RC}=> ERROR:${EC} %s\\n" "$@" 1>&2;
}

echoinfo() {
  printf "${GC}=> INFO:${EC} %s\\n" "$@";
}

echowarn() {
  printf "${YC}=> WARN:${EC} %s\\n" "$@";
}


### Define main/common variables
BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

DOTBOT="${BASE_DIR}/dotbot/bin/dotbot"

META_HOME="${BASE_DIR}/dotfiles-meta"

PROFILES_HOME="${META_HOME}/profiles"

CONFIGS_HOME="${META_HOME}/configs"
CONFIG_SUFFIX=".yaml"

BASE_CONFIG="base"
BASE_CONFIG_CONTENT=$(cat "${META_HOME}/${BASE_CONFIG}${CONFIG_SUFFIX}")


### Make sure that we are in correct location
cd "${BASE_DIR}"
