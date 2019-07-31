#!/bin/bash

## 
#
# Title:        Aliases
# Description:  The purpose of this file is to assign alises to the bash environment.
# Author:       github.com/andersro93
# 
##

# Navigation related
alias ls='ls --color=auto'
alias ll='ls -l --color=auto'
alias la='ls -A --color=auto'
alias l='ls -CF --color=auto'

# Grep related
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Disk management
alias df="df -x squashfs"
alias lsblk="lsblk | grep -v loop"

# Management
alias mysql_connect='mysql --defaults-file=/etc/mysql/debian.cnf'

