#!/bin/bash

## 
#
# Title:        Environment
# Description:  The purpose of this file is to determine several environment variables that are used throughout the bash environment.
# Author:       github.com/andersro93
# 
##

## Basic

# Set Term mode
export TERM=xterm-256color

# Set the default editor
export EDITOR=nvim

# Opt out of M$ "telemetry" for dot.net scripts
export DOTNET_CLI_TELEMETRY_OPTOUT=1

# Set arch variable
export ARCH=amd64


## Configurations
export readonly SESSION_TYPE_LOCAL="local/bash"
export readonly SESSION_TYPE_SSH="remote/ssh"

# Loot configuration
export readonly LOOT_REMOTE_SERVER="loot"
export readonly LOOT_REMOTE_PATH="/mnt/gdrive_public/Loot"
export readonly LOOT_PUBLIC_URL="https://loot.ros-nett.com"

## PATHS

# Scripts
export PATH=$PATH:$HOME/.dotfiles/bash/scripts

# Composer
export PATH=$PATH:$HOME/.config/composer/vendor/bin

# Rust
export PATH=$PATH:$HOME/.cargo/bin

# Yarn
export PATH=$PATH:$HOME/.yarn/bin

# Snap path
export PATH=$PATH:/snap/bin

# Dotnet path
export PATH=$PATH:$HOME/.dotnet
export PATH=$PATH:$HOME/.dotnet/tools

# Home binaries
export PATH=$PATH:$HOME/.programs
export PATH=$PATH:$HOME/bin
export PATH=$PATH:$HOME/usr/local/bin
export PATH=$PATH:$HOME/.local/bin

# GPG Configuration
export GPG_TTY=$(tty)


## Terminal colors
black=$(tput -Txterm setaf 0)
red=$(tput -Txterm setaf 1)
green=$(tput -Txterm setaf 2)
yellow=$(tput -Txterm setaf 3)
dk_blue=$(tput -Txterm setaf 4)
pink=$(tput -Txterm setaf 5)
lt_blue=$(tput -Txterm setaf 6)
bold=$(tput -Txterm bold)
reset=$(tput -Txterm sgr0)


