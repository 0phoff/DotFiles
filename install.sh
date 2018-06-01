#!/bin/bash
#----------------------------------------------------------------------------------------------------------------------
# DOTFILES INSTALL SCRIPT
#----------------------------------------------------------------------------------------------------------------------
#
# Dotfiles Install Script : This script will create the appropriate simlinks to install all of the configuration files
# By 0phoff
# MIT license
#
#----------------------------------------------------------------------------------------------------------------------
#
# Usage: 
#   ./install.sh
#
# Dry run:
#   DEBUG=echo ./install.sh
#
#----------------------------------------------------------------------------------------------------------------------

# Variables
HOME=$HOME
SCRIPT="$HOME/bin"

# Bash folder
$DEBUG ln -sf $PWD/bash/agignore            $HOME/.agignore
$DEBUG ln -sf $PWD/bash/bashrc              $HOME/.bashrc
$DEBUG ln -sf $PWD/bash/global.gitconfig    $HOME/.gitconfig
$DEBUG ln -sf $PWD/bash/global.gitignore    $HOME/.gitignore

for f in $PWD/bash/*.sh
do
    base=$(basename $f)
    case "$base" in
        tmuxCreator.sh)
            $DEBUG ln -sf $f $SCRIPT/tmc
            ;;
        rosinit.sh)
            $DEBUG ln -sf $f $SCRIPT/$base
            ;;
        *)
            $DEBUG ln -sf $f $SCRIPT/${base%.*}
            ;;
    esac
done

# Tmux folder
$DEBUG ln -sf $PWD/tmux/tmux.conf            $HOME/.tmux.conf

# Vim folder
mkdir -p $HOME/.config/nvim
$DEBUG ln -sf $PWD/vim/neovim.vim            $HOME/.config/nvim/init.vim
$DEBUG ln -sf $PWD/vim/ftdetect              $HOME/.config/nvim/ftdetect
$DEBUG ln -sf $PWD/vim/ftplugin              $HOME/.config/nvim/ftplugin
$DEBUG ln -sf $PWD/vim/scripts               $HOME/.config/nvim/scripts
$DEBUG ln -sf $PWD/vim/syntax                $HOME/.config/nvim/syntax

# Print todo
if [ -z ${var+x} ]; then
    printf "Check \e[1mINSTALLATION.md\e[0m for further install instructions!\n"
else
    printf "\nThese are the \e[1msimlinks\e[0m that will be created if you run this command...\n"
fi
