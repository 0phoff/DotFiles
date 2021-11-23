#!/usr/bin/env bash
#----------------------------------------------------------------------------------------------------------------------
# DOTFILES INSTALL SCRIPT
#----------------------------------------------------------------------------------------------------------------------
#
# Install dotfiles
# By 0phoff
# GPL license
#
#----------------------------------------------------------------------------------------------------------------------
#
# Usage: 
#   ./install.sh [-n] [folder]
#
#----------------------------------------------------------------------------------------------------------------------

# Variables
BOLD=$(tput bold)
DIM=$(tput dim)
NORMAL=$(tput sgr0)
ROOT_FOLDER=$(dirname $(realpath "$0"))


# Functions
function install_folder() {
    [[ -n ${1} ]] && echo -e "${DIM}Dry Run${NORMAL}"
    source "${2}"
    DEBUG=${1} install "${2}"
    cd "${ROOT_FOLDER}"
}


# Parse arguments
DRYRUN=""
while getopts "n" flag; do
    case "$flag" in
        n) DRYRUN="echo";;
        *) ;;
    esac
done
FOLDER=${@:$OPTIND:1}


# cd to install
cd "${ROOT_FOLDER}"


# Install single folder
if [[ -n ${FOLDER} ]]
then
    FILE="${FOLDER}/install.sh"
    if [[ -f "${FILE}" ]]
    then
        install_folder "${DRYRUN}" "${FILE}"
    else
        echo "File does not exist: ${FILE}"
    fi
    exit
fi


# Install all folders
for FILE in */install.sh
do
    echo -e "\n${BOLD}----- ${FILE} -----${NORMAL}"
    if [[ -n ${DRYRUN} ]]
    then
        install_folder "${DRYRUN}" "${FILE}"
    else
        while [[ ! "${REPLY}" =~ ^[ynd]$ ]]
        do
            read -p "Install ? [y/n/d]" -n1 -r
            echo
        done

        [[ "${REPLY}" == "y" ]] && install_folder "" "${FILE}"
        [[ "${REPLY}" == "d" ]] && install_folder "echo" "${FILE}"
        unset REPLY
    fi
done
