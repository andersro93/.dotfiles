#!/bin/bash

## 
#
# Title:        Configuration
# Description:  The purpose of this file is to configure the bash environment.
# Author:       github.com/andersro93
# 
##

##
#
# SSH Session configuration
# 
# Is used to configure the shell to automatically launch tmux if in an ssh connection
#
##

# Assume that we are in a local bash shell, and then try to prove otherwise
SESSION_TYPE=$SESSION_TYPE_LOCAL

# Check if SSH environment variables has been set
if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
    SESSION_TYPE=$SESSION_TYPE_SSH
else
    # Check if the process id matches one that is of type SSH
    case $(ps -o comm= -p $PPID) in
        sshd|*/sshd) SESSION_TYPE=$SESSION_TYPE_SSH;;
    esac
fi

# If we are in an SSH session 
if [[ "$SESSION_TYPE" == "$SESSION_TYPE_SSH" ]]; then

    # Check if TMUX is not running and installed on the machine
    if [ -z "$TMUX" ] && [ -x "/usr/bin/tmux" ]; then

        # Create or attach to the main tmux session
        /usr/bin/tmux new-session -A -s main
    fi
fi

