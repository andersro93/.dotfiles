###############################################
#
# Bashrc Configuration
#
# Author: Anders Refsdal Olsen (@andersro93)
# Manual: $(man bash)
#
###############################################

# First, check if in interactive mode, if so, skip the file
case $- in
    *i*) ;;
      *) return;;
esac

### General settings ###

# Set the default editor
export EDITOR=vim

# Check window size after each command
shopt -s checkwinsize

### History ###

# History size
HISTSIZE=25000
HISTFILESIZE=20000

# Ignore duplicate and empty lines
HISTCONTROL=ignoreboth

# Append to history instead of overwrite
shopt -s histappend


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


### Aliases ###

# Navigation related
alias ls='ls --color=auto'
alias ll='ls -l --color=auto'
alias la='ls -A --color=auto'
alias l='ls -CF --color=auto'

# Grep related
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

### Terminal colors ###
black=$(tput -Txterm setaf 0)
red=$(tput -Txterm setaf 1)
green=$(tput -Txterm setaf 2)
yellow=$(tput -Txterm setaf 3)
dk_blue=$(tput -Txterm setaf 4)
pink=$(tput -Txterm setaf 5)
lt_blue=$(tput -Txterm setaf 6)
bold=$(tput -Txterm bold)
reset=$(tput -Txterm sgr0)


### Terminal functions ###
__has_parent_dir () {
    # Utility function so we can test for things like .git/.hg without firing up a
    # separate process
    test -d "$1" && return 0;

    current="."
    while [ ! "$current" -ef "$current/.." ]; do
        if [ -d "$current/$1" ]; then
            return 0;
        fi
        current="$current/..";
    done

    return 1;
}

__vcs_name() {
    if [ -d .svn ]; then
	    echo " (svn)";
    elif __has_parent_dir ".git"; then
	    echo " ($(__git_ps1 'git %s'))";
    elif __has_parent_dir ".hg"; then
	    echo " (hg $(hg branch))"
    fi
}


### Bash completion ###
# Basic completion
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Git completion
## Install with this: git clone https://github.com/magicmonty/bash-git-prompt.git ~/.bash-git-prompt --depth=1
if [ -f ~/.dotfiles/bash/bash-git-prompt/gitprompt.sh ]; then
    GIT_PROMPT_ONLY_IN_REPO=1
    source ~/.dotfiles/bash/bash-git-prompt/gitprompt.sh
fi

### Terminal prompt ###
export PS1='\n\[$bold\]\[$black\]\[$dk_blue\]\A\[$black\] - \[$green\]\u\[$yellow\]@\[$green\]\h\[$black\] - \[$pink\]\w\[$black\]\[\033[0;33m\]$(__vcs_name) \[\033[00m\]\[$reset\]\n\[$reset\]\$ '

