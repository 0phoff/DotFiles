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
#   sudo -E ./install.sh
#
# Dry run:
#   DEBUG=echo ./install.sh
#
#----------------------------------------------------------------------------------------------------------------------

# Variables
HOME=$HOME
SCRIPT='/usr/local/bin'

# Bash folder
$DEBUG ln -sf $PWD/Bash/agignore            $HOME/.agignore
$DEBUG ln -sf $PWD/Bash/bashrc              $HOME/.bashrc
$DEBUG ln -sf $PWD/Bash/global.gitconfig    $HOME/.gitconfig
$DEBUG ln -sf $PWD/Bash/global.gitignore    $HOME/.gitignore

for f in $PWD/Bash/*.sh
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
$DEBUG ln -sf $PWD/Tmux/tmux.conf            $HOME/.tmux.conf

# Vim folder
mkdir -p $HOME/.config/nvim
$DEBUG ln -sf $PWD/Vim/neovim.vim            $HOME/.config/nvim/init.vim
$DEBUG ln -sf $PWD/Vim/ftdetect              $HOME/.config/nvim/ftdetect
$DEBUG ln -sf $PWD/Vim/ftplugin              $HOME/.config/nvim/ftplugin
$DEBUG ln -sf $PWD/Vim/scripts               $HOME/.config/nvim/scripts
$DEBUG ln -sf $PWD/Vim/syntax                $HOME/.config/nvim/syntax

# Print todo
if [ -z ${var+x} ]; then
    printf "Check \e[1mINSTALLATION.md\e[0m for further install instructions!\n"
else
    printf "\nThese are the \e[1msimlinks\e[0m that will be created if you run this command...\n"
fi
