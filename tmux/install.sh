#!/usr/bin/env bash
#----------------------------------------------------------------------------------------------------------------------
# DOTFILES INSTALL SCRIPT TMUX
#----------------------------------------------------------------------------------------------------------------------
#
# Install tmux configuration
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
    TARGET="$HOME/.config/tmux"
    cd "$(dirname $1)"

    $DEBUG mkdir -p "${TARGET}"
    $DEBUG ln -sfT "$PWD/tmux.conf"             "${HOME}/.tmux.conf"
    $DEBUG ln -sfT "$PWD/colors.tmux"           "${TARGET}/colors.tmux"
    $DEBUG ln -sfT "$PWD/settings.tmux"         "${TARGET}/settings.tmux"
    $DEBUG ln -sfT "$PWD/keymap.tmux"           "${TARGET}/keymap.tmux"
    $DEBUG ln -sfT "$PWD/status-ascii.tmux"     "${TARGET}/status-ascii.tmux"
    $DEBUG ln -sfT "$PWD/status-power.tmux"     "${TARGET}/status-power.tmux"

    if [ -z ${DEBUG} ]
    then
        echo "Tmux configuration installed."
    fi
}


# Run script if not sourced
[[ "${BASH_SOURCE[0]}" == "${0}" ]] && install ${0}
