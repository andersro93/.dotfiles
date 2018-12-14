# Load the default xrdb
if [ -f ~/.Xresources ]; then
    xrdb ~/.Xresources
fi

# Load the default x environment
if [ -f ~/.Xenvironment_default ]; then
    xrdb -merge ~/.Xenvironment_default
fi

# Start i3
exec i3
