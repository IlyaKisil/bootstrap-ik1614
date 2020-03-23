#!/usr/bin/env bash

set -ue

function main() {
    echo "Installing Powerline"

    git clone https://github.com/powerline/fonts.git --depth=1
    cd fonts
    ./install.sh
    cd ..
    rm -rf fonts
    echo "Power line fonts installed"
}

main
