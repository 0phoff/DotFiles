#!/usr/bin/env bash
#----------------------------------------------------------------------------------------------------------------------
# DOTFILES INSTALL SCRIPT SCRIPTS
#----------------------------------------------------------------------------------------------------------------------
#
# Install scripts
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
    TARGET="$HOME/bin"
    cd "$(dirname $1)"

    $DEBUG mkdir -p "${TARGET}"
    shopt -s extglob
    SKIP="@(install.sh|brightness.sh|inhibit_screensaver.sh|mvMonitor.sh|watch_file.sh)"
    for f in $(find . -type f -name "*")
    do
        f=$(realpath $f)
        base=$(basename $f)
        case "$base" in
            # Ignore scripts
            ${SKIP})
                ;;
            # Install as tmux commands with shorter aliases
            tmux-window-creator.sh)
                $DEBUG ln -sfT "$f" "$TARGET/tmwc"
                ;;
            tmux-session-chooser.sh)
                $DEBUG ln -sfT "$f" "$TARGET/tmsc"
                ;;
            # Install with extension
            rosinit.sh)
                $DEBUG ln -sfT "$f" "$TARGET/$base"
                ;;
            # Install without extension
            *)
                $DEBUG ln -sfT "$f" "$TARGET/${base%.*}"
                ;;
        esac
    done
    shopt -u extglob

    if [ -z ${DEBUG} ]
    then
        echo "Scripts installed."
    fi
}


# Run script if not sourced
[[ "${BASH_SOURCE[0]}" == "${0}" ]] && install ${0}
