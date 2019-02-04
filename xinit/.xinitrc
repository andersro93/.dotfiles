# Load the default xrdb
if [ -f ~/.Xresources ]; then
    xrdb ~/.Xresources
fi

# Load the default x environment
if [ -f ~/.Xenvironment_default ]; then
    xrdb -merge ~/.Xenvironment_default
fi

# Start URxvt daemon
urxvtd -q -o -f

# Start compton
compton --config ~/.config/compton.conf &

# Start Gnome Keyring
dbus-update-activation-environment --systemd DISPLAY
eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
export SSH_AUTH_SOCK

# Start i3
exec i3
