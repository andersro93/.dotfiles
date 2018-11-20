#!/bin/bash

# Install yay (aur helper)
sudo pacman -S yay

# Minimum packages
packages="vim zsh powerline tmux neofetch sl toilet rsync irssi"

# Ask for installing desktop packages
read -p "Install i3 desktop with various packages? Y/n" option
echo
case "$option" in
    y|Y) echo "Yes";
	packages="$packages i3 i3lock i3blocks network-manager-applet blueman feh rofi terminator compton"
    n|N ) echo "No" ;;
esac
echo

# Install development tools
read -p "Install development tools? Y/n" option
echo
case "$option" in
    y|Y) echo "Yes";
	# PHP Tools
	read -p "Install PHP development tools? Y/n" option2
	echo
	case "$option2" in
		y|Y) echo "Yes"
			packages="$packages php php-gd php-sqlite php-zip php-redis php-pgsql php-imap php-intl php-mongodb composer"
		n|N echo "No" ;;
	esac
	echo
	
	# NodeJS
	read -p "Install Nodejs/NPM development tools? Y/n" option2
	echo
	case "$option2" in
		y|Y) echo "Yes"
			packages="$packages nodejs npm"
		n|N echo "No" ;;
	esac
	echo

	# Python
	read -p "Install Python development tools? Y/n" option2
	echo
	case "$option2" in
		y|Y) echo "Yes"
			packages="$packages python python-pip"
		n|N echo "No" ;;
	esac
	echo

	# Dotnet SDK
	read -p "Install Dotnet development tools? Y/n" option2
	echo
	case "$option2" in
		y|Y) echo "Yes"
			packages="$packages dotnet-sdk"
		n|N echo "No" ;;
	esac
	echo

    n|N ) echo "No" ;;
esac
echo

# Install Media apps
read -p "Install various media packages (vlc, mpv etc..)? Y/n" option
echo
case "$option" in
    y|Y) echo "Yes";
	packages="$packages vlc mpv pavucontrol mpd playerctl spotify tizonia-all youtube-dl handbrake"
    n|N ) echo "No" ;;
esac
echo


# Finally make the installation
sudo yay -S $packages
