#!/bin/sh

set -e

# This only works on systems with pacman since Yay is a pacman frontend.
if ! [ $(which pacman 2>/dev/null) ]; then
    echo "Couldn't detect Manjaro system, quitting"
    exit 1
fi

pushd $HOME/code
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
popd
