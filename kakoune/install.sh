#!/usr/bin/env bash
#----------------------------------------------------------------------------------------------------------------------
# DOTFILES INSTALL SCRIPT KAKOUNE
#----------------------------------------------------------------------------------------------------------------------
#
# Install kakoune config
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
    TARGET="$HOME/.config/kak"
    cd "$(dirname $1)"
    
    $DEBUG mkdir -p "${TARGET}/plugins"
    $DEBUG ln -sfT "$PWD/kakrc"     "${TARGET}/kakrc"
    $DEBUG ln -sfT "$PWD/scripts"   "${TARGET}/scripts"
    $DEBUG ln -sfT "$PWD/plug"      "${TARGET}/plug"

    if [ -z ${DEBUG} ]
    then
        echo "Kakoune configuration installed."
        echo "Please run :plug-install in kakoune to install all the necessary plugins."
    fi
}


# Run script if not sourced
[[ "${BASH_SOURCE[0]}" == "${0}" ]] && install ${0}
