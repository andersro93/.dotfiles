#!/bin/bash

## 
#
# Title:        Functions
# Description:  The purpose of this file is to provide functions for the bash environment.
# Author:       github.com/andersro93
# 
##

## Tools

# Simple loot script that uploads the given to loot to a loot server
loot() {

    # Some readonly constants
    MODE_RAW="RAW"
    MODE_FILE="FILE"

    # Detect the mode to use, file copying or pipeing
    if [ -z "$1" ]; then
        MODE=$MODE_RAW
    else
        INPUT_FILE="$1"
        MODE=$MODE_FILE
    fi

    # Retrieve an UUID that we can use for filename
    RANDOM_FILENAME="$(cat /proc/sys/kernel/random/uuid)"

    # Determine which transfer mode to use
    if [[ $MODE = "$MODE_FILE" ]]; then

        # Get the filename and extension from the original path
        FILENAME="$INPUT_FILE"
        EXTENSION="$(echo "$FILENAME" | rev | cut -d '.' -f1 | rev )"

    elif [[ $MODE = "$MODE_RAW" ]]; then
    
        # Create a tmp filepath
        EXTENSION="txt"
        FILENAME="/tmp/loot-tmp-$RANDOM_FILENAME.$EXTENSION"

        # Touch temp file
        touch "$FILENAME"

        # Write a tmp file
        while read -r CMD; do
            echo "$CMD" >> "$FILENAME"
        done

    else
        echo "Error: Invalid mode"
        exit 1
    fi

    # Get the current year
    readonly YEAR=`date +"%Y"`

    # Calculate the final path
    readonly REMOTE_FILE="$YEAR/$RANDOM_FILENAME.$EXTENSION"

    # Make the copying to the S3 Store
    rsync --chmod=444 "$FILENAME" "$LOOT_REMOTE_SERVER:$LOOT_REMOTE_PATH/$REMOTE_FILE"

    # Get the URL
    readonly URL="$LOOT_PUBLIC_URL/$REMOTE_FILE"

    # Delete the tempromary file if raw mode was used
    if [[ $MODE -eq $MODE_RAW ]]; then
        rm FILENAME 2> /dev/null 
    fi

    # Put the URL on the clipboard if xclip is installed
    echo "$URL" | clipit

    # Print the URL
    echo "$URL"
}

