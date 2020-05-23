#!/bin/sh

if [ "linux" != "$(uname | tr [:upper:] [:lower:])" ]; then
    echo "This script is only valid on Linux systems"
    exit 1
fi

# Arch systems with yay package manager
if [ $(which yay 2>/dev/null) ]; then
    yay -S textadept
    ln -fs /usr/bin/textadept /usr/local/bin/ta
    ln -fs /usr/bin/textadept-curses /usr/local/bin/ta-nox
fi

# Debian systems with apt package manager
if [ $(which apt 2>/dev/null) ]; then
    echo "TO DO!"
    exit 1
fi
