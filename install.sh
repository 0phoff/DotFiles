#!/usr/bin/env bash
#----------------------------------------------------------------------------------------------------------------------
# DOTFILES INSTALL SCRIPT
#----------------------------------------------------------------------------------------------------------------------
#
# Dotfiles Install Script : This script will create the appropriate simlinks to install all of the configuration files
# By 0phoff
# GPL license
#
#----------------------------------------------------------------------------------------------------------------------
#
# Usage: 
#   ./install.sh [folder_name]
#
# Dry run:
#   DEBUG=echo ./install.sh [folder_name]
#
#----------------------------------------------------------------------------------------------------------------------

# Variables
HOME=$HOME
SCRIPT="$HOME/bin"

# Check argument
if [ $# -le 0 ]; then
    echo 'Enter folder to install'
    exit 1
fi

if [[ "$1" =~ ^scripts/?$ ]]; then
    $DEBUG mkdir -p $SCRIPT
    for f in $PWD/scripts/*.sh
    do
        base=$(basename $f)
        case "$base" in
            tmuxCreator.sh)
                $DEBUG ln -sf $f $SCRIPT/tmc
                ;;
            rosinit.sh)
                $DEBUG ln -sf $f $SCRIPT/$base
                ;;
            brightness.sh)
                $DEBUG sudo ln -sf $f /usr/sbin/${base%.*}
                ;;
            *)
                $DEBUG ln -sf $f $SCRIPT/${base%.*}
                ;;
        esac
    done
    if [ -z ${DEBUG+x} ]; then
    	echo 'Installed scripts'
    fi
elif [[ "$1" =~ ^rc/?$ ]]; then
    #$DEBUG ln -sf $PWD/rc/agignore          $HOME/.agignore
    $DEBUG ln -sf $PWD/rc/bashrc            $HOME/.bashrc
    $DEBUG ln -sf $PWD/rc/dir_colors        $HOME/.dir_colors
    $DEBUG ln -sf $PWD/rc/gitconfig         $HOME/.gitconfig
    $DEBUG ln -sf $PWD/rc/gitignore         $HOME/.gitignore
    $DEBUG ln -sf $PWD/rc/profile           $HOME/.profile
    $DEBUG ln -sf $PWD/rc/Xresources        $HOME/.Xresources
    $DEBUG ln -sf $PWD/rc/fzf.bashrc        $HOME/.config/fzf.bashrc
    $DEBUG cp -n $PWD/rc/local.bashrc       $HOME/.config/local.bashrc
    if [ -z ${DEBUG+x} ]; then
        echo 'Installed config files'
	echo "edit '$HOME/.config/local.bashrc' to your likings"
    fi
elif [[ "$1" =~ ^tmux/?$ ]]; then
    $DEBUG mkdir -p $HOME/.tmux
    $DEBUG ln -sf $PWD/tmux/tmux.conf            $HOME/.tmux.conf
    $DEBUG ln -sf $PWD/tmux/settings.tmux        $HOME/.tmux/settings.tmux
    $DEBUG ln -sf $PWD/tmux/keymap.tmux          $HOME/.tmux/keymap.tmux
    $DEBUG ln -sf $PWD/tmux/status-ascii.tmux	 $HOME/.tmux/status-ascii.tmux
    $DEBUG ln -sf $PWD/tmux/status-power.tmux	 $HOME/.tmux/status-power.tmux
    if [ -z ${DEBUG+x} ]; then
        echo 'Installed tmux config'
    fi
elif [[ "$1" =~ ^vim/?$ ]]; then
    $DEBUG mkdir -p $HOME/.config/nvim
    $DEBUG ln -sf $PWD/vim/neovim.vim            $HOME/.config/nvim/init.vim
    $DEBUG ln -sf $PWD/vim/ftdetect              $HOME/.config/nvim/ftdetect
    $DEBUG ln -sf $PWD/vim/ftplugin              $HOME/.config/nvim/ftplugin
    $DEBUG ln -sf $PWD/vim/scripts               $HOME/.config/nvim/scripts
    $DEBUG ln -sf $PWD/vim/syntax                $HOME/.config/nvim/syntax

    # Not sure why these files get created...
    $DEBUG rm -f $PWD/vim/ftdetect/ftdetect
    $DEBUG rm -f $PWD/vim/ftplugin/ftplugin
    $DEBUG rm -f $PWD/vim/scripts/scripts
    $DEBUG rm -f $PWD/vim/syntax/syntax
    if [ -z ${DEBUG+x} ]; then
        echo "Installed neovim setup\nPlease install vim-plug manually and run :PlugInstall in the editor\nhttps://github.com/junegunn/vim-plug"
    fi
elif [[ "$1" =~ ^fonts/?$ ]]; then
    $DEBUG mkdir -p $HOME/.local/share/fonts
    $DEBUG ln -sf $PWD/fonts /home/top/.local/share/fonts/dotfiles
    fc-cache -fv
    if [ -z ${DEBUG+x} ]; then
        echo 'Installed terminal fonts. Select the right one in the settings of your terminal emulator'
    fi
elif [[ "$1" =~ ^openbox/?$ ]]; then
    $DEBUG rm -rf $PWD/openbox/dunst
    $DEBUG ln -sf $PWD/openbox/dunst 			$HOME/.config/dunst
    $DEBUG rm -rf $PWD/openbox/obmenu-generator
    $DEBUG ln -sf $PWD/openbox/obmenu-generator		$HOME/.config/obmenu-generator
    $DEBUG rm -rf $PWD/openbox/openbox
    $DEBUG ln -sf $PWD/openbox/openbox 			$HOME/.config/openbox
    $DEBUG rm -rf $PWD/openbox/tint2
    $DEBUG ln -sf $PWD/openbox/tint2 			$HOME/.config/tint2
    $DEBUG sudo ln -sf $PWD/openbox/oblogout.conf	/etc/oblogout.conf
    if [ -z ${DEBUG+x} ]; then
        echo 'Openbox config files installed'
    fi
fi
