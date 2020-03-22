#!/usr/bin/env bash

set -ue

source ./install-prepare.sh

CONFIG_FILE=$(mktemp)
for config in ${@}; do
    echoinfo "Configure $config"

    # Add a basic configuration (i.e. default and clean directives)
    echo "${BASE_CONFIG_CONTENT}" > ${CONFIG_FILE}

    # Ensure that new content is added on a new line, since yaml is
    # is space sensitive
    printf "\n" >> ${CONFIG_FILE}
    cat "${CONFIGS_HOME}/${config}${CONFIG_SUFFIX}" >> ${CONFIG_FILE}

    # Run dotbot and get rid fo temporary config file
    $DOTBOT -d "${BASE_DIR}" -c "$CONFIG_FILE"
    rm -f "$CONFIG_FILE"
done
