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

# Set color mode
export TERM=xterm-256color

# Set the default editor
export EDITOR=nvim

# Opt out of M$ "telemetry" for dot.net
export DOTNET_CLI_TELEMETRY_OPTOUT=1

# Set arch variable
export ARCH=amd64

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

# Check if script library is "installed"
if [[ -f "$HOME/.scripts/config" ]]; then
    
    # Source the configuration for the scripts
    source "$HOME/.scripts/config"

    # Export a path with the scripts
    export PATH=$PATH:$HOME/.scripts/path
fi

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

# Management
alias mysql_connect='mysql --defaults-file=/etc/mysql/debian.cnf'

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

### Bash completion ###
# Basic completion
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi


### Functions ###

# Get the current git branch
function parse_git_branch() {
	BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
	if [ ! "${BRANCH}" == "" ]
	then
		echo " ${BRANCH} "
	else
		echo ""
	fi
}

### Terminal prompt ###
export PS1="\[$bold\]\[$green\]\u\[$yellow\]@\[$green\]\h \[$bold\]\[$pink\]\w \[$dk_blue\]\[$bold\]\`parse_git_branch\`\[$black\]\[$bold\]\\$\[\e[m\] "

