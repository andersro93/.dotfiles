#!/bin/bash

## 
#
# Title:        .bashrc
# Description:  The purpose of this file is to source the configuration files for the bash environment.
# Author:       github.com/andersro93
# 
##

# Check if we are in interactive mode, if so, skip all sourcing
case $- in
    *i*) ;;
    *) return;;
esac

# Source all configuration files
for file in ~/.dotfiles/bash/bashrc.d/*.sh; do source $file; done

