#!/usr/bin/env bash
#----------------------------------------------------------------------------------------------------------------------
# DOTFILES INSTALL SCRIPT PYTHONRC
#----------------------------------------------------------------------------------------------------------------------
#
# Install PythonRC Startup lib
# By 0phoff
# GPL license
#
#----------------------------------------------------------------------------------------------------------------------
#
# Usage: 
#   ./install.sh
#   DEBUG=echo ./install.sh     # Dry run
#
#----------------------------------------------------------------------------------------------------------------------

function install() {
    TARGET="$HOME/.config/pythonrc"
    DIR=$(realpath $(dirname "$1"))

    $DEBUG ln -sfT "$DIR" "$TARGET"

    if [ -z ${DEBUG} ]
    then
        echo "PythonRC library installed."
        echo "Make sure to set your PYTHONSTARTUP variable to '$TARGET/__init__.py'"
    fi
}


# Run script if not sourced
[[ "${BASH_SOURCE[0]}" == "${0}" ]] && install ${0}

