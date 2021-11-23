#!/usr/bin/env bash
#----------------------------------------------------------------------------------------------------------------------
# DOTFILES INSTALL SCRIPT DEKSTOP
#----------------------------------------------------------------------------------------------------------------------
#
# Install desktop files
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
    TARGET="$HOME/.local/share/applications"
    cd "$(dirname $1)"

    $DEBUG mkdir -p "${TARGET}"
    for f in $(find . -name "*.desktop")
    do
        f=$(realpath $f)
        base=$(basename $f)
        $DEBUG ln -sfT "$f" "$TARGET/$base"
    done

    if [ -z ${DEBUG} ]
    then
        echo "Desktop files installed."
    fi
}


# Run script if not sourced
[[ "${BASH_SOURCE[0]}" == "${0}" ]] && install ${0}
