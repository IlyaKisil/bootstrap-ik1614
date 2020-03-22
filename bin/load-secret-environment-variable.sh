#!/usr/bin/env bash

security find-generic-password -w -a ${USER} -D "environment variable" -s "$1"
