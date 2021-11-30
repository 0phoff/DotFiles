#!/usr/bin/env bash
#----------------------------------------------------------------------------------------------------------------------
# DOTFILES INSTALL SCRIPT CONFIG
#----------------------------------------------------------------------------------------------------------------------
#
# Install config files
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

    $DEBUG ln -sfT  "$PWD/dir_colors"       "$HOME/.dir_colors"
    $DEBUG ln -sfT  "$PWD/gitconfig"        "$HOME/.gitconfig"
    $DEBUG ln -sfT  "$PWD/gitignore"        "$HOME/.gitignore"
    $DEBUG ln -sfT  "$PWD/fdignore"         "$HOME/.fdignore"
    $DEBUG ln -sfT  "$PWD/profile"          "$HOME/.profile"
    $DEBUG ln -sfT  "$PWD/Xresources"       "$HOME/.Xresources"

    $DEBUG ln -sfT  "$PWD/bashrc.bashrc"    "$HOME/.bashrc"
    $DEBUG ln -sfT  "$PWD/fzf.bashrc"       "$HOME/.config/fzf.bashrc"
    $DEBUG cp -n    "$PWD/local.bashrc"     "$HOME/.config/local.bashrc"

    if [ -z ${DEBUG} ]
    then
        echo "Config files installed."
        echo "edit '$HOME/.config/local.bashrc' to your likings"
    fi
}


# Run script if not sourced
[[ "${BASH_SOURCE[0]}" == "${0}" ]] && install ${0}
