# Load the default xrdb
if [ -f ~/.Xresources ]; then
    xrdb ~/.Xresources
fi

# Load the default x environment
if [ -f ~/.Xenvironment_default ]; then
    xrdb -merge ~/.Xenvironment_default
fi

# Start clipboard helper
autocutsel -f

# Start compton
compton --config ~/.config/compton.conf &

# Start Pulseaudio
start-pulseaudio-x11

# Start i3
exec dbus-launch --autolaunch=$(cat /var/lib/dbus/machine-id) i3
