#!/bin/bash

## 
#
# Title:        Prompt
# Description:  The purpose of this file is to provide a prompt for the bash environment.
# Author:       github.com/andersro93
# 
##

# Main prompt
export PS1="\[$bold\]\[$green\]\u\[$yellow\]@\[$green\]\h \[$bold\]\[$pink\]\w \[$dk_blue\]\[$bold\]\`parse_git_branch\`\[$black\]\[$bold\]\\$\[\e[m\] "

# Continuation prompt
export PS2="> "

# Selection prompt
export PS3="#? "

# Debug prompt
export PS4="++"

