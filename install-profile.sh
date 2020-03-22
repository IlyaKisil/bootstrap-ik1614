#!/usr/bin/env bash

set -ue

source ./install-prepare.sh

while IFS= read -r config; do
    CONFIGS+=" ${config}"
done < "${PROFILES_HOME}/$1"

shift

./install-config.sh $CONFIGS