# Simple script that enables easier screenshotting
screenshot() {

    # Some readonly constants
    MODE_SELECTION="selection"
    MODE_WINDOW="window"
    TMP_DIRECTORY="/tmp"
    TMP_FILE="$TMP_DIRECTORY/$(cat /proc/sys/kernel/random/uuid).png"

    # Detect what mode to use
    if [[ $# -eq 0 ]]; then
    
        # Take screenshot of entire screen(s)
        maim -m 10 "$TMP_FILE"

    elif [[ $1 -eq "$MODE_SELECTION" ]]; then

        # Take screenshot of the selected area
        maim -s -m 10 "$TMP_FILE"

    elif [[ $1 -eq "$MODE_WINDOW" ]]; then

        # Take screenshot of the current window
        maim -i -m 10 "$TMP_FILE"
    else

        echo "Error: unknown mode was specified"
    fi

    # Use the loot script to upload file to remote server
    loot "$TMP_FILE"

    # Remove the temp file
    rm "$TMP_FILE"

    # Send notification after all is done
    notify-send 'Printscreen' 'Screenshot saved to loot' -u low -t 2000

}

# Simple script that allows to control the current playing media
media() {

    # Define the different modes
    ACTION_TOGGLE="toggle"
    ACTION_NEXT="next"
    ACTION_PREV="prev"
    ACTION_SEEK_FORWARD="seek_forward"
    ACTION_SEEK_BACKWARD="seek_backward"

    # Icons for the actions
    ICON_PLAY="gtk-media-play-ltr"
    ICON_PAUSE="gtk-media-pause"
    ICON_NEXT="gtk-media-next-ltr"
    ICON_PREV="gtk-media-previous-ltr"
    ICON_SEEK_FORWARD="gtk-media-forward-ltr"
    ICON_SEEK_REWIND="gtk-media-rewind-ltr"

    # Some configuration variables
    SEEK_STEPS=5

    # Notification settings
    TIMEOUT="800"
    URGENCY="low"

    # Check if play/pause
    if [ "$1" == "$ACTION_TOGGLE" ]; then

        # Toggle playback
        playerctl play-pause

        # Wait until the daemon gets to do its job
        sleep 0.1

        # Determine the new status of the player
        STATUS=`playerctl status`

        if [ $STATUS == "Playing" ]; then

            # Send a notification
            notify-send "Media control" "Playback started" --expire-time "$TIMEOUT" --urgency "$URGENCY" --icon "$ICON_PLAY"

        elif [ $STATUS == "Paused" ]; then

            # Send a notification
            notify-send "Media control" "Playback paused" --expire-time "$TIMEOUT" --urgency "$URGENCY" --icon "$ICON_PAUSE"

        fi

    elif [ "$1" == "$ACTION_NEXT" ]; then

        # Next song
        playerctl next

        # Send a notification
        notify-send "Media control" "Next song" --expire-time "$TIMEOUT" --urgency "$URGENCY" --icon "$ICON_NEXT"

    elif [ "$1" == "$ACTION_PREV" ]; then

        # Previous song
        playerctl previous

        # Send a notification
        notify-send "Media control" "Previous song" --expire-time "$TIMEOUT" --urgency "$URGENCY" --icon "$ICON_PREV"  

    elif [ "$1" == "$ACTION_SEEK_FORWARD" ]; then

        # Seek forward
        playerctl position "+$SEEK_STEPS"

        # Send a notification
        notify-send "Media control" "Seeking forward" --expire-time "$TIMEOUT" --urgency "$URGENCY" --icon "$ICON_SEEK_FORWARD"  

    elif [ "$1" == "$ACTION_SEEK_BACKWARD" ]; then

        # Seek backward
        playerctl position "-$SEEK_STEPS"

        # Send a notification
        notify-send "Media control" "Seeking backwards" --expire-time "$TIMEOUT" --urgency "$URGENCY" --icon "$ICON_SEEK_REWIND"
    else

        echo "Invalid mode"

    fi

    # Kill i3blocks (forces update)
    pkill -RTMIN+3 i3blocks
}


# Volume change script
volume() {

    # Declare the various types of actions
    ACTION_UP="up"
    ACTION_DOWN="down"
    ACTION_MUTE="mute"
    ACTION_MIC_MUTE="mic_mute"

    # Set some of the configuration variables
    STEP=10
    TIMEOUT=900

    # Get the current volume
    VOL_OLD=$(amixer -D pulse sget Master | grep 'Left:' | awk -F'[][%]' '{ print $2 }')

    if [ "$1" == "$ACTION_UP" ]; then

        # Calculate the next volume
        VOL_NEW=`expr $VOL_OLD + $STEP`
    
        # Check if we are above maximum
        if [ $VOL_NEW -ge 100 ]; then

            # Set the new level to 100%
            VOL_NEW=100

        fi

        # Set the volume
        pactl set-sink-volume @DEFAULT_SINK@ "$VOL_NEW%"

        # Notify the user
        notify-send 'Volume' --expire-time $TIMEOUT --urgency low --hint int:value:$VOL_NEW -i audio-volume-medium 'Volume changed'
 

    elif [ "$1" == "$ACTION_DOWN" ]; then

        # Calculate the next volume
        VOL_NEW=`expr $VOL_OLD - $STEP`

        # Check if we are below 0
        if [ $VOL_NEW -le 0 ]; then

            # Set the volume to 0
            VOL_NEW=0

        fi

        # Set the volume
        pactl set-sink-volume @DEFAULT_SINK@ "$VOL_NEW%"

        # Notify the user
        notify-send 'Volume' --expire-time $TIMEOUT --urgency low --hint int:value:$VOL_NEW -i audio-volume-medium 'Volume changed'
 

    elif [ "$1" == "$ACTION_MUTE" ]; then

        # Toggle the mute
        pactl set-sink-mute @DEFAULT_SINK@ toggle

        # Notify the user
        notify-send 'Volume' --expire-time $TIMEOUT --urgency low -i audio-volume-muted "Toggling mute"

    elif [ "$1" == "$ACTION_MIC_MUTE" ]; then

        # Toggle the default capture device
        amixer set Capture toggle

        # Notify the user
        notify-send 'Volume' --expire-time $TIMEOUT --urgency low -i audio-volume-muted "Toggling mute for input device"

    else
        # Invalid action was specified
        echo "Invalid action $1"
    
        # Notify the user
        notify-send 'Volume' --expire-time $TIMEOUT --urgency critical -i error "Invalid action was specified: $1"

    fi

    # Update the i3blocks
    pkill -RTMIN+2 i3blocks
}

# Simple script that allows for changing the brightness
brightness() {

    # Set some of the configuration variables
    STEP=10
    TIMEOUT=900

    # Check if the user wants to increase the brightness
    if [ "$1" == "up" ]; then

        # Try to increase the brightness
        xbacklight -inc "$STEP"

    elif [ "$1" == "down" ]; then

        # Try to decrease the brightness
        xbacklight -dec "$STEP"

    else
        # Invalid action was specified
        echo "Invalid action: $1"
    fi

    # Get the new brightness
    BRIGHTNESS=`xbacklight -get`

    # Notify the user
    notify-send 'Brightness' --expire-time $TIMEOUT --urgency low --hint int:value:$BRIGHTNESS -i display 'Brightness changed'

}

## Helpers

# Small helper function that prints the current branch if working directory is within a git project
parse_git_branch() {
	BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
	if [ ! "${BRANCH}" == "" ]
	then
		echo " ${BRANCH} "
	else
		echo ""
	fi
}


# Small helper that will update the dotfiles using git
update_dotfiles() {

    # Execute git pull in the dotfiles folder
    git -C ~/.dotfiles pull
}


# Small helper that "deploys" the dotfiles configuration
deploy_dotfiles() {

    # Create directories for the config files
    mkdir -p ~/.config

    # i3 setup
    mkdir -p ~/.config/i3
    rm ~/.config/i3/config -f
    ln -s ~/.dotfiles/i3/config ~/.config/i3/config

    # i3blocks setup
    mkdir -p ~/.config/i3blocks
    rm ~/.config/i3blocks/config -f
    rm ~/.config/i3blocks/blocks -f
    ln -s ~/.dotfiles/i3blocks/config ~/.config/i3blocks/config
    ln -s ~/.dotfiles/i3blocks/blocks ~/.config/i3blocks/blocks

    # Dunst
    mkdir -p ~/.config/dunst
    rm ~/.config/dunst/dunstrc -f
    ln -s ~/.dotfiles/dunst/dunstrc ~/.config/dunst/dunstrc

    # Redshift
    rm ~/.config/redshift -Rf
    ln -s ~/.dotfiles/redshift ~/.config/redshift

    # Neovim
    rm ~/.config/nvim -Rf
    ln -s ~/.dotfiles/nvim ~/.config/nvim

    # Bash
    rm ~/.bashrc ~/.bash_profile -f
    ln -s ~/.dotfiles/bash/.bashrc ~/.bashrc
    ln -s ~/.dotfiles/bash/.bash_profile ~/.bash_profile

    # Compton
    rm ~/.config/compton.conf -f
    ln -s ~/.dotfiles/compton/compton.conf ~/.config/compton.conf

    # GTK 3.0
    mkdir -p ~/.config/gtk-3.0
    rm ~/.config/gtk-3.0/settings.ini -f
    ln -s ~/.dotfiles/gtk-3.0/settings.ini ~/.config/gtk-3.0/settings.ini

    # Tmux
    rm ~/.tmux.conf -f
    ln -s ~/.dotfiles/tmux/.tmux.conf ~/.tmux.conf

    # Xresources
    rm ~/.Xresources -f
    ln -s ~/.dotfiles/xresources/.Xresources ~/.Xresources

    # Xinit
    rm ~/.xinitrc -f
    ln -s ~/.dotfiles/xinit/.xinitrc ~/.xinitrc
}

