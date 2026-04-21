#!/bin/bash

## 
#
# Title:        Aliases
# Description:  The purpose of this file is to assign alises to the bash environment.
# Author:       github.com/andersro93
# 
##

# Navigation related - cross-platform ls (BSD on macOS, GNU on Linux)
if ls --color=auto &>/dev/null 2>&1; then
    alias ls='ls --color=auto'
    alias ll='ls -l --color=auto'
    alias la='ls -A --color=auto'
    alias l='ls -CF --color=auto'
else
    alias ls='ls -G'
    alias ll='ls -lG'
    alias la='ls -AG'
    alias l='ls -CFG'
fi

# Grep related
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Disk management
if df --version &>/dev/null 2>&1; then
    alias df="df -x squashfs"
fi
if command -v lsblk &>/dev/null; then
    alias lsblk="lsblk | grep -v loop"
fi

# Management
alias mysql_connect='mysql --defaults-file=/etc/mysql/debian.cnf'

