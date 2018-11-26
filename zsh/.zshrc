####################################################################################################
#
# ZSH configuration
#
# Author: Anders Refsdal Olsen (@andersro93)
# Manual: https://github.com/robbyrussell/oh-my-zsh/wiki
#

# ZSH Install dir
export ZSH=/home/anders/.oh-my-zsh

# Environment variables

# Theme
ZSH_THEME="af-magic"

### PATHS ###

# Composer
export PATH=$PATH:$HOME/.config/composer/vendor/bin

# Rust
export PATH=$PATH:$HOME/.cargo/bin

# Snap path
export PATH=$PATH:/snap/bin

# Home binaries
export PATH=$PATH:$HOME/.programs
export PATH=$PATH:$HOME/bin
export PATH=$PATH:$HOME/usr/local/bin
export PATH=$PATH:$HOME/.local/bin

# Development path
export PATH=$PATH:/usr/lib/google-cloud-sdk/platform/google_appengine

# GPG Configuration
export GPG_TTY=$(tty)

# Scaling
export GDK_SCALE=2

### Advanced config ###

# Command auto-correction.
ENABLE_CORRECTION="true"

# Display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Fix C-S and C-Q in terminals
stty -ixon

# Command execution time format
HIST_STAMPS="dd/mm/yyyy"

# Plugins
plugins=(
  git
  laravel
)

# Source file
source $ZSH/oh-my-zsh.sh

# Man location
export MANPATH="/usr/local/man:$MANPATH"

# Language
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LANGUAGE=en_US.UTS-8

# Compilation flags
export ARCHFLAGS="-arch x86_64"

# SSH Key
export SSH_KEY_PATH="~/.ssh/rsa_id"

# Commands to run during start
neofetch
