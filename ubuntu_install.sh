#!/bin/bash

#
# This script was created in order to ease the installation of the current configuration on Ubuntu based systems.
# Any use of it, is at your own risk!
#
# NOTE: This has not been tested properly and make therefore brake your system!
#

# Some constants
readonly GITHUB_REPOSITORY_CONFIGURATION="https://github.com/andersro93/.dotfiles.git"
readonly GITHUB_REPOSITORY_SCRIPTS="https://github.com/andersro93/.scripts.git"

# Declare a variable containing the packages to install
PACKAGES=""

# Ask for Github password
read -p 'Add public key from Github to authorized_keys file (leave empty to skip): ' GITHUB_SSH_KEY

# Ask if to install firewall and some basic rules
read -p 'Install firewall (ufw), tarpit (fail2ban) and some basic rules: [y/N] ' INSTALL_FIREWALL

# Ask for what type of installation to perform
read -p 'Install desktop environment (i3wm): [y/N] ' INSTALL_DESKTOP

# Ask if to install Neovim
read -p 'Install neovim (advanced text editor): [y/N] ' INSTALL_NEOVIM

# Ask if to install php
read -p 'Install php (cli): [y/N] ' INSTALL_PHP

#### Start the installation
echo "Installation is starting now, please grab a coffee, this could take some time to complete... \n\n"

# Update and install dependencies for the script

echo "Finding updates... \n"
apt-get update -qq

echo "Installing updates... \n"
apt-get upgrade -y -qq

echo "Installing depdencies and some basic tools \n"
apt-get install -y -qq htop tmux git rsync neofetch curl openssh-server openssh-client

# Get configuration files and scripts
git clone $GITHUB_REPOSITORY_CONFIGURATION ~/.dotfiles
git clone $GITHUB_REPOSITORY_SCRIPTS ~/.scripts

# Symlink the .bashrc file
rm ~/.bashrc -f
ln -s ~/.dotfiles/bash/.bashrc ~/.bashrc

# Make the configuration directory for the user and fonts folder
mkdir ~/.config ~/.fonts -p

# Check if we are to install a firewall
if [[ $INSTALL_FIREWALL == "Y" || $INSTALL_FIREWALL == "y" ]]; then
    
    # Add desktop packages to the install process
    PACKAGES+=" ufw fail2ban"

fi

# Check if we are to add desktop packages to the pack
if [[ $INSTALL_DESKTOP == "Y" || $INSTALL_DESKTOP == "y" ]]; then
    
    # Add desktop packages to the install process
    PACKAGES+=" i3 i3lock i3blocks rofi feh maim dunst libnotify-bin udiskie network-manager network-manager-gnome blueman pavucontrol dbus dbus-x11 x11-server-utils compton rxvt rxvt-unicode xinit gnome-keyring ranger lm-sensors spotify-client vlc mpv livestreamer python python3 python-pip python3-pip wxmaxima firefox firefox-locale-nb freecad gimp handbrake inkscape krita obs-studio okular darktable blender steam fonts-font-awesome fonts-firacode fonts-inconsolata fonts-hack fonts-emojione flat-remix flat-remix-gtk xdotool upower gawk acpi clipit"

    # Add spotify to apt
    #apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 931FF8E79F0876134EDDBDCCA87FF9DF48BF1C90
    #echo "deb http://repository.spotify.com stable non-free" > /etc/apt/sources.list.d/spotify.list

    # Install another GTK theme
    add-apt-repository ppa:daniruiz/flat-remix --yes

    # Download Discord
    #wget -O /tmp/discord.deb "https://discordapp.com/api/download?platform=linux&format=deb"

    ## Symlink the configuration for desktop programs
    # i3 config
    mkdir -p ~/.config/i3
    ln -s ~/.dotfiles/i3/config ~/.config/i3/config
    
    # i3blocks config
    mkdir -p ~/.config/i3blocks
    ln -s ~/.dotfiles/i3blocks/config ~/.config/i3blocks/config

    # Dunst config
    mkdir -p ~/.config/dunst
    ln -s ~/.dotfiles/dunst/dunstrc ~/.config/dunst/dunstrc

    # Compton config
    ln -s ~/.dotfiles/compton/compton.conf ~/.config/compton.conf

    # Clipit config
    mkdir -p ~/.config/clipit
    ln -s ~/.dotfiles/clipit/clipitrc ~/.config/clipit/clipitrc

    # GTK Settings
    mkdir -p "~/.config/gtk-3.0"
    ln -s ~/.dotfiles/gtk-3.0/settings.ini ~/.config/gtk-3.0/settings.ini

    # Xinit config
    ln -s ~/.dotfiles/xinit/.xinitrc ~/.xinitrc

    # Xresources config
    ln -s ~/.dotfiles/xresources/.Xresources ~/.Xresources

fi

# Check if we are to install neovim packages
if [[ $INSTALL_NEOVIM == "Y" || $INSTALL_NEOVIM == "y" ]]; then
    
    # Add neovim packages to the install process
    PACKAGES+=" neovim python3-neovim python-neovim"

    # Add neovim repository
    #add-apt-repository ppa:neovim-ppa/stable --yes

fi

# Check if we are to install neovim packages
if [[ $INSTALL_PHP == "Y" || $INSTALL_PHP == "y" ]]; then
    
    # Add php packages to the install process
    PACKAGES+=" php-cli php-mbstring php-json php-curl php-zip php-gd php-bz2 php-mysql php-sqlite3 php-redis php-mongodb php-xml php-intl composer"

    # Add php repository
    #add-apt-repository ppa:ondrej/php --yes

fi


echo $PACKAGES
