#!/bin/bash

## 
#
# Title:        Init
# Description:  The purpose of this file is to assign some initial values the bash environment.
# Author:       github.com/andersro93
# 
##

## History

# History size
HISTSIZE=25000
HISTFILESIZE=20000

# Ignore duplicate and empty lines
HISTCONTROL=ignoreboth

# Append to history instead of overwrite
shopt -s histappend


## Completion

# Basic completion
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi


