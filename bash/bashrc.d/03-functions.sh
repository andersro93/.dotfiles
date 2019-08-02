#!/bin/bash

## 
#
# Title:        Functions
# Description:  The purpose of this file is to provide functions for the bash environment.
# Author:       github.com/andersro93
# 
##

## Helpers

# Small helper function that prints the current branch if working directory is within a git project
parse_git_branch() {
	BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
	if [ ! "${BRANCH}" == "" ]
	then
		echo " ${BRANCH} "
	else
		echo ""
	fi
}


# Small helper that will update the dotfiles using git
update_dotfiles() {

    # Execute git pull in the dotfiles folder
    git -C ~/.dotfiles pull
}


# Small helper that "deploys" the dotfiles configuration
deploy_dotfiles() {

    # Create directories for the config files
    mkdir -p ~/.config

    # i3 setup
    mkdir -p ~/.config/i3
    rm ~/.config/i3/config -f
    ln -s ~/.dotfiles/i3/config ~/.config/i3/config

    # i3blocks setup
    mkdir -p ~/.config/i3blocks
    rm ~/.config/i3blocks/config -f
    rm ~/.config/i3blocks/blocks -f
    ln -s ~/.dotfiles/i3blocks/config ~/.config/i3blocks/config
    ln -s ~/.dotfiles/i3blocks/blocks ~/.config/i3blocks/blocks

    # Dunst
    mkdir -p ~/.config/dunst
    rm ~/.config/dunst/dunstrc -f
    ln -s ~/.dotfiles/dunst/dunstrc ~/.config/dunst/dunstrc

    # Redshift
    rm ~/.config/redshift -Rf
    ln -s ~/.dotfiles/redshift ~/.config/redshift

    # Neovim
    rm ~/.config/nvim -Rf
    ln -s ~/.dotfiles/nvim ~/.config/nvim

    # Bash
    rm ~/.bashrc ~/.bash_profile -f
    ln -s ~/.dotfiles/bash/.bashrc ~/.bashrc
    ln -s ~/.dotfiles/bash/.bash_profile ~/.bash_profile

    # Compton
    rm ~/.config/compton.conf -f
    ln -s ~/.dotfiles/compton/compton.conf ~/.config/compton.conf

    # GTK 3.0
    mkdir -p ~/.config/gtk-3.0
    rm ~/.config/gtk-3.0/settings.ini -f
    ln -s ~/.dotfiles/gtk-3.0/settings.ini ~/.config/gtk-3.0/settings.ini

    # Tmux
    rm ~/.tmux.conf -f
    ln -s ~/.dotfiles/tmux/.tmux.conf ~/.tmux.conf

    # Xresources
    rm ~/.Xresources -f
    ln -s ~/.dotfiles/xresources/.Xresources ~/.Xresources

    # Xinit
    rm ~/.xinitrc -f
    ln -s ~/.dotfiles/xinit/.xinitrc ~/.xinitrc
}

