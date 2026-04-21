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

