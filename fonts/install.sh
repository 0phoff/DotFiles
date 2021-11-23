#!/usr/bin/env bash
#----------------------------------------------------------------------------------------------------------------------
# DOTFILES INSTALL SCRIPT FONTS
#----------------------------------------------------------------------------------------------------------------------
#
# Install fonts
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
    TARGET="$HOME/.local/share/fonts"
    cd "$(dirname $1)"

    $DEBUG mkdir -p "${TARGET}"
    $DEBUG ln -sfT "${PWD}" "${TARGET}/dotfiles"
    $DEBUG fc-cache -fv

    if [ -z ${DEBUG} ]
    then
        echo "Installed fonts."
        echo "Select the right one in the settings of your terminal emulator."
    fi
}


# Run script if not sourced
[[ "${BASH_SOURCE[0]}" == "${0}" ]] && install ${0}
