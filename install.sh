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
SCRIPT='/usr/local/bin'

# Bash folder
$DEBUG ln -s $PWD/Bash/agignore            $HOME/.agignore
$DEBUG ln -s $PWD/Bash/bashrc              $HOME/.bashrc
$DEBUG ln -s $PWD/Bash/global.gitconfig    $HOME/.gitconfig
$DEBUG ln -s $PWD/Bash/global.gitignore    $HOME/.gitignore

for f in $PWD/Bash/*.sh
do
    if [ '${f##*/}' == 'tmuxCreator.sh' ]; then
        $DEBUG ln -s $f     $SCRIPT/tmc
    else
        base=${f##*/}
        $DEBUG ln -s $f     $SCRIPT/${base%.*}
    fi
done

# Tmux folder
$DEBUG ln -s $PWD/Tmux/tmux.conf            $HOME/.tmux.conf

# Vim folder
$DEBUG ln -s $PWD/Vim/neovim.vim            $HOME/.config/nvim/init.vim
$DEBUG ln -s $PWD/Vim/ftdetect              $HOME/.config/nvim/ftdetect
$DEBUG ln -s $PWD/Vim/ftplugin              $HOME/.config/nvim/ftplugin
$DEBUG ln -s $PWD/Vim/scripts               $HOME/.config/nvim/scripts
$DEBUG ln -s $PWD/Vim/syntax                $HOME/.config/nvim/syntax

# Print todo
if [ -z '$DEBUG' ]; then
    printf "Check \e[1mINSTALLATION.md\e[0m for further install instructions!\n"
else
    printf "\nThese are the \e[1msimlinks\e[0m that will be created if you run this command...\n"
fi
