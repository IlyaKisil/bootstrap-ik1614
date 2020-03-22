#!/usr/bin/env bash

set -e

function help() {

local _FILE_NAME
_FILE_NAME=`basename ${BASH_SOURCE[0]}`

cat << HELP_USAGE

Description:
    Compile latex document into pdf. By default employs 'latexmk',
    but 'pdflatex' can also be used with the same options.

Usage: ${_FILE_NAME} [-h|--help] [--file=<FILE_NAME>] [--aux-dir=<AUX_DIR>]
    [--pdflatex] [--bibtex] [--clean] [--force-clean] [--verbose]

Options:
    -h|--help
        Show this message.

    --file=<FILE_NAME>
        Defines the name of file for which pdf will be generated.
        Must have '*.tex' file extension.
        Default is 'main.tex'.

    --aux-dir=<AUX_DIR>
        Defines where so-generated auxiliary files are placed.
        Default is './build'.

    --pdflatex
        Use 'pdflatex' to produce pdf document.
        By default 'latexmk' is used.

    --bibtex
        If specified, then compile with 'bibtex' and, therefore,
        will take longer to finish.

    --clean
        Clean auto-generated auxiliary files (*.aux, *.fls, *.log, *.out,
        *.blg, *.fdb_latexmk, *.synctex.gz). Files to be deleted are defined
        by '--file=' located in '--aux-dir=' or their default values.

    --full-clean
        Extends option '--clean' and removes build files (*.bbl, *.pdf)

    --verbose
        If specified, then 'STDIN' will contain more output text

Examples:
    ${_FILE_NAME} --file=my_main.tex
        Use 'my_main.tex' to produce pdf document with 'latexmk'.
        All files will be stored in default location of --aux-dir.

    ${_FILE_NAME} --bibtex --aux-dir=tmp
        Use bibtex during the process of producing pdf document
        and store all so-generated files in './tmp'.

    ${_FILE_NAME} --clean --aux-dir=tmp
        Auxiliary files that are located in './tmp' and match
        pattern 'main.[AUX_EXTENSION]' will be removed.

    ${_FILE_NAME} --full-clean --file=my_main.tex
        Build and auxiliary files that match pattern 'my_main.*'
        will be removed from the current directory.

    ${_FILE_NAME} --pdflatex
        Use this for the fastest compilation process.
        However, it does not check whether there were modifications
        to the source files.

    ${_FILE_NAME} --pdflatex --bibtex
        Use 'pdflatex -> bibtex -> pdflatex -> pdflatex ->' to
        produce pdf document. Could be handy if there are issues with
        invoking 'latexmk'.

    ${_FILE_NAME} --pdflatex --bibtex --aux-dir=tmp --file=my_main.tex
        Do not know why you would choose this option over default.

Author:
    Ilya Kisil <ilyakisil@gmail.com>

Report bugs to ilyakisil@gmail.com.

HELP_USAGE
}

### Utility functions
source "$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )/print_utils.sh"
MAKE_PDF=`basename ${BASH_SOURCE[0]}`


### Default values for variables
FILE="main.tex"
AUX_DIR="build"
ENGINE=1
USE_BIBTEX=0
QUIET="-quiet"
CLEAN=0
# Files with these extensions are removed when 'CLEAN=1'
declare -a AUX_EXTENSIONS=(".aux"
                           ".fls"
                           ".log"
                           ".out"
                           ".blg"
                           ".fdb_latexmk"
                           ".synctex.gz"
                           )
# Files with these extensions are removed when 'CLEAN=2' (extends 'CLEAN=1')
declare -a BUILD_EXTENSIONS=(".pdf"
                             ".bbl"
                             )


### Parse arguments
for arg in "$@"; do
    case ${arg} in
        -h|--help)
            help
            exit
            ;;
        --file=*)
            FILE="${arg#*=}"
            ;;
        --aux-dir=*)
            AUX_DIR="${arg#*=}"
            ;;
        --pdflatex)
            ENGINE=2
            ;;
        --bibtex)
            USE_BIBTEX=1
            ;;
        --verbose)
            QUIET=""
            ;;
        --clean)
            CLEAN=1
            ;;
        --full-clean)
            CLEAN=2
            ;;
        *)
            # Skip unknown option
            ;;
    esac
    shift
done


### Define new variables with respect to the parsed arguments
file_name="${FILE%.*}"
if [[ -z ${AUX_DIR} ]]; then
    aux_home=${PWD}
else
    aux_home=${PWD}/${AUX_DIR}
fi

function compile () {
    if [[ ! -d ${AUX_DIR} ]]; then
        mkdir -p ${AUX_DIR}
    fi
    if [[ (${ENGINE} == 1) ]]; then
        echo "`INFO $MAKE_PDF` Creating pdf with 'latexmk'"
        if [[ (${USE_BIBTEX} == 1) ]]; then
            BIBTEX="-bibtex"
        else
            BIBTEX="-nobibtex"
        fi
        latexmk -pdf ${QUIET} ${BIBTEX} -auxdir=${AUX_DIR} -outdir=${AUX_DIR} ${FILE}

    elif [[ (${ENGINE} == 2) ]]; then
        echo "`INFO $MAKE_PDF` Creating pdf with 'pdflatex'"
        pdflatex -output-directory=${AUX_DIR} ${FILE}
        if [[ (${USE_BIBTEX} == 1) ]]; then
            file_aux="${file_name}.aux"
            bibtex ${AUX_DIR}/${file_aux}
            pdflatex -output-directory=${AUX_DIR} ${FILE}
            pdflatex -output-directory=${AUX_DIR} ${FILE}
        fi
    else
        echo "`WARNING $MAKE_PDF` Unknown compiling engine. Nothing has been compiled" >&2
    fi
}

function clean_aux() {
    local file
    echo "`INFO $MAKE_PDF` Removing auto-generated auxiliary files."
    for extension in "${AUX_EXTENSIONS[@]}"
    do
        file=${aux_home}/${file_name}${extension}

        if [[ -f ${file} ]]; then
            rm ${file}
        fi
    done
}

function clean_build() {
    local file
    echo "`INFO $MAKE_PDF` Removing build files."
    for extension in "${BUILD_EXTENSIONS[@]}"
    do
        file=${aux_home}/${file_name}${extension}

        if [[ -f ${file} ]]; then
            rm ${file}
        fi
    done

}


##########################################
#--------          MAIN          --------#
##########################################

if [[ ${FILE} != *.tex ]]; then
    echo "`ERROR $MAKE_PDF` This script can only be used for files with LaTeX extension (*.tex)" >&2
    echo "$FILE" >&2
    exit 1
fi

if [[ ! -f ${FILE} ]]; then
    echo "`ERROR $MAKE_PDF` Specified source file does not exist in the current directory." >&2
    echo "$FILE" >&2
    exit 1
fi

if [[ (${CLEAN} == 0) ]]; then
    compile
elif [[ (${CLEAN} == 1) ]]; then
    clean_aux
elif [[ (${CLEAN} == 2) ]]; then
    clean_aux
    clean_build
fi

echo "`INFO $MAKE_PDF` Success :-)"
