#!/usr/bin/env bash
#----------------------------------------------------------------------------------------------------------------------
# DOTFILES INSTALL SCRIPT OPENBOX
#----------------------------------------------------------------------------------------------------------------------
#
# Install openbox files
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
    cd "$(dirname $1)"

    $DEBUG rm -rf "$HOME/.config/dunst"
    $DEBUG rm -rf "$HOME/.config/obmenu-generator"
    $DEBUG rm -rf "$HOME/.config/openbox"
    $DEBUG rm -rf "$HOME/.config/tint2"

    $DEBUG ln -sfT      "$PWD/dunst"                "$HOME/.config/dunst"
    $DEBUG ln -sfT      "$PWD/obmenu-generator"     "$HOME/.config/obmenu-generator"
    $DEBUG ln -sfT      "$PWD/openbox"              "$HOME/.config/openbox"
    $DEBUG ln -sfT      "$PWD/tint2"                "$HOME/.config/tint2"
    $DEBUG sudo ln -sfT "$PWD/oblogout.conf"        "/etc/oblogout.conf"

    if [ -z ${DEBUG} ]
    then
        echo "Openbox configuration installed."
        echo "Please check the openbox guide [guides/ubuntu-openbox.md]."
    fi
}


# Run script if not sourced
[[ "${BASH_SOURCE[0]}" == "${0}" ]] && install ${0}
