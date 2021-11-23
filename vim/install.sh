#!/usr/bin/env bash
#----------------------------------------------------------------------------------------------------------------------
# DOTFILES INSTALL SCRIPT NEOVIM
#----------------------------------------------------------------------------------------------------------------------
#
# Install neovim configuration
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
    TARGET="$HOME/.config/nvim"
    cd "$(dirname $1)"

    $DEBUG mkdir -p "${TARGET}"
    $DEBUG ln -sfT "$PWD/neovim.vim"   "${TARGET}/init.vim"
    $DEBUG ln -sfT "$PWD/ftdetect"     "${TARGET}/ftdetect"
    $DEBUG ln -sfT "$PWD/ftplugin"     "${TARGET}/ftplugin"
    $DEBUG ln -sfT "$PWD/scripts"      "${TARGET}/scripts"
    $DEBUG ln -sfT "$PWD/syntax"       "${TARGET}/syntax"

    if [ -z ${DEBUG} ]
    then
        echo "NeoVIM configuration installed."
        echo "Please run :PlugInstall in neovim to install all the necessary plugins."
    fi
}


# Run script if not sourced
[[ "${BASH_SOURCE[0]}" == "${0}" ]] && install ${0}
