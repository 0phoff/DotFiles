#!/bin/bash
#----------------------------------------------------------------------------------------------------------------------
# THEME INSTALL
#----------------------------------------------------------------------------------------------------------------------
#
# Theme install script : install terminal themes
# By 0phoff
# MIT license
#
#----------------------------------------------------------------------------------------------------------------------
#
# Usage: 
#   sudo -E ./install-theme.sh
#
#----------------------------------------------------------------------------------------------------------------------

# Create temp folder
mkdir repos
cd repos

# Gnome-terminal theme
git clone https://github.com/arcticicestudio/nord-gnome-terminal gnome-terminal
cd ./gnome-terminal/src/sh
./nord.sh
printf '\e[1mGnome terminal theme\e[0m installed, activate it in profile preferences!\n'
cd ../../..

# Dircolors
git clone https://github.com/arcticicestudio/nord-dircolors dircolors
mv ./dircolors/src/dir_colors ~/.dir_colors
printf '\e[1mDircolors\e[0m installed!\n'

# Gedit
git clone https://github.com/arcticicestudio/nord-gedit gedit
cd gedit
./install.sh
printf '\e[1mGedit theme\e[0m installed!\n'
cd ..

# Cleanup
cd ..
rm -r repos
