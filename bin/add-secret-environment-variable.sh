#!/usr/bin/env bash

>&2 echo -n "Enter secret:"
read -s password
security add-generic-password -U -a ${USER} -D "environment variable" -s "$1" -w "$password"
>&2 echo -n "Saved password for $1"

>&2 echo -n "Add this to .zshenv.secrets / .bashrc etc: (NB: you can append the output of this script directly to a file of your choice)"
>&2 echo ""
echo "export $1=\$(load-secret-environment-variable $1)"
